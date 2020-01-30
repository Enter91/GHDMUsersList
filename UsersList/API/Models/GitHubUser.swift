//
//  GitHubUser.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import Foundation

struct GitHubUser: Decodable, User {
    var name: String!
    var avatar: URL?
    var source: UserSource = .github
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
    }
}
