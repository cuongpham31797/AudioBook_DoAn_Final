//
//  AppDelegate.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

//NOTE: Khai báo user default để lưu trạng thái đăng nhập
    static let _default = UserDefaults.standard
//----------------------------------------------------------------------------------------------------------------
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = "454372941963-ffrkjmhb76dhg7pf4kss01195ca7829r.apps.googleusercontent.com"
        window = UIWindow(frame: UIScreen.main.bounds)
        let navi = UINavigationController(rootViewController: LoginScreen())
        if AppDelegate._default.value(forKey: "INFO") != nil {
            window?.rootViewController = CustomTabbar()
        }else{
            window?.rootViewController = navi
        }
        
        
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}

extension AppDelegate : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("123")
    }
    

}
