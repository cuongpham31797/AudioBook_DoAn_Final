//
//  SubTitleLabel.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/14/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit

class SubTitleLabel: UILabel {

    convenience init(_ title : String){
        self.init()
        self.text = title
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: 16)
        self.sizeToFit()
    }
}
