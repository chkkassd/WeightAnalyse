//
//  SSFSettingBrain.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/9/27.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation

/**
 ## Overview
 This enumeration acts on the result of model's function.
 */
enum SSFResult<T> {
    case success(T)
    case failure(String)
}

typealias CompletionHandler<Value> = (SSFResult<Value>) -> Swift.Void

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

    /**
     The function acts on login by connect the login api,and save the user data to local.
     - Parameters:
       - email:The account to login.
       - password:The password to login.
     - Returns: 
     - Authors:
     Peter.Shi
     - date: 2016.9.28
     */
    public func login(email: String, password: String, completionHandler:CompletionHandler<String>) -> Swift.Void {
        FetchDataBrain().signIn(email: email, password: password) { businessResult in
            switch businessResult {
            case .success(let value):
            print("opopopop\(value)")
            case .failure(let value):
            print(value)
            }
        }
    }
    
    public func register(email: String, password: String, nickName: String, completionHandler:CompletionHandler<String>) -> Swift.Void {
        FetchDataBrain().signUp(email: email, password: password, displayName: nickName) { businessResult in
            switch businessResult {
            case .success(let value):
                print("opopopop\(value)")
            case .failure(let value):
                print(value)
            }
        }
    }
}
