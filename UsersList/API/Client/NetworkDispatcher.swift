//
//  NetworkDispatcher.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    @discardableResult func dispatch(request: RequestProtocol, onSuccess: @escaping (Data)->(), onError: @escaping (Error)->()) -> URLSessionDataTask?
}

class URLSessionNetworkDispatcher: NetworkDispatcher {
    static let instance = URLSessionNetworkDispatcher()
    private init() {}
    private var acceptableStatusCodes: [Int] { return Array(200..<300) }
    
    @discardableResult public func dispatch(request: RequestProtocol, onSuccess: @escaping (Data)->(), onError: @escaping (Error)->()) -> URLSessionDataTask? {
        guard let url = URL(string: request.path) else {
            onError(ConnError.invalidURL)
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpShouldUsePipelining = true
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let weakSelf = self else {
                return
            }
            
            if let error = error {
                onError(error)
                return
            }
            
            guard let _data = data else {
                onError(ConnError.noData)
                return
            }
            
            if let response = response as? HTTPURLResponse, !weakSelf.acceptableStatusCodes.contains(response.statusCode) {
                onError(ConnError.error(message: error?.localizedDescription ?? "", code: response.statusCode))
                return
            }
            
            onSuccess(_data)
        }
        
        dataTask.resume()
        return dataTask
    }
}
