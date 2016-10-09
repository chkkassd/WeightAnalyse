//
//  Record+CoreDataClass.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/10/9.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation
import CoreData


public class Record: NSManagedObject {
    class func recordWithRecordInfo(recordInfo: Any, inManagedObjectContext context: NSManagedObjectContext) -> Record? {
        let infoDic = recordInfo as? [String : Any]
        let recordId = infoDic?["record_id"] as? String
        
        let request: NSFetchRequest<Record> = self.fetchRequest()
        request.predicate = NSPredicate(format: "record_id = %@", recordId!)
        
        if let record = (try? context.fetch(request))?.first {
            record.record_id = infoDic?["record_id"] as? String
            record.weight = infoDic?["weight"] as! Double
            record.time = infoDic?["time"] as? NSDate
            record.recordUser = User.user(withUserId: (infoDic?["user_id"] as! Int), inManagedObjectContext: context)
            return record
        } else if let record = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as? Record {
            record.record_id = infoDic?["record_id"] as? String
            record.weight = infoDic?["weight"] as! Double
            record.time = infoDic?["time"] as? NSDate
            record.recordUser = User.user(withUserId: (infoDic?["user_id"] as! Int), inManagedObjectContext: context)
            return record
        }
        return nil
    }
}

