//
//  SSFSignInAndUpViewController.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/9/22.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

class SSFSignInAndUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        self.view.addSubview(self.lView)
    }

    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.view.addSubview(self.rView)
    }

    lazy var rView: RegisterView = {
        let view = RegisterView(containViewFrame: self.view.frame, delegate: self)
        return view!
    }()
    
    lazy var lView: LoginView = {
        let view = LoginView(containViewFrame: self.view.frame, delegate: self)
        return view!
    }()
    
    weak var delegate: SSFSignInAndUpViewControllerDelegate?
}

extension SSFSignInAndUpViewController: RegisterViewDelegate {
    func registerViewDidRegister(registerView: RegisterView, email: String, password: String, nickName: String) {
        self.pleaseWait()
        AccountBrain.sharedInstance.register(email: email, password: password, nickName: nickName) { results in
            self.clearAllNotice()
            switch results {
            case .success(_):
                self.lView.removeFromSuperview()
                self.delegate?.signInAndUpViewController(didRegister: self)
            case .failure(let errInfo):
                print("\(errInfo)")
                self.noticeError(errInfo, autoClear: true, autoClearTime: 2)
            }

        }
    }
    
    func registerViewDidCancel(_ registerView: RegisterView) {
        rView.removeFromSuperview()
    }
}

extension SSFSignInAndUpViewController: LoginViewDelegate {
    func loginViewDidLogin(loginView: LoginView, email: String, password: String) {
        self.pleaseWait()
        AccountBrain.sharedInstance.login(email: email, password: password) { results in
            self.clearAllNotice()
            switch results {
            case .success(_):
                self.lView.removeFromSuperview()
                self.delegate?.signInAndUpViewController(didSignIn: self)
            case .failure(let errInfo):
                self.noticeError(errInfo, autoClear: true, autoClearTime: 2)
            }
        }
    }
    
    func loginViewDidCancel(_ loginView: LoginView) {
        lView.removeFromSuperview()
    }
}

protocol SSFSignInAndUpViewControllerDelegate: class{
    func signInAndUpViewController(didSignIn: SSFSignInAndUpViewController) -> Swift.Void
    func signInAndUpViewController(didRegister: SSFSignInAndUpViewController) -> Swift.Void
}
