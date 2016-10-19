//
//  SSFBusinessBrain.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/18.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/**
 ## Overview
 A Struct acts on the app's main work,tell app what does it do.
 
 ## Initializers
 You can creat the class or struct by the flowing ways.
 
*/
struct BusinessBrain {
    private var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var todayWeight: Double? {
        if let record = Record.record(withTime: Date().standardTimeString, inManagedObjectContext: self.managedObjectContext!) {
            return record.weight
        }
        return nil
    }
    
    public func record(todayWeight weight: Double, time: String) {
        var info: [String:Any] = ["weight":weight,"time":time,"record_id":NSUUID.init().uuidString,"user":AccountBrain.sharedInstance.currentUser]
        
        if let record = Record.record(withTime: time, inManagedObjectContext: managedObjectContext!) {
            info["record_id"] = record.record_id
        }
        self.managedObjectContext?.perform {
            _ = Record.recordWithRecordInfo(recordInfo: info, inManagedObjectContext: self.managedObjectContext!)
            self.appDelegate?.saveContext()
            
        }
    }
    
    public func record(targetWeight weight: Double, time: String) {
        UserDefaults.standard.set(weight, forKey: TargetWeightKey)
        UserDefaults.standard.synchronize()
    }
}

let TargetWeightKey = "targetWeightKey"

// MARK:protocol
protocol RealatedWeight {
    var targetWeight: Double { get }
}

extension RealatedWeight {
    var targetWeight: Double {
        get {
            return UserDefaults.standard.double(forKey: TargetWeightKey)
        }
    }
}
