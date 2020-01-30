//
//  UserProtocol.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import Foundation

enum UserSource: String {
    case github = "GitHub"
    case dailymotion = "DailyMotion"
    
    var labelString: String {
        switch self {
        case .github:
            return "Użytkownik GitHuba"
        case .dailymotion:
            return "Użytkownik DailyMotion"
        }
    }
}

protocol User {
    var name: String! {get}
    var avatar: URL? {get}
    var source: UserSource {get}
}
