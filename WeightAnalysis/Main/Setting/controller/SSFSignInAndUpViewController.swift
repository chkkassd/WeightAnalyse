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
        SettingBrain.sharedInstance.printDataBase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}

extension SSFSignInAndUpViewController: RegisterViewDelegate {
    func registerViewDidRegister(_ registerView: RegisterView) {
        SettingBrain.sharedInstance.register(email: "22@qq.com", password: "111111", nickName: "pp") { result in
            
        }
    }
    
    func registerViewDidCancel(_ registerView: RegisterView) {
        rView.removeFromSuperview()
    }
}

extension SSFSignInAndUpViewController: LoginViewDelegate {
    func loginViewDidLogin(_ loginView: LoginView) {
        self.pleaseWait()
        SettingBrain.sharedInstance.login(email: "22@qq.com", password: "111111") { results in
            switch results {
            case .success(_):
                self.lView.removeFromSuperview()
                self.noticeSuccess("登陆成功")
            case .failure(let errInfo):
                print("\(errInfo)")
            }
        }
    }
    
    func loginViewDidCancel(_ loginView: LoginView) {
        lView.removeFromSuperview()
    }
}
