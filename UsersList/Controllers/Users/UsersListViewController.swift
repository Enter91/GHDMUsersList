//
//  UsersListViewController.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import UIKit
import SVProgressHUD

class UsersListViewController: PresenterViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var loader: ListingLoader = ListingLoader()
    fileprivate var users: [User]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Użytkownicy"
        loadData()
    }

    private func loadData() {
        SVProgressHUD.show()
        loader.loadUsers { [weak self] (users) in
            SVProgressHUD.dismiss()
            self?.users = users
        }
    }
}

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = users?[indexPath.row] else {
            fatalError("Coulnd't load user")
        }
        
        let cell: UsersListCell = tableView.dequeueCell(for: indexPath)
        cell.setup(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let user = users?[indexPath.row] else {
            fatalError("Coulnd't load user")
        }
        
        showUser(user)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

