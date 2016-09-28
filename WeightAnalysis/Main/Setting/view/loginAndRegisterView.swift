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
let cancelButtonSize = 50.0

/**
 ## Overview
 Login view which conforms to LoginStyle protocol and HasBackgroundView protocol is custom view that is presented as login style.
 
 ## Initializers
 You can creat the class or struct by the flowing ways.
 
     let loginView = LogingView(containViewFrame: self.view.frame)
 
 ---
 
 - important:
 Now,it just fits in code,it' not useful to storyboard.
 */
class LoginView: UIView,LoginStyle,HasBackgroundView,HasCancelButton {
    lazy var emailTextField: UITextField = {
        let email = UITextField(frame: CGRect(x: alertSpace, y: Double(self.frame.size.height)/2 - (rowHeight * 3 + rowSpace * 2), width: Double(self.frame.size.width) - alertSpace * 2, height: rowHeight))
        email.borderStyle = UITextBorderStyle.roundedRect
        email.placeholder = "请输入帐号"
        return email
    }()
    
    lazy var passwordTextField: UITextField = {
        let password = UITextField(frame: CGRect(x: alertSpace, y: Double(self.frame.size.height)/2 - (rowHeight * 2 + rowSpace), width: Double(self.frame.size.width) - alertSpace * 2, height: rowHeight))
        password.borderStyle = UITextBorderStyle.roundedRect
        password.placeholder = "请输入密码"
        return password
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: alertSpace, y: Double(self.frame.size.height)/2 - rowHeight, width: Double(self.frame.size.width) - alertSpace * 2, height: rowHeight))
        button.setTitle("go", for:UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.addTarget(self, action:#selector(LoginView.buttonPressed) ,for:UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView(frame: self.frame)
        view.backgroundColor = UIColor.black
        view.alpha = 0.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBackgroundView))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    var delegate: LoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init?(containViewFrame: CGRect, delegate:LoginViewDelegate) {
        if containViewFrame.size.width == 0 || containViewFrame.size.height == 0 {
            return nil
        }

        self.init(frame:containViewFrame)
        self.delegate = delegate
        self.addSubview(self.backgroundView)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.loginButton)
        self.addSubview(self.cancelButton)
    }
    
    func buttonPressed() {
        self.delegate?.loginViewDidLogin(self)
    }
    
    func tapBackgroundView() {
        self.endEditing(true)
    }
    
    func cancelButtonPressed() {
        self.delegate?.loginViewDidCancel(self)
    }
}

/**
 ## Overview
 Register view which conforms to RegisterStyle protocol and HasBackgroundView protocol is custom view that is presented as register style.
 
 ## Initializers
 You can creat the class or struct by the flowing ways.
 
     let registerView = RegisterView(containViewFrame: self.view.frame)
 
 ---
 
 - important:
 Now,it just fits in code,it' not useful to storyboard.
 */
class RegisterView: UIView,RegisterStyle,HasBackgroundView,HasCancelButton {
    lazy var emailTextField: UITextField = {
        let email = UITextField(frame: CGRect(x: alertSpace, y: Double(self.frame.size.height)/2 - (rowHeight * 4 + rowSpace * 3), width: Double(self.frame.size.width) - alertSpace * 2, height: rowHeight))
        email.borderStyle = UITextBorderStyle.roundedRect
        email.placeholder = "请输入帐号"
        return email
    }()
    
    lazy var passwordTextField: UITextField = {
        let password = UITextField(frame: CGRect(x: alertSpace, y: Double(self.frame.size.height)/2 - (rowHeight * 3 + rowSpace * 2), width: Double(self.frame.size.width) - alertSpace * 2, height: rowHeight))
        password.borderStyle = UITextBorderStyle.roundedRect
        password.placeholder = "请输入密码"
        return password
    }()
    
    lazy var nickNameTextfield: UITextField = {
        let nickName = UITextField(frame: CGRect(x: alertSpace, y: Double(self.frame.size.height)/2 - (rowHeight * 2 + rowSpace), width: Double(self.frame.size.width) - alertSpace * 2, height: rowHeight))
        nickName.borderStyle = UITextBorderStyle.roundedRect
        nickName.placeholder = "请输入昵称"
        return nickName
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: alertSpace, y: Double(self.frame.size.height)/2 - rowHeight, width: Double(self.frame.size.width) - alertSpace * 2, height: rowHeight))
        button.setTitle("注册", for:UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.addTarget(self, action:#selector(RegisterView.buttonPressed) ,for:UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView(frame: self.frame)
        view.backgroundColor = UIColor.black
        view.alpha = 0.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBackgroundView))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    var delegate: RegisterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init?(containViewFrame: CGRect, delegate:RegisterViewDelegate) {
        if containViewFrame.size.width == 0 || containViewFrame.size.height == 0 {
            return nil
        }
        
        self.init(frame:containViewFrame)
        self.delegate = delegate
        self.addSubview(self.backgroundView)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.nickNameTextfield)
        self.addSubview(self.loginButton)
        self.addSubview(self.cancelButton)
    }
    
    func buttonPressed() {
        self.delegate?.registerViewDidRegister(self)
    }
    
    func tapBackgroundView() {
        self.endEditing(true)
    }
    
    func cancelButtonPressed() {
        self.delegate?.registerViewDidCancel(self)
    }
}

// MARK: protocol

protocol LoginViewDelegate {
    func loginViewDidLogin(_ loginView:LoginView) -> Swift.Void
    func loginViewDidCancel(_ loginView:LoginView) -> Swift.Void
}

protocol RegisterViewDelegate {
    func registerViewDidRegister(_ registerView:RegisterView) -> Swift.Void
    func registerViewDidCancel(_ registerView:RegisterView) -> Swift.Void
}

protocol LoginStyle {
    var emailTextField: UITextField { get }
    var passwordTextField: UITextField { get }
    var loginButton: UIButton { get }
}

protocol RegisterStyle {
    var emailTextField: UITextField { get }
    var passwordTextField: UITextField { get }
    var nickNameTextfield: UITextField { get }
    var loginButton: UIButton { get }
}

protocol HasBackgroundView {
    var backgroundView: UIView { get }
}

protocol HasCancelButton {
    var cancelButton: UIButton { get }
}

extension HasCancelButton {
    var cancelButton: UIButton {
        let button = UIButton(frame: CGRect(x: Double((self as! UIView).frame.size.width) - cancelButtonSize - rowSpace , y: rowSpace, width: cancelButtonSize, height: cancelButtonSize))
        button.setTitle("关闭", for: UIControlState.normal)
        button.addTarget(self, action: #selector(LoginView.cancelButtonPressed), for: UIControlEvents.touchUpInside)
        return button
    }
}
