//
//  RegisterScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/7/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class RegisterScreen: UIViewController {
    
    private lazy var mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fill
        stack.spacing = 30
        return stack
    }()
    
    private lazy var emailTextField : MyTextField = MyTextField("Email", _leftImage: "email", _rightButton: false)
    private lazy var userNameTextField : MyTextField = MyTextField("Tên đăng nhập", _leftImage: "account", _rightButton: false)
    private lazy var passwordTextField : MyTextField = MyTextField("Mật khẩu", _leftImage: "lock", _rightButton: true)
    private lazy var confirmTextField : MyTextField = MyTextField("Xác nhận mật khẩu", _leftImage: "lock", _rightButton: true)
    
 
    private lazy var registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Đăng ký", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setUpNavigation()
        self.setUpLayout()
    }
    
    fileprivate func setUpNavigation(){
    //NOTE: thay đổi font chữ và màu chữ của navigation title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    //---------------------------------------------------------------------------------------------------
        self.navigationItem.title = "Đăng ký"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    fileprivate func setUpLayout(){
        view.sv(mainStackView, registerButton)
        mainStackView.centerHorizontally().width(80%).height(230).Top == view.safeAreaLayoutGuide.Top + 50
        registerButton.centerHorizontally().width(120).height(40).Top == mainStackView.Bottom + 40
        
        mainStackView.addArrangedSubview(userNameTextField)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(confirmTextField)
        
        userNameTextField.height(35)
        emailTextField.height(35)
        passwordTextField.height(35)
        confirmTextField.height(35)
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapRegister(){
        print("register")
        let codeScreen = CodeScreen()
        codeScreen._title = "Xác nhận đăng ký"
        self.navigationController?.pushViewController(codeScreen, animated: true)
    }
    
    deinit {
        print("register screen deinit")
    }
}
