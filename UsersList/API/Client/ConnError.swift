//
//  ConnError.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import Foundation

enum ConnError: Error {
    case invalidURL
    case noData
    case unknownError
    case cancelling
    case error(message: String, code: Int?)
}

extension ConnError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error(let message, _):
            return message
        default:
            return nil
        }
    }
    
    public var code: Int? {
        switch self {
        case .error(_, let code):
            return code
        default:
            return nil
        }
    }
}
