//
//  FirstCell.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 2/7/20.
//  Copyright © 2020 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class FirstCell: UITableViewCell {
    
    lazy var avatarImage : UIImageView = {
        let image : UIImageView = UIImageView()
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var emailLabel : SubTitleLabel = SubTitleLabel("Email: ")
    
    private lazy var dateLabel : SubTitleLabel = SubTitleLabel("Ngày lập: ")
    
    fileprivate func setUpLayoutForCell(){
        self.sv(avatarImage, emailLabel, dateLabel)
        avatarImage.size(60).Top == self.Top + 10
        avatarImage.Leading == self.Leading + 15
        emailLabel.Top == avatarImage.Top
        emailLabel.Leading == avatarImage.Trailing + 15
        emailLabel.Trailing == self.Trailing - 10
        dateLabel.Bottom == avatarImage.Bottom
        dateLabel.Leading == emailLabel.Leading
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setUpLayoutForCell()
        // Configure the view for the selected state
    }

}
