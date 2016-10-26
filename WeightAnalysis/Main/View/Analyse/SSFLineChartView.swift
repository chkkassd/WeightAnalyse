//
//  SSFLineChartView.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

class SSFLineChartView: UIView {

    weak var datasource: SSFLineChartViewDataSource?
    
    override func draw(_ rect: CGRect) {
        
    }

}

///This protocol describe the presention of lineChartView.
protocol SSFLineChartViewDataSource: class {
    
    //Horizontal presentaion
    func numberOfHorizontalAxis(lineChartView: SSFLineChartView) -> Int
    func lineChartView(lineChartView: SSFLineChartView, titleForHorizontalIndex index: Int) -> String?
    func lineChartView(lineChartView: SSFLineChartView, valueForHorizontalIndex index: Float) -> Float?
    
    //Vertical presentaion
    func numberOfVerticalAxis(lineChartView: SSFLineChartView) -> Int
    func lineChartView(lineChartView: SSFLineChartView, titleForVerticalIndex index: Int) -> String?
    
    //stroke line UI
    func colorOfLine(lineChartView: SSFLineChartView) -> UIColor
    func widthOfLine(lineChartView: SSFLineChartView) -> Float
    
    //Weather start the animation
    func openAnimation() -> Bool
}
