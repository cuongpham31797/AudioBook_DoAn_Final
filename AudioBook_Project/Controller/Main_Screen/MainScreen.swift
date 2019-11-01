//
//  MainScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class MainScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigation()
    }
    
    fileprivate func setUpNavigation(){
    //NOTE: thay đổi font chữ, màu chữ và màu nền của navigation title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    //---------------------------------------------------------------------------------------------------
        self.navigationItem.title = "Trang chủ"
    }
}
