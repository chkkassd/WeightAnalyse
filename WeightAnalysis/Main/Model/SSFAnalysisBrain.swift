//
//  SSFLineChartModel.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/27.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct ChartPoint {
    var x: Double = 0.0
    var y: Double = 0.0
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

struct AnalysisBrain {
    private weak var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func fetchRecordsOfCurrentWeek() -> [Record]? {
        let firstDay = Date().firstDayDate!.standardTimeString
        let lastDay = Date().lastDayDate!.standardTimeString
        
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        request.predicate = NSPredicate(format: "time <= %@ && time >= %@",lastDay,firstDay)
        request.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
        
        if let records = (try? managedObjectContext?.fetch(request)) {
            return records
        }
        return nil
    }
}
