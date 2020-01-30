//
//  DailyMotionUser.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import Foundation

struct DailyMotionUser: Decodable, User {
    var name: String!
    var avatar: URL?
    var source: UserSource = .dailymotion
    
    enum CodingKeys: String, CodingKey {
        case name = "username"
        case avatar = "avatar_360_url"
    }
}
