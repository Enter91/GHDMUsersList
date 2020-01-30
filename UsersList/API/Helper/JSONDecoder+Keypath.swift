//
//  JSONDecoder+Keypath.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data, keyPath: String?) throws -> T {
        guard let keyPath = keyPath else {
            do {
                return try decode(type, from: data)
            } catch {
                throw error
            }
        }
        
        let toplevel = try JSONSerialization.jsonObject(with: data)
        if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
            do {
                let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
                return try decode(type, from: nestedJsonData)
            } catch {
                throw ConnError.error(message: "Decoding Error", code: nil)
            }
        } else {
            throw ConnError.error(message: "Decoding Error", code: nil)
        }
    }
}
