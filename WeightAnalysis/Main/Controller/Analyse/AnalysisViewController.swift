//
//  AnalysisViewController.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/27.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController {

    var dataDic = ["周六":0.0,"周日":0.0,"周一":0.0,"周二":0.0,"周三":0.0,"周四":0.0,"周五":0.0]
    
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
            dataDic.merge(arr.map { (($0.time?.translatedDate?.weekdayString)!,$0.weight) })
            lineChartView.reloadData()
            barChartView.reloadData()
        }
    }
    
    @IBOutlet weak var lineChartView: SSFLineChartView!
    @IBOutlet weak var barChartView: SSFBarChartView!

}

extension AnalysisViewController: SSFLineChartViewDataSource {
    //Horizontal presention
    func numberOfHorizontalAxis(lineChartView: SSFLineChartView) -> Int {
        return dataDic.count//dataArrHorizontal.count
    }
    
    func lineChartView(lineChartView: SSFLineChartView, titleForHorizontalIndex index: Int) -> String {
        let titleArr = dataDic.keys.sorted(by: >) as Array
        return titleArr[index]//dataArrValue[index]
    }
    
    func lineChartView(lineChartView: SSFLineChartView, valueForHorizontalIndex index: Int) -> Double? {
        if index > dataDic.count - 1 {
            return nil
        }
        let keyArr = dataDic.keys.sorted(by: >) as Array
        return dataDic[keyArr[index]]//dataArrValue[index]
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
        return self.dataDic.count
    }
    
    func barChartView(barChartView: SSFBarChartView, titleForHorizontalIndex index: Int) -> String {
        let titleArr = dataDic.keys.sorted(by: >) as Array
        return titleArr[index]//dataArrValue[index]
    }
    
    func barChartView(barChartView: SSFBarChartView, valueForHorizontalIndex index: Int) -> Double? {
        if index > dataDic.count - 1 {
            return nil
        }
        let keyArr = dataDic.keys.sorted(by: >) as Array
        return dataDic[keyArr[index]]//dataArrValue[index]
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
