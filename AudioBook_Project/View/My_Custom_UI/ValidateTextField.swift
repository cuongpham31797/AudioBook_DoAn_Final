//
//  ValidateTextField.swift
//  Move_TextField
//
//  Created by Cuong  Pham on 9/16/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import Foundation
import UIKit

protocol ValidateData {}

extension ValidateData where Self : MyTextField{
    func validateEmail() -> String{
        var error : String = ""
        guard let email = self.text else {
            fatalError()
        }
        if email.count == 0 {
            error = "Email is required"
        }else {
            do {
                if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) == nil {
                    error = "Email invalid"
                }
            }catch {
                fatalError()
            }
        }
        return error
    }
    
    func validateUserName() -> String{
        var error : String = ""
        guard let userName = self.text else {
            fatalError()
        }
        if userName.count == 0 {
            error = "Username is required"
        }else if userName.count < 5 || userName.count > 15{
            error = "Username must contain from 5 to 15 characters"
        }else {
            do{
                if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-@]{5,15}$", options: .caseInsensitive).firstMatch(in: userName, options: [], range: NSRange(location: 0, length: userName.count)) == nil {
                    error = "Your username invalid"
                }
            }catch {
                fatalError()
            }
        }
        return error
    }
    
    func validatePassword() -> String {
        var error : String = ""
        guard let password = self.text else {
            fatalError()
        }
        if password.count == 0{
            error = "Passwprd is required"
        }else if password.count < 6 || password.count > 15 {
            error = "Password must contain from 6 to 15 characters and without whitespace"
        }else{
            do {
                if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$", options: .caseInsensitive).firstMatch(in: password, options: [], range: NSRange(location: 0, length: password.count)) == nil {
                    error = "Password must contain atleast 1 number and 1 charater"
                }
            }catch{
                fatalError()
            }
        }
        return error
    }
    
    func validateConfirm(compareWith : MyTextField) -> String {
        var error : String = ""
        guard let confirm = self.text else{
            fatalError()
        }
        if confirm.count == 0 {
            error = "Confirm password is required"
        }else if confirm != compareWith.text{
            error = "Confirm password is error"
        }
        return error
    }
    
    func validateAge() -> String {
        var error : String = ""
        guard let _age = self.text else{
            fatalError()
        }
        guard let age = Int(_age) else {
            fatalError()
        }
        if age < 0 || age > 100 {
            error = "Your age invalid"
        }else if age < 18{
            error = "You under 18"
        }
        return error
    }
}
