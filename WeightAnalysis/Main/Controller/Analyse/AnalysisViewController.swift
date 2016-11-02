//
//  AnalysisViewController.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/27.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController {

    let dataArrHorizontal = ["周六","周日","周一","周二","周三","周四","周五"]
    var dataArrValue: [Double] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0] {
        didSet {
            lineChartView.reloadData()
            barChartView.reloadData()
        }
    }
    let dataArrVertical = ["0","25","50","75","100","125","150","175","200","225"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateData), name: NSNotification.Name(rawValue: RecordUpdateKey), object: nil)
        updateData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.lineChartView.datasource = self
        self.barChartView.datasource = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: RecordUpdateKey), object: nil)
    }
    
    @objc private func updateData() {
        if let arr = AnalysisBrain().fetchRecordsOfCurrentWeek() {
            
            let array = arr.map {
                ($0.weight,($0.time!.translatedDate?.weekdayIndex)!)
            }
            for (weight,index) in array {
                dataArrValue.replaceSubrange(index...index, with: [weight])
            }
        }
    }
    
    @IBOutlet weak var lineChartView: SSFLineChartView!
    @IBOutlet weak var barChartView: SSFBarChartView!

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
    
    func openAnimation(lineChartView: SSFLineChartView) -> Bool {
        return true
    }
}

extension AnalysisViewController: SSFBarChartViewDataSource {
    //Horizontal presentaion
    func numberOfHorizontalAxis(barChartView: SSFBarChartView) -> Int {
        return self.dataArrHorizontal.count
    }
    
    func barChartView(barChartView: SSFBarChartView, titleForHorizontalIndex index: Int) -> String {
        return self.dataArrHorizontal[index]
    }
    
    func barChartView(barChartView: SSFBarChartView, valueForHorizontalIndex index: Int) -> Double? {
        if index > dataArrValue.count - 1 {
            return nil
        }
        return dataArrValue[index]
    }
    
    //Vertical presentaion
    func numberOfVerticalAxis(barChartView: SSFBarChartView) -> Int {
        return self.dataArrVertical.count
    }
    
    func barChartView(barChartView: SSFBarChartView, titleForVerticalIndex index: Int) -> String {
        return self.dataArrVertical[index]
    }
    
    //bar UI
    func colorOfBar(barChartView: SSFBarChartView) -> UIColor {
        return UIColor.white
    }
    
    func widthOfBar(barChartView: SSFBarChartView) -> Float {
        return 20.0
    }
    
    //Wheather start the animation.
    func openAnimation(barChartView: SSFBarChartView) -> Bool {
        return true
    }
}
