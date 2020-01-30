//
//  Request.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var path: String {get set}
    var method: HTTPMethod {get}
    var params: [String: Any]? {get set}
    var dataTask: URLSessionDataTask? {get set}
    var keyPath: String? {get}
    
    func cancel()
}

class Request<T: Decodable>: RequestProtocol {
    var path: String
    var method: HTTPMethod
    var params: [String: Any]?
    var keyPath: String?
    
    var dataTask: URLSessionDataTask?
    
    init(path: String, method: HTTPMethod = .get, params: [String: Any]? = nil, keyPath: String? = nil) {
        self.path = path
        self.method = method
        self.params = params
        self.keyPath = keyPath
    }
}

extension Request {
    func cancel() {
        dataTask?.cancel()
    }
    
    var state: URLSessionDataTask.State? {
        return dataTask?.state
    }
    
    func execute(onSuccess: @escaping (T) -> Void, onError: ((Error) -> Void)? = nil) {
        dataTask = URLSessionNetworkDispatcher.instance.dispatch(
            request: self,
            onSuccess: { [weak self] (responseData: Data) in
                guard let weakSelf = self else {
                    DispatchQueue.main.async {
                        onError?(ConnError.unknownError)
                    }
                    return
                }
                
                if weakSelf.state == .canceling {
                    DispatchQueue.main.async {
                        onError?(ConnError.cancelling)
                    }
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: responseData, keyPath: weakSelf.keyPath)
                    DispatchQueue.main.async {
                        onSuccess(result)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        onError?(error)
                    }
                }
            },
            onError: { (error: Error) in
                DispatchQueue.main.async {
                    onError?(error)
                }
        })
    }
}
