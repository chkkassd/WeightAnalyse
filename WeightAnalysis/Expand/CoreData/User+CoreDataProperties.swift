//
//  User+CoreDataProperties.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/10/9.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var email: String?
    @NSManaged public var display_name: String?
    @NSManaged public var user_id: Int32
    @NSManaged public var records: NSSet?

}

// MARK: Generated accessors for records
extension User {

    @objc(addRecordsObject:)
    @NSManaged public func addToRecords(_ value: Record)

    @objc(removeRecordsObject:)
    @NSManaged public func removeFromRecords(_ value: Record)

    @objc(addRecords:)
    @NSManaged public func addToRecords(_ values: NSSet)

    @objc(removeRecords:)
    @NSManaged public func removeFromRecords(_ values: NSSet)

}
