//
//  TitleLabel.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/14/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    convenience init(_ title : String){
        self.init()
        self.text = title
        self.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        self.font = UIFont.boldSystemFont(ofSize: 17)
        self.sizeToFit()
    }
    
}
