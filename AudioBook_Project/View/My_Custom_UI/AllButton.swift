//
//  AllButton.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/14/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit

class AllButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle(">>", for: .normal)
        self.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
