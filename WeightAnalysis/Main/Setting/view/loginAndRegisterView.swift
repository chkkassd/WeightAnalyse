//
//  loginView.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/9/22.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

let rowSpace = 8.0
let rowHeight = 30.0
let alertSpace = 50.0

/**
 ## Overview
 Login view which conforms to LoginStyle protocol is custom view that is presented as login style.
 
 ## Initializers
 You can creat the class or struct by the flowing ways.
 
 <#The example of initializers#>
 
 ---
 
 - important:
 <#something important about the class or struct.#>
 */
class LoginView: UIView,LoginStyle {
    lazy var emailTextField: UITextField = {
        let email = UITextField(frame: CGRect(x: rowSpace, y: rowSpace, width: Double(self.frame.size.width) - rowSpace * 2, height: rowHeight))
        email.borderStyle = UITextBorderStyle.roundedRect
        email.placeholder = "请输入帐号"
        return email
    }()
    
    lazy var passwordTextField: UITextField = {
        let password = UITextField(frame: CGRect(x: rowSpace, y: rowSpace * 2 + rowHeight, width: Double(self.frame.size.width) - rowSpace * 2, height: rowHeight))
        password.borderStyle = UITextBorderStyle.roundedRect
        password.placeholder = "请输入密码"
        return password
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: rowSpace, y: rowSpace * 3 + rowHeight * 2, width: Double(self.frame.size.width) - rowSpace * 2, height: rowHeight))
        button.setTitle("go", for:UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.addTarget(self, action:#selector(LoginView.buttonPressed) ,for:UIControlEvents.touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init?(containViewFrame: CGRect) {
        if containViewFrame.size.width == 0 || containViewFrame.size.height == 0 {
            return nil
        }
        let x = alertSpace
        let height = rowHeight * 3 + rowSpace * 4
        let y = Double(containViewFrame.size.height)/2 - height
        let width = Double(containViewFrame.size.width) - alertSpace * 2
        
        self.init(frame:CGRect(x: x, y: y, width: width, height: height))
        
        self.backgroundColor = UIColor.white
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.loginButton)
    }
    
    func buttonPressed() {
        
    }
}

class RegisterView: UIView {
    
}

protocol LoginStyle {
    var emailTextField: UITextField { get }
    var passwordTextField: UITextField { get }
    var loginButton: UIButton { get }
}

protocol RegisterStyle {
    
}
