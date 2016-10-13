//
//  FetchDataBrain.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/9/20.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation
import Alamofire

/*
 100: 成功
 60001: 跟数据库交互时发生错误了
 60002: 您所传的参数不符合要求
 60003: email在数据库中已经存在， 一般在注册时使用到
 60004: email在数据库中不存在， 一般在登录时使用到
 60005: 密码不正确
 */

class FetchDataBrain {
    
    /**
     This function returns a string which uses to connect to the work.
     - Returns: A string which uses to connect to the work.
     - Authors:
     Peter.Shi
     - date: 2016.9.20
     */
    private func baseURL() -> String {
        return "http://\(serverIp):\(serverPort)/Chat/"
    }
    
    /**
     Enumeration represent the success or failure of business.
     * success:The networt api connects successfully,and tell user the business is successful.
     * failure:The networt api connects successfully,however the business is failure and tell user the error.
     - Authors:
     Peter.Shi
     - date: 2016.9.21
     */
    enum BusinessResult {
        case success(Any)
        case failure(String)
    }
    
    /**
     This function acts on dealing with the response data from net work.
     - Parameters:
       - data: The response data from network.
       - completionHandler: The closure passed in to handler the operation after async network finishing.
     
     - Authors:
     Peter.Shi
     - date: 2016.9.21
     */
    private func dealWith(data: Data, completionHandler:(BusinessResult) -> Swift.Void) {
        let resultString = String.decodeNetwork(data: data)
        let resultData = resultString.data(using: String.Encoding.utf8)
        let dic = try? JSONSerialization.jsonObject(with: resultData!, options: JSONSerialization.ReadingOptions.mutableContainers)
        let responseCode = (dic as! Dictionary<String,Any>)["response_code"]
        
        switch responseCode as! Int {
        case 100:completionHandler(BusinessResult.success(dic))
        case 60001:completionHandler(BusinessResult.failure("数据库交互时发生错误"))
        case 60002:completionHandler(BusinessResult.failure("您所传的参数不符合要求"))
        case 60003:completionHandler(BusinessResult.failure("该账户已注册"))
        case 60004:completionHandler(BusinessResult.failure("该账户不存在"))
        case 60005:completionHandler(BusinessResult.failure("密码不正确"))
        default:completionHandler(BusinessResult.failure("未知错误"))
        }
    }
    
    /**
     A function acts on sign up with account and password.
     - Parameters:
       - email:The email to sign up.
       - password: The password to sign up.
       - displayName: The nick name to use in the app.
       - completionHandler: The closure passed in to handler the operation after async network finishing.
     - Authors:
     Peter.Shi
     - date: 2016.9.20
     */
    public func signUp(email: String, password: String, displayName: String, completionHandler: @escaping (BusinessResult) -> Swift.Void) {
        let url = baseURL().appending("SignUp")
        let parameters = ["email":email,"password":password.md5,"display_name":displayName]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseData {response in
                switch response.result {
                case .success(let value):
                    self.dealWith(data: value, completionHandler: completionHandler)
                case .failure(let error):
                    completionHandler(BusinessResult.failure(error.localizedDescription))
                }
        }
    }
    
    /**
     This function acts on sign in with account and password.
     - Parameters:
       - email:The account to login in.
       - password:The password to login in.
       - completionHandler: The closure passed in to handler the operation after async network finishing.
     - Authors:
     Peter.Shi
     - date: 2016.9.21
     */
    public func signIn(email: String, password: String, completionHandler: @escaping (BusinessResult) -> Swift.Void) {
        /* Because of the network reason, stop to using the net work api
        let url = baseURL().appending("SignIn")
        let parameters = ["email":email,"password":password.md5]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseData {response in
                switch response.result {
                case .success(let value):
                    self.dealWith(data: value, completionHandler: completionHandler)
                case .failure(let error):
                    completionHandler(BusinessResult.failure(error.localizedDescription))
                }
        }
         */
        let dic = ["response_code":100,"user":["user_id":888,"email":email,"display_name":"peter"]] as [String : Any]
        completionHandler(BusinessResult.success(dic))
    }
    
    /**
     This function acts on updating user displayname.
     - Parameters:
       - userId: The user id of the current user.
       - displayName: The nick name of the current user.
       - completionHandler: The closure passed in to handler the operation after async network finishing.
     - Authors:
     Peter.Shi
     - date: 2016.9.21
     */
    public func update(userId: Int, displayName: String, completionHandler: @escaping (BusinessResult) -> Swift.Void) {
        let url = baseURL().appending("UpdateUserDisplayName")
        let parameters: [String: Any] = ["user_id":userId,"display_name":displayName]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    self.dealWith(data: value, completionHandler: completionHandler)
                case .failure(let error):
                    completionHandler(BusinessResult.failure(error.localizedDescription))
                }
        }
    }
    
    /**
     This function acts on updating user headImage.
     - Parameters:
       - userId: The user id of the current user.
       - headImage: The head image of the current user.
       - completionHandler: The closure passed in to handler the operation after async network finishing.
     - Authors:
     Peter.Shi
     - date: 2016.9.21
     */
    public func update(userId: Int, headImage: String, completionHandler: @escaping (BusinessResult) -> Swift.Void) {
        let url = baseURL().appending("UpdateUserPhoto")
        let parameters: [String: Any] = ["user_id":userId,"photo":headImage]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    self.dealWith(data: value, completionHandler: completionHandler)
                case .failure(let error):
                    completionHandler(BusinessResult.failure(error.localizedDescription))
                }
        }
    }
}
