//
//  CategoryCell.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class CategoryCell: UICollectionViewCell {
    
    lazy var mainImage : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayoutForCell()
    }
    
    fileprivate func setUpLayoutForCell(){
        self.sv(mainImage, nameLabel)
        mainImage.centerHorizontally().width(100).height(80).Top == self.Top
        nameLabel.Top == mainImage.Bottom + 10
        nameLabel.Leading == self.Leading
        nameLabel.Trailing == self.Trailing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
