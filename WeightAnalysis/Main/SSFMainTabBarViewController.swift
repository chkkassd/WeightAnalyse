//
//  SSFMainTabBarViewController.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/9/20.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

class SSFMainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FetchDataBrain().signUp(email: "99@qq.com", password: "123456", displayName: "test2") { result in
            switch result {
            case .success(let dic):
                print("haha,i get the result:\(dic)")
            case .failure(let errorDescription):
                print("hehe,i get the error:\(errorDescription)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
