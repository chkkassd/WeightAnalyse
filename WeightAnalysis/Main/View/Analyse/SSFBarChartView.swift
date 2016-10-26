//
//  SSFBarChartView.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

class SSFBarChartView: UIView {

    weak var datasource: SSFBarChartViewDataSource?
    
    override func draw(_ rect: CGRect) {
        
    }
    

}

///This protocol describe the presention of barChartView.
protocol SSFBarChartViewDataSource: class {
    
    //Horizontal presentaion
    func numberOfHorizontalAxis(barChartView: SSFBarChartView) -> Int
    func barChartView(barChartView: SSFBarChartView, titleForHorizontalIndex index: Int) -> String?
    func barChartView(barChartView: SSFBarChartView, valueForHorizontalIndex index: Float) -> Float?
    
    //Vertical presentaion
    func numberOfVerticalAxis(barChartView: SSFBarChartView) -> Int
    func barChartView(barChartView: SSFBarChartView, titleForVerticalIndex index: Int) -> String?
    
    //bar UI
    func colorOfBar(barChartView: SSFBarChartView) -> UIColor
    
    //Wheather start the animation.
    func openAnimation() -> Bool
}
