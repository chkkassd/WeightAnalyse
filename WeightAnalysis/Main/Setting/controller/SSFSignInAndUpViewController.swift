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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.view.addSubview(self.rView)
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {
        self.view.addSubview(self.lView)
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
        rView.removeFromSuperview()
    }
}

extension SSFSignInAndUpViewController: LoginViewDelegate {
    func loginViewDidLogin(_ loginView: LoginView) {
        lView.removeFromSuperview()
    }
}
