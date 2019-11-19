//
//  CustomTabbar.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit

class CustomTabbar: UITabBarController, UITabBarControllerDelegate {
    
    private let mainNavigation = UINavigationController(rootViewController: MainScreen())
    private let categoryNavigation = UINavigationController(rootViewController: CategoryScreen())
    private let playingNavigation = UINavigationController(rootViewController: PlayingScreen())
    private let accountNavigation = UINavigationController(rootViewController: AccountScreen())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.setUpTabbar()
    }
    
    fileprivate func setUpTabbar(){
        mainNavigation.tabBarItem.image = UIImage(named: "trang-chu")
        categoryNavigation.tabBarItem.image = UIImage(named: "the-loai")
        playingNavigation.tabBarItem.image = UIImage(named: "playing")
        accountNavigation.tabBarItem.image = UIImage(named: "tai-khoan")
        
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().tintColor = .black
        
        self.viewControllers = [mainNavigation, categoryNavigation, playingNavigation, accountNavigation]
    }
}
