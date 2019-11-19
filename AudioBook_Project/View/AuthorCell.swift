//
//  AuthorCell.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/5/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class AuthorCell: UICollectionViewCell {
    
    lazy var avatarImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 60
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nameLabel : SubTitleLabel = SubTitleLabel("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayoutForCell()
    }
    
    fileprivate func setUpLayoutForCell(){
        self.sv(avatarImage, nameLabel)
        avatarImage.centerHorizontally().size(120).Top == self.Top
        nameLabel.centerHorizontally().Top == avatarImage.Bottom + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
