//
//  BookResultCell.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/21/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class BookResultCell: UITableViewCell {
    
    lazy var bookImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFit
        return image
    }()
    
    lazy var bookName = TitleLabel()
    
    fileprivate func setUpLayoutForCell(){
        self.sv(bookName, bookImage)
        bookImage.centerVertically().width(50).height(80).Leading == self.Leading + 20
        bookName.centerVertically().Leading == bookImage.Trailing + 20
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setUpLayoutForCell()
    }

}
