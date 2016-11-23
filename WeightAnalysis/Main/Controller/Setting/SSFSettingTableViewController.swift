//
//  SSFSettingTableViewController.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/9/22.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

class SSFSettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nickNameLabel.text = AccountBrain.sharedInstance.currentUser?.display_name
        emailLabel.text = AccountBrain.sharedInstance.currentUser?.email
        
    }
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0 {
            (UIApplication.shared.delegate as? AppDelegate)?.showLoginView()
            AccountBrain.sharedInstance.logOut()
        }
    }
}
