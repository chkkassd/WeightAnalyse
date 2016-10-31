//
//  SSFLineChartModel.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/27.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation

struct LineChartPoint {
    var x: Double = 0.0
    var y: Double = 0.0
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    init(record: Record, lineChartView: SSFLineChartView) {
        y = lineChartView.origionPoint.y - record.weight * lineChartView.ratio
        if let weekDay = record.time?.translatedDate?.weekdayString {
            
        }
    }
}
