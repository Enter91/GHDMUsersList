//
//  UserViewController.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        avatarView.cancelImageLoading()
        super.viewDidDisappear(animated)
    }
    
    private func setup() {
        avatarView.setImage(with: user.avatar)
        nameLabel.text = user.name
        sourceLabel.text = user.source.labelString
    }

}
