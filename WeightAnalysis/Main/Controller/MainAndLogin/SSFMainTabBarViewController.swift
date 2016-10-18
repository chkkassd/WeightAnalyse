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
        AccountBrain.sharedInstance.printDataBase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SSFMainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
