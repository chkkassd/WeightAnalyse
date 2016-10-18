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
    
    /**
     This function acts on updating a exist record.If this record is not exist, it will help to creat this record in the data base with the corresponding information.
     - Parameters:
       - recordInfo:The information of the record passed in
       - inManagedObjectContext:The context which change and save the content of data modal.
     - Returns: The record of 'Record' type,which describe a record in the data base.
     - Authors:
     Peter.Shi
     - date: 2016.10.10
     */
    class func recordWithRecordInfo(recordInfo: Any, inManagedObjectContext context: NSManagedObjectContext) -> Record? {
        let infoDic = recordInfo as? [String : Any]
        if let recordId = infoDic?["record_id"] as? String {
            
            let request: NSFetchRequest<Record> = self.fetchRequest()
            request.predicate = NSPredicate(format: "record_id = %@", recordId)
            
            if let record = (try? context.fetch(request))?.first {
                record.record_id = recordId
                record.weight = infoDic?["weight"] as! Double
                record.time = infoDic?["time"] as? String
                record.recordUser = infoDic?["user"] as? User//User.user(withUserId: (infoDic?["user_id"] as! Int), inManagedObjectContext: context)
                return record
            } else if let record = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as? Record {
                record.record_id = recordId
                record.weight = infoDic?["weight"] as! Double
                record.time = infoDic?["time"] as? String
                record.recordUser = infoDic?["user"] as? User//User.user(withUserId: (infoDic?["user_id"] as! Int), inManagedObjectContext: context)
                return record
            }
            return nil
        }
        return nil
    }
    
    /**
     This function acts on querying a exist record by recoreid.If this record is not exist, it will return nil.
     - Parameters:
        - withRecordId:The unique of a record.
        - inManagedObjectContext:The context which change and save the content of data modal.
     - Returns: The queryed record corresponding to the recordId in the data base,if it's not exist,return nil.
     - Authors:
     Peter.Shi
     - date: 2016.10.10
     */
    class func record(withRecordId recordId: String, inManagedObjectContext context: NSManagedObjectContext) -> Record? {
        let request: NSFetchRequest<Record> = self.fetchRequest()
        request.predicate = NSPredicate(format: "record_id = %@", recordId)
        
        if let record = (try? context.fetch(request))?.first {
            return record
        }
        return nil
    }
    
    /**
     This function acts on querying a exist record by time.If this record is not exist, it will return nil.
     - Parameters:
        - withTime:The time of a record.
        - inManagedObjectContext:The context which change and save the content of data modal.
     - Returns: The queryed record corresponding to the recordId in the data base,if it's not exist,return nil.
     - Authors:
     Peter.Shi
     - date: 2016.10.18
     */
    class func record(withTime time: String, inManagedObjectContext context: NSManagedObjectContext) -> Record? {
        let request: NSFetchRequest<Record> = self.fetchRequest()
        request.predicate = NSPredicate(format: "time = %@", time)
        
        if let record = (try? context.fetch(request))?.first {
            return record
        }
        return nil
    }
    
    /**
     This function acts on deleting a exist record.If this record is not exist, it will return false.
     - Parameters:
        - withRecordId:The unique of a record.
        - inManagedObjectContext:The context which change and save the content of data modal.
     - Returns: The bool value of deleting the corresponding record.
     - Authors:
     Peter.Shi
     - date: 2016.10.10
     */
    class func delete(withRecordId recordId: String, inManagedObjectContext context: NSManagedObjectContext) -> Bool {
        if let record = Record.record(withRecordId: recordId, inManagedObjectContext: context) {
            context.delete(record)
            return true
        }
        return false
    }
}

