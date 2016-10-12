//
//  SSFSettingBrain.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/9/27.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/**
 ## Overview
 This enumeration acts on the result of model's function.
 */
enum SSFResult<T> {
    case success(T)
    case failure(String)
}

typealias CompletionHandler<Value> = (SSFResult<Value>) -> Swift.Void

let UserIdKey = "UserIdOfLoginUser"

/**
 ## Overview
 This class is the model of Setting module and acts on the core function such as login,register,modfire head image,modfire nick name and so on .
 
 ## Initializers
 You can creat the class or struct by the flowing ways.
 
     let brain = SettingBrain.sharedInstance
 
 ---
 
*/
class SettingBrain {
    static let sharedInstance = SettingBrain()
    
    private var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    private var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    ///The current user of app,open to the whole project.
    public var currentUser: User? {
        get {
            if let user = loginUser {
                return user
            } else {
                //fetch from file
                let userId = (UserDefaults.standard.integer(forKey: UserIdKey))
                if let userFromBase = User.user(withUserId: userId, inManagedObjectContext: self.managedObjectContext!) {
                    self.loginUser = userFromBase
                    return userFromBase
                } else {
                return nil
                }
            }
        }
        set {
            self.loginUser = newValue
        }
    }
    
    ///The current user of app,just open to SettingBrain.It's a private variable.
    private var loginUser: User?
    
    /**
     The function acts on login by connect the login api,and save the user data to local.
     - Parameters:
       - email:The account to login.
       - password:The password to login.
     - Authors:
     Peter.Shi
     - date: 2016.9.28
     */
    public func login(email: String, password: String, completionHandler:@escaping CompletionHandler<User>) -> Swift.Void {
        FetchDataBrain().signIn(email: email, password: password) { businessResult in
            switch businessResult {
            case .success(let value):
                if let info = (value as? [String : Any])?["user"] {
                    self.managedObjectContext?.perform{
                        if let user = User.userWithUserInfo(userInfo: info, inManagedObjectContext: self.managedObjectContext!) {
                            self.appDelegate?.saveContext()
                            self.loginUser = user
                            UserDefaults.standard.set(NSInteger(user.user_id), forKey: UserIdKey)
                            UserDefaults.standard.synchronize()
                            completionHandler(SSFResult.success(user))
                        }
                    }
                }
            case .failure(let value):
                completionHandler(SSFResult.failure(value))
            }
        }
    }
    
    /**
     The function acts on register by connect the register api,and save the user data to local.
     - Parameters:
        - email:The account to register.
        - password:The password to register.
        - nickName:The display name in the app
     - Authors:
     Peter.Shi
     - date: 2016.9.28
     */
    public func register(email: String, password: String, nickName: String, completionHandler:@escaping CompletionHandler<User>) -> Swift.Void {
        FetchDataBrain().signUp(email: email, password: password, displayName: nickName) { businessResult in
            switch businessResult {
            case .success(_):
                    self.login(email: email, password: password, completionHandler: completionHandler)
            case .failure(let value):
                completionHandler(SSFResult.failure(value))
            }
        }
    }
    
    ///Act on printting the data base
    func printDataBase() {
        let count = try? managedObjectContext?.count(for: User.fetchRequest())
        print("data base has \(count) user\n")
        if let arr = try? managedObjectContext?.fetch(User.fetchRequest()) {
            for obj in arr! {
                print("user userid:\(obj.user_id),userEmail:\(obj.email),userName:\(obj.display_name)\n")
            }
        }
    }
    
    ///Check the app whether has a login user.
    public func checkUserIsLogin() -> Bool {
        if UserDefaults.standard.integer(forKey: UserIdKey) != 0 {
            return true
        } else {
          return false
        }
    }
}
