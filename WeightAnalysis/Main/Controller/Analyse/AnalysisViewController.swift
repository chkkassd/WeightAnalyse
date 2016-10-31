//
//  AnalysisViewController.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/27.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController {

    let dataArrHorizontal = ["周一","周二","周三","周四","周五","周六","周日"]
    let dataArrValue = [180.0,190.0,100.0,90.0,200.0,168.0]
    let dataArrVertical = ["0","25","50","75","100","125","150","175","200","225"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lineChartView.datasource = self
    }

    
    @IBOutlet weak var lineChartView: SSFLineChartView!

}

extension AnalysisViewController: SSFLineChartViewDataSource {
    //Horizontal presention
    func numberOfHorizontalAxis(lineChartView: SSFLineChartView) -> Int {
        return dataArrHorizontal.count
    }
    
    func lineChartView(lineChartView: SSFLineChartView, titleForHorizontalIndex index: Int) -> String {
        return dataArrHorizontal[index]
    }
    
    func lineChartView(lineChartView: SSFLineChartView, valueForHorizontalIndex index: Int) -> Double? {
        if index > dataArrValue.count - 1 {
            return nil
        }
        return dataArrValue[index]
    }
    
    //Vertical presentaion
    func numberOfVerticalAxis(lineChartView: SSFLineChartView) -> Int {
        return dataArrVertical.count
    }
    
    func lineChartView(lineChartView: SSFLineChartView, titleForVerticalIndex index: Int) -> String {
        return dataArrVertical[index]
    }
    
    func widthOfLine(lineChartView: SSFLineChartView) -> Float {
        return 3.0
    }
    
    func openAnimation() -> Bool {
        return true
    }
}
