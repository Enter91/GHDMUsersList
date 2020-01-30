//
//  UsersListCell.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import UIKit

class UsersListCell: UITableViewCell {

    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        avatarView.setSelectedBackground()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        avatarView.setSelectedBackground()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.cancelImageLoading()
        avatarView.resetImage()
    }

    func setup(user: User) {
        avatarView.setImage(with: user.avatar)
        nameLabel.text = user.name
        sourceLabel.text = user.source.labelString
    }
}
