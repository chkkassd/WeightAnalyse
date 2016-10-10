//
//  User+CoreDataClass.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/10/9.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation
import CoreData


public class User: NSManagedObject {
    
    /**
     This function acts on updating a exist user.If this user is not exist, it will help to creat this user in the data base with the corresponding information.
     - Parameters:
        - userInfo:The information of the user passed in
        - inManagedObjectContext:The context which change and save the content of data modal.
     - Returns: The user of 'User' type,which describe a user in the data base.
     - Authors:
     Peter.Shi
     - date: 2016.10.10
     */
    class func userWithUserInfo(userInfo: Any, inManagedObjectContext context: NSManagedObjectContext) -> User? {
        let infoDic = userInfo as? [String : Any]
        if let userId = infoDic?["user_id"] as? Int {
            
            let request: NSFetchRequest<User> = self.fetchRequest()
            request.predicate = NSPredicate(format: "user_id = %d", userId)
            
            if let user = (try? context.fetch(request))?.first {
                user.user_id = Int32(userId)
                user.email = infoDic?["email"] as? String
                user.display_name = infoDic?["display_name"] as? String
                return user
            } else if let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User {
                user.user_id = Int32(userId)
                user.email = infoDic?["email"] as? String
                user.display_name = infoDic?["display_name"] as? String
                return user
            }
            return nil
        }
        return nil
    }
    
    /**
     This function acts on querying a exist user.If this user is not exist, it will return nil.
     - Parameters:
        - withUserId:The unique of a user.
        - inManagedObjectContext:The context which change and save the content of data modal.
     - Returns: The queryed user corresponding to the userId in the data base,if it's not exist,return nil.
     - Authors:
     Peter.Shi
     - date: 2016.10.10
     */
    class func user(withUserId userId: Int, inManagedObjectContext context: NSManagedObjectContext) -> User? {
        let request: NSFetchRequest<User> = self.fetchRequest()
        request.predicate = NSPredicate(format: "user_id = %d", userId)
        
        if let user = (try? context.fetch(request))?.first {
            return user
        }
        return nil
    }
    
    /**
     This function acts on deleting a exist user.If this user is not exist, it will return nil.
     - Parameters:
        - withUserId:The unique of a user.
        - inManagedObjectContext:The context which change and save the content of data modal.
     - Returns: The bool value of deleting the corresponding user.
     - Authors:
     Peter.Shi
     - date: 2016.10.10
     */
    class func delete(withUserId userId: Int, inManagedObjectContext context: NSManagedObjectContext) -> Bool {
        if let user = User.user(withUserId: userId, inManagedObjectContext: context) {
            context.delete(user)
            return true
        }
        return false
    }
}
