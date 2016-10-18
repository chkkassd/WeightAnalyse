//
//  Record+CoreDataProperties.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/10/9.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation
import CoreData

extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record");
    }

    @NSManaged public var weight: Double
    @NSManaged public var time: String?
    @NSManaged public var record_id: String?
    @NSManaged public var recordUser: User?

}
