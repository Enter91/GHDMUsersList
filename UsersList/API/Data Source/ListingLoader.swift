//
//  ListingLoader.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import Foundation

class ListingLoader {
    private lazy var gitHubUsersRequest: Request<[GitHubUser]> = Endpoints.gitHubUsers()
    private lazy var dailyMotionUsersRequest: Request<[DailyMotionUser]> = Endpoints.dailyMotionUsers()
    
    func loadGitHubUsers(_ callback: @escaping (_ users: [User]?)->()) {
        gitHubUsersRequest.execute(onSuccess: { (users) in
            callback(users)
        }) { (error) in
            callback(nil)
        }
    }
    
    func loadDailyMotionUsers(_ callback: @escaping ([User]?)->()) {
        dailyMotionUsersRequest.execute(onSuccess: { (users) in
            callback(users)
        }) { (error) in
            callback(nil)
        }
    }
    
    func loadUsers(_ callback: @escaping (_ users: [User]?)->()) {
        var listing = [User]()
        
        loadGitHubUsers { [weak self] (gitHubUsers) in
            listing.append(contentsOf: gitHubUsers ?? [])
            
            self?.loadDailyMotionUsers { (dailyMotionUsers) in
                listing.append(contentsOf: dailyMotionUsers ?? [])
                callback(listing)
            }
        }
    }
}
