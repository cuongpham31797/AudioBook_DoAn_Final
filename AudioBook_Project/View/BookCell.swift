//
//  MostLikeBookCell.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/14/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class BookCell: UICollectionViewCell {
    
    lazy var avatarImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayoutForCell()
    }
    
    fileprivate func setUpLayoutForCell(){
        self.sv(avatarImage, nameLabel)
        avatarImage.centerHorizontally().width(110).height(150).Top == self.Top
        nameLabel.Top == avatarImage.Bottom + 10
        nameLabel.Leading == self.Leading + 5
        nameLabel.Trailing == self.Trailing - 5
        nameLabel.Bottom == self.Bottom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
