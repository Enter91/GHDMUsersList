//
//  Endpoints.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import Foundation

struct Endpoints {
    static func gitHubUsers() -> Request<[GitHubUser]> {
        return Request<[GitHubUser]>(path: "https://api.github.com/users")
    }
    
    static func dailyMotionUsers() -> Request<[DailyMotionUser]> {
        return Request<[DailyMotionUser]>(path: "https://api.dailymotion.com/users?fields=avatar_360_url,username", keyPath: "list")
    }
}
