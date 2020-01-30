//
//  Presenter.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import UIKit

typealias PresenterViewController = UIViewController & Presenter

protocol Presenter {
    func showUser(_ user: User)
}

extension Presenter where Self: UIViewController {
    func showUser(_ user: User) {
        let vc: UserViewController = UIStoryboard(name: .main).instantiateViewController()
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
}
