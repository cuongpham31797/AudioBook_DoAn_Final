//
//  AccountScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 10/24/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia
import SCLAlertView
import SDWebImage
import GoogleSignIn
import SVProgressHUD

class AccountScreen: UIViewController {
    
    private lazy var mainTableView : UITableView = UITableView()
    
    fileprivate func setUpLayout(){
        view.sv(mainTableView)
        mainTableView.centerInContainer().width(100%).height(100%)
    }
    
    fileprivate func setUpAllTableView(){
        setUpTableView(parent: self, tableView: mainTableView, isSelect: false) {
            self.mainTableView.register(FirstCell.self, forCellReuseIdentifier: FirstCell.className)
            self.mainTableView.register(ActionCell.self, forCellReuseIdentifier: ActionCell.className)
            self.mainTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.className)
        }
    }
    

    
    private let titleArray = ["","Sách của tôi", "Đã thích", "Ứng dụng", "Giới thiệu về ứng dụng", "Chia sẻ ứng dụng", "Góp ý", "Đánh giá ứng dụng", "", "Đăng xuất"]
    private let imageArray = ["", "", "da-thich", "", "thong-tin" , "chia-se", "gop-y", "danh-gia", "", "dang-xuat"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(view.frame.size.height)
        setUpNavigationController(viewController: self,
                                  title: String(AppDelegate._default.array(forKey: "INFO")![0] as! String)) { }
        self.setUpLayout()
        self.setUpAllTableView()
    }
    
    private func onTapLiked(){
        print("liked")
    }

    private func onTapIntro(){
        print("intro")
    }

    private func onTapShare(){
        print("share")
    }

    private func onTapReview(){
        print("review")
    }

    private func onTapRating(){
        print("rating")
    }

    private func onTapLogout(){
        print("logout")
        let alert = SCLAlertView()
        alert.addButton("Có", backgroundColor: .red, textColor: .white, showTimeout: SCLButton.ShowTimeoutConfiguration.init()) {
            GIDSignIn.sharedInstance()?.signOut()
            SVProgressHUD.setBackgroundColor(.clear)
            SVProgressHUD.show()
            if AppDelegate._default.array(forKey: "INFO")![0] as? String == "1"{
                AppDelegate._default.removeObject(forKey: "IS_LOGGED")
                AppDelegate._default.removeObject(forKey: "INFO")
            }else{
                AppDelegate._default.removeObject(forKey: "IS_LOGGED")
                AppDelegate._default.removeObject(forKey: "INFO")
                AppDelegate._default.removeObject(forKey: "AVATAR")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    SVProgressHUD.dismiss()
                    appDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginScreen())
                }
            })
        }
        alert.showWait("Cảnh báo", subTitle: "Bạn có chắc chắn muốn đăng xuất không ?", closeButtonTitle: "Hủy", timeout: nil, colorStyle: 0x42C1F7, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: .topToBottom)

    }
}

extension AccountScreen : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return mainTableView.customDequeReuseable(type: FirstCell.self, indexPath: indexPath, handle: { (cell) in
                cell.avatarImage.sd_setImage(with: AppDelegate._default.url(forKey: "AVATAR"), completed: nil)
                cell.emailLabel.text = cell.emailLabel.text! + String(AppDelegate._default.array(forKey: "INFO")![1] as! String)
            })
        }else if indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 8{
            return mainTableView.customDequeReuseable(type: TitleCell.self, indexPath: indexPath, handle: { (cell) in
                cell.titleLabel.text = self.titleArray[indexPath.row]
            })
        }else{
            return mainTableView.customDequeReuseable(type: ActionCell.self, indexPath: indexPath, handle: { (cell) in
                cell.mainImage.image = UIImage(named: self.imageArray[indexPath.row])
                cell.titleLabel.text = self.titleArray[indexPath.row]
                cell.delegate = self
                cell.index = indexPath
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        }else{
            return 50
        }
    }
}

extension AccountScreen : TapActionCell {
    func onTapCell(_index: IndexPath) {
        switch _index.row {
        case 2:
            self.onTapLiked()
        case 4:
            self.onTapIntro()
        case 5:
            self.onTapShare()
        case 6:
            self.onTapReview()
        case 7:
            self.onTapRating()
        case 9:
            self.onTapLogout()
        default:
            break
        }
    }
}
