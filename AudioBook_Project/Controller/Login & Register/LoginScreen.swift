//
//  LoginScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/6/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia
import SVProgressHUD
import GoogleSignIn
import Alamofire
import SwiftyJSON

class LoginScreen: UIViewController {
    
//NOTE: Các đối tượng UI
    private lazy var logoImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "LOGO")
        return image
    }()
    
    private lazy var facebookView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 0.7
        view.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapFacebook))
        view.addGestureRecognizer(tap)
        view.alpha = 0
        return view
    }()
    
    private lazy var googleView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 0.7
        view.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapGoogle))
        view.addGestureRecognizer(tap)
        view.alpha = 0
        return view
    }()
    
    private lazy var googleImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "google-plus")
        return image
    }()
    
    private lazy var googleLabel : UILabel = {
        let label = UILabel()
        label.text = "Login with Google"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.sizeToFit()
        return label
    }()
    
    private lazy var facebookImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "facebook")
        return image
    }()
    
    private lazy var facebookLabel : UILabel = {
        let label = UILabel()
        label.text = "Login with Facebook"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.sizeToFit()
        return label
    }()
//---------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpLayout()
        
    }
    
//NOTE: Transparent navigation bar
    override func viewWillAppear(_ animated: Bool) {
    //NOTE: nếu để 2 dòng này trong app delegate hoặc trong bất cứ hàm viewDidLoad của màn hình nào thì nó sẽ áp dụng cho tất cả các màn hình trong navigation controller
        self.navigationController?.isNavigationBarHidden = true
    //----------------------------------------------------------------------------------------------------------------
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.show()
    }
//---------------------------------------------------------------------------------------------------------------------
    
    override func viewWillLayoutSubviews() {
        //vì hàm này chỉ được chạy 1 lần nên vứt phần animation vào đây
        //NOTE: Animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.logoImage.center.y -= 150
                self.facebookView.alpha = 1
                self.facebookView.transform = CGAffineTransform(translationX: 0,
                                                                y: self.view.center.y - 10)
                self.googleView.alpha = 1
                self.googleView.transform = CGAffineTransform(translationX: 0,
                                                              y: self.view.center.y + 25 + self.facebookView.frame.height)
            }, completion: nil)
            SVProgressHUD.dismiss()
        }
        //----------------------------------------------------------------------------------------------------------------
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SVProgressHUD.dismiss()
        }
    }
    
    fileprivate func setUpLayout(){
        view.sv(logoImage, facebookView, googleView)
        self.setUpFacebookButton()
        self.setUpGoogleButton()
        logoImage.centerHorizontally().size(180)
        logoImage.CenterY == view.CenterY - 20
        facebookView.centerHorizontally().width(70%).height(50)
        googleView.centerHorizontally().width(70%).height(50)
    }
    
    fileprivate func setUpFacebookButton(){
        facebookView.sv(facebookImage, facebookLabel)
        facebookImage.centerVertically().size(35).Leading == facebookView.Leading + 15
        facebookLabel.centerVertically().Leading == facebookImage.Trailing + 15
    }
    
    fileprivate func setUpGoogleButton(){
        googleView.sv(googleImage, googleLabel)
        googleImage.centerVertically().size(35).Leading == googleView.Leading + 15
        googleLabel.centerVertically().Leading == googleImage.Trailing + 15
    }
    
    @objc func onTapFacebook(){
        print("login facebook")
    }
    
    @objc func onTapGoogle(){
        print("login google")
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    deinit {
        print("login screen deinit")
    }
}

//NOTE: login với Google
extension LoginScreen : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
    //NOTE: dữ liệu lưu vào database
        guard let name = user.profile.name else { return }
        guard let email = user.profile.email else { return }
        guard let id = user.userID else { return }
        guard let avatar = user.profile.imageURL(withDimension: 80) else { return }
        let type : String = "2"
        let infoArray = [name, email, id, type]
       
    //----------------------------------------------------------------------------------------------------------
    //NOTE: lưu dữ liệu vào User Default
        //lưu mảng infoArray vào user default với key là "INFO", riêng với Google phải có thêm key "AVATAR" vì google trả về định dạng url chứ ko trả về string
        AppDelegate._default.set(infoArray, forKey: "INFO")
        AppDelegate._default.set(avatar, forKey: "AVATAR")
        //lưu trạng thái đăng nhập ở dạng Int, 0 -> logout, 1 -> login
        AppDelegate._default.set(1, forKey: "IS_LOGGED")
    //----------------------------------------------------------------------------------------------------------
        
       // Alamofire.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
        
        self.navigationController?.pushViewController(CustomTabbar(), animated: true)
    }
}
