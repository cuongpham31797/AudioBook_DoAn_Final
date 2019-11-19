//
//  LoginScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/6/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class LoginScreen: UIViewController {
    
    private lazy var logoImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "LOGO")
        return image
    }()
    
    private lazy var registerLabel : UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.sizeToFit()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapRegister))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private lazy var mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fill
        stack.spacing = 30
        return stack
    }()
    
    private lazy var userNameTextField : MyTextField = MyTextField("Tên đăng nhập", _leftImage: "account", _rightButton: false)
    private lazy var passwordTextField : MyTextField = MyTextField("Mật khẩu", _leftImage: "lock", _rightButton: true)
    
    private lazy var loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Đăng nhập", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var tryButton : UIButton = {
        let button = UIButton()
        button.setTitle("Dùng thử", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var forgotButton : UIButton = {
        let button = UIButton()
        button.setTitle("Quên mật khẩu?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(onTapForgot), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpLayout()
        setUpRegisterLabel()
    }
    
//NOTE: Transparent navigation bar
    override func viewWillAppear(_ animated: Bool) {
        //NOTE: nếu để 2 dòng này trong app delegate hoặc trong bất cứ hàm viewDidLoad của màn hình nào thì nó sẽ áp dụng cho tất cả các màn hình trong navigation controller
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //----------------------------------------------------------------------------------------------------------------
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
//---------------------------------------------------------------------------------------------------------------------
    
    fileprivate func setUpLayout(){
        view.sv(logoImage, registerLabel, mainStackView)
        logoImage.centerHorizontally().size(180).Top == view.safeAreaLayoutGuide.Top + 15
        registerLabel.centerHorizontally().Bottom == view.safeAreaLayoutGuide.Bottom - 20
        
        mainStackView.addArrangedSubview(userNameTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(loginButton)
        mainStackView.addArrangedSubview(forgotButton)
        mainStackView.addArrangedSubview(tryButton)
        
        mainStackView.width(80%).height(290).centerHorizontally().Top == logoImage.Bottom + 30
        userNameTextField.height(35)
        passwordTextField.height(35)
        loginButton.height(40)
        forgotButton.height(30)
        tryButton.height(30)
    }
//NOTE: configure register label với NSAttributed String
    fileprivate func setUpRegisterLabel(){
        let firstAttributed : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        let secondAttributed : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        ]
        
        let firstString = NSMutableAttributedString(string: "Bạn chưa có tài khoản? ",
                                                    attributes: firstAttributed)
        let secondString = NSMutableAttributedString(string: "Đăng ký ngay",
                                                     attributes: secondAttributed)
        firstString.append(secondString)
        registerLabel.attributedText = firstString
    }
//-----------------------------------------------------------------------------------------------
    @objc func onTapRegister(){
        print("register")
        self.navigationController?.pushViewController(RegisterScreen(), animated: true)
    }
    
    @objc func onTapForgot(){
        print("quên mật khẩu")
        let codeScreen = CodeScreen()
        codeScreen._title = "Lấy lại mật khẩu"
        self.navigationController?.pushViewController(codeScreen, animated: true)
    }
    
    @objc func onTapTry(){
        print("dùng thử")
    }
    
    @objc func onTapLogin(){
        print("đăng nhập")
    }
    
    deinit {
        print("login screen deinit")
    }
}
