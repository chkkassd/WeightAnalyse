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
    class func userWithUserInfo(userInfo: Any, inManagedObjectContext context: NSManagedObjectContext) -> User? {
        let infoDic = userInfo as? [String : Any]
        let userId = infoDic?["user_id"] as? Int
        
        let request: NSFetchRequest<User> = self.fetchRequest()
        request.predicate = NSPredicate(format: "user_id = %@", userId!)
        
        if let user = (try? context.fetch(request))?.first {
            user.user_id = Int32(userId!)
            user.email = infoDic?["email"] as? String
            user.display_name = infoDic?["display_name"] as? String
            return user
        } else if let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User {
            user.user_id = Int32(userId!)
            user.email = infoDic?["email"] as? String
            user.display_name = infoDic?["display_name"] as? String
            return user
        }
        return nil
    }
    
    class func user(withUserId userId: Int, inManagedObjectContext context: NSManagedObjectContext) -> User? {
        let request: NSFetchRequest<User> = self.fetchRequest()
        request.predicate = NSPredicate(format: "user_id = %@", userId)
        
        if let user = (try? context.fetch(request))?.first {
            return user
        }
        return nil
    }
}
