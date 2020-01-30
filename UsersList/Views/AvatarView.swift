//
//  AvatarView.swift
//  UsersList
//
//  Created by Michał Czwarnowski on 28/01/2020.
//  Copyright © 2020 Michał Czwarnowski. All rights reserved.
//

import UIKit
import Kingfisher

class AvatarView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backgroundView.layer.shadowOpacity = 0.3
        backgroundView.layer.rasterizationScale = UIScreen.main.scale
        backgroundView.layer.shouldRasterize = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.layoutIfNeeded()
        avatarImageView.layoutIfNeeded()
        backgroundView.layer.cornerRadius = backgroundView.frame.width/2
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
    }
    
    func setSelectedBackground() {
        backgroundView.backgroundColor = .white
    }
    
    func cancelImageLoading() {
        avatarImageView.kf.cancelDownloadTask()
    }
    
    func resetImage() {
        avatarImageView.image = nil
    }
    
    func setImage(with resource: Resource?) {
        avatarImageView.kf.setImage(with: resource)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("AvatarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
