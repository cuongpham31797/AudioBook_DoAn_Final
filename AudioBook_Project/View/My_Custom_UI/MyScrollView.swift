//
//  MyScrollView.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/14/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit

class MyScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9534785151, green: 0.9497569203, blue: 0.9563729167, alpha: 1)
        self.contentSize.height = 980
        self.bounces = false
        self.showsVerticalScrollIndicator = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
