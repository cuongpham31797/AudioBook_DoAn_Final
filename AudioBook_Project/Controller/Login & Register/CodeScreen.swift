//
//  CodeScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/7/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia

class CodeScreen: UIViewController {
    
    var _title : String!
    var _email : String!
    private var count : Int = 59
    private var timer = Timer()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subLabel : SubTitleLabel = SubTitleLabel("Mã xác thực sẽ bị vô hiệu hóa sau:")
    
    private lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .red
        label.sizeToFit()
        return label
    }()
    
    private lazy var codeTextField : UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .center
        textField.textColor = .black
        textField.keyboardType = UIKeyboardType.numberPad
        textField.layer.borderWidth = 0.3
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private lazy var submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("Xác nhận", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setUpNavigation()
        setUpLayout()
        setUpTitleLabel()
        
        self.codeTextField.delegate = self
        self.codeTextField.becomeFirstResponder()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    
    fileprivate func setUpNavigation(){
        //NOTE: thay đổi font chữ và màu chữ của navigation title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        //---------------------------------------------------------------------------------------------------
        self.navigationItem.title = _title!
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    fileprivate func setUpLayout(){
        view.sv(titleLabel, timeLabel, codeTextField, subLabel, submitButton)
        titleLabel.Top == view.safeAreaLayoutGuide.Top + 20
        titleLabel.Leading == view.safeAreaLayoutGuide.Leading + 20
        titleLabel.Trailing == view.safeAreaLayoutGuide.Trailing - 20
        titleLabel.height(60)
        
        subLabel.Leading == titleLabel.Leading + 20
        subLabel.Top == titleLabel.Bottom + 15
        
        timeLabel.Leading == subLabel.Trailing + 3
        timeLabel.Top == subLabel.Top
        
        codeTextField.centerHorizontally().width(80).height(35).Top == subLabel.Bottom + 20
        
        submitButton.centerInContainer().width(120).height(40)
    }
    
    fileprivate func setUpTitleLabel(){
        let firstAttributed : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        let secondAttributed : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        ]
        
        let firstString = NSMutableAttributedString(string: "Vui lòng kiểm tra mã xác thực trong email ",
                                                    attributes: firstAttributed)
        let secondString = NSMutableAttributedString(string: "cuongpham797013@gmail.com",
                                                     attributes: secondAttributed)
        firstString.append(secondString)
        titleLabel.attributedText = firstString
    }
    
    deinit {
        print("code screen deinit")
    }
    
    @objc func runTimer(){
        if self.count == 0 {
            timer.invalidate()
        }
        self.count -= 1
        timeLabel.text = String(self.count) + " giây"
        print(self.count)
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension CodeScreen : UITextFieldDelegate {
    //NOTE: giới hạn textfield chỉ có 4 ký tự
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 4
    }
    //----------------------------------------------------------------------------------
}
