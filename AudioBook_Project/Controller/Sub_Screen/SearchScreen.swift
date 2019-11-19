//
//  SearchScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/5/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit

class SearchScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setUpNavigation()
    }
    
    fileprivate func setUpNavigation(){
        self.navigationItem.title = "Tìm kiếm"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
}
