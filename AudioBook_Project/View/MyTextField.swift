//
//  MyTextField.swift
//  Move_TextField
//
//  Created by Cuong  Pham on 9/13/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit

class MyTextField: UITextField, UITextFieldDelegate, ValidateData {
    private let border = CALayer()
    private let borderWidth : CGFloat = CGFloat(1.0)
    private var lineColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor
    private let selectedLineColor = UIColor.red.cgColor
    private let padding = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 30)
    private let leftImage : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
    private let rightButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    convenience init(_ placeHolder : String, _leftImage : String, _rightButton : Bool){
        self.init()
        self.delegate = self
    //MARK: set underline cho textfield
        border.borderColor = lineColor
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        self.font = UIFont.systemFont(ofSize: 16)
    //--------------------------------------------------------
        self.placeholder = placeHolder
    //MARK: chèn image vao ben trai textfield
        leftImage.image = UIImage(named: _leftImage)
        self.leftViewMode = .always
        self.leftView = leftImage
        self.leftView?.alpha = 0.7
    //---------------------------------------------------------
    //MARK: Custom right view cho button. Nếu tham số truyền vào hàm init là nil thì cho hiện nút clear, nếu khác nil thì cho hiện nút show/hide pasword. Có thể tách biệt từng trường hợp tùy theo bài.
        if _rightButton == true{
            self.isSecureTextEntry = true
            self.rightButton.setImage(UIImage(named: "eye"), for: .normal)
            self.rightViewMode = .whileEditing
            self.rightView = self.rightButton
            self.rightButton.addTarget(self, action: #selector(onTapShow), for: .touchUpInside)
        }else{
            self.isSecureTextEntry = false
            self.clearButtonMode = .whileEditing
        }
    //--------------------------------------------------------
    }
    
    @objc func onTapShow(){
        self.isSecureTextEntry.toggle()
    }
//MARK: đổi màu đường line khi bắt đầu và kết thúc edit text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.border.borderColor = selectedLineColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.border.borderColor = lineColor
    }
//--------------------------------------------------------
//MARK: sự kiện này chạy khi tap vào nút "return" trên bàn phím, ở đây khi tap vào nút "return" sẽ ẩn bàn phím đi
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
//----------------------------------------
//MARK: 2 hàm set cho place holder và text của text field sẽ cách 2 bên mép 1 khoảng
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
//---------------------------------------------------------------------------------
    override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
    }
}
