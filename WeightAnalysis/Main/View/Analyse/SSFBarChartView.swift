//
//  SSFBarChartView.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit

class SSFBarChartView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, datasource:SSFBarChartViewDataSource) {
        self.init(frame:frame)
        self.datasource = datasource
        let startPoint = CGPoint(x: horizontalGapWidth, y: (Double(frame.size.height) - verticalGapWidth))
        origionPoint = ChartPoint(x: Double(startPoint.x), y: Double(startPoint.y))
    }
    
    weak var datasource: SSFBarChartViewDataSource?
    
    //y方向比例尺
    var ratio: Double {
        let index = datasource?.numberOfVerticalAxis(barChartView: self)
        return (Double(self.frame.size.height) - verticalGapWidth * 2)/Double((datasource?.barChartView(barChartView: self, titleForVerticalIndex: (index!-1)))!)!
    }
    
    let horizontalGapWidth = 18.0, verticalGapWidth = 15.0, horizontalAxisGap = 20.0, titleToLineGap = 3.0
    
    ///原点
    var origionPoint: ChartPoint!
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(self.datasource?.colorOfBar(barChartView: self).cgColor ?? UIColor.white.cgColor)
        drawAxis()
        drawChartBar()
    }
    
    ///Draw the vertical and horizontal axis with the datasource.
    private func drawAxis() {
        drawAxisLine()
        drawAxisTitle()
    }
    
    private func drawAxisLine() {
        let startPoint = CGPoint(x: horizontalGapWidth, y: (Double(self.frame.size.height) - verticalGapWidth))
        let endPointHorizontal = CGPoint(x: Double(self.frame.size.width) - horizontalGapWidth, y: Double(self.frame.size.height) - verticalGapWidth)
        let endPointVertical = CGPoint(x: horizontalGapWidth, y: verticalGapWidth)
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPointHorizontal)
        path.move(to: startPoint)
        path.addLine(to: endPointVertical)
        path.lineWidth = 1.0
        path.close()
        path.stroke()
    }
    
    var averageGapWidthHorizontal: Double = 0.0
    
    var averageGapWidthVertical: Double = 0.0
    
    private func drawAxisTitle() {
        if let dsource = self.datasource {
            let numberHorizontal = dsource.numberOfHorizontalAxis(barChartView: self)
            let numberVertical = dsource.numberOfVerticalAxis(barChartView: self)
            averageGapWidthHorizontal = (Double(self.frame.size.width) - horizontalGapWidth * 2 - horizontalAxisGap)/Double(numberHorizontal - 1)
            averageGapWidthVertical = (Double(self.frame.size.height) - verticalGapWidth * 2)/Double(numberVertical)
            
            var indexArrHorizontal:[Int] = [], indexArrVertical:[Int] = []
            for index in (0..<numberHorizontal) {
                indexArrHorizontal.append(index)
            }
            for index in (0..<numberVertical) {
                indexArrVertical.append(index)
            }
            let titleHorizontalArr = indexArrHorizontal.map{ dsource.barChartView(barChartView: self, titleForHorizontalIndex: $0)
            }
            let titleVerticalArr = indexArrVertical.map{ dsource.barChartView(barChartView: self, titleForVerticalIndex: $0)
            }
            
            draw(horizontalTexts: titleHorizontalArr, averageGapWidth: averageGapWidthHorizontal)
            draw(verticalTexts: titleVerticalArr, averageGapWidth: averageGapWidthVertical)
        }
    }
    
    private func draw(horizontalTexts textArr: [String], averageGapWidth: Double) {
        let attribute = [
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName:UIFont.systemFont(ofSize: 8.0)
        ]
        
        textArr.forEach { title in
            let textSize = title.boundingRect(with: self.frame.size, options: NSStringDrawingOptions.usesFontLeading, attributes: attribute, context: nil).size
            let index = textArr.index(of: title)
            let x = origionPoint.x + horizontalAxisGap + averageGapWidth * Double(index!) - Double(textSize.width/2)
            title.draw(at:CGPoint(x: x, y:origionPoint.y + titleToLineGap),withAttributes:attribute)
        }
    }
    
    private func draw(verticalTexts textArr: [String], averageGapWidth: Double) {
        let attribute = [
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName:UIFont.systemFont(ofSize: 8.0)
        ]
        
        textArr.forEach { title in 
            let textSize = title.boundingRect(with: self.frame.size, options: NSStringDrawingOptions.usesFontLeading, attributes: attribute, context: nil).size
            let index = textArr.index(of: title)
            title.draw(at:CGPoint(x:origionPoint.x/2 - Double(textSize.width/2), y: origionPoint.y - averageGapWidth * Double(index!) - Double(textSize.height/2)),withAttributes:attribute)
        }
    }
    
    ///Draw chart bar with datasource
    private func drawChartBar() {
        var linePoints: [CGPoint] = []
        if let dsource = self.datasource {
            let numberHorizontal = dsource.numberOfHorizontalAxis(barChartView: self)
            for index in (0..<numberHorizontal) {
                if let value = dsource.barChartView(barChartView: self, valueForHorizontalIndex: index) {
                    let y = origionPoint.y - value * ratio
                    let x = origionPoint.x + horizontalAxisGap + averageGapWidthHorizontal * Double(index)
                    linePoints.append(CGPoint(x: x, y: y))
                }
            }
        }
        drawRects(points:linePoints)
    }
    
    private var barLayers: [CAShapeLayer] = []
    
    private func drawRects(points: [CGPoint]) {
        clear()
        barLayers = points.map { point in
            //let index = points.index(of: point)
            let linePath = UIBezierPath()//(rect: CGRect(x: (origionPoint.x + horizontalAxisGap/2) + averageGapWidthHorizontal * Double(index!), y: Double(point.y), width: horizontalAxisGap, height: origionPoint.y - Double(point.y)))
            linePath.move(to: CGPoint(x: point.x, y: CGFloat(origionPoint.y)))
            linePath.addLine(to: point)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = linePath.cgPath
            if let dsource = self.datasource {
                shapeLayer.strokeColor = dsource.colorOfBar(barChartView: self).cgColor
                shapeLayer.fillColor = UIColor.clear.cgColor
                shapeLayer.lineWidth = CGFloat(dsource.widthOfBar(barChartView: self))
                shapeLayer.strokeStart = 0.0
                shapeLayer.strokeEnd = 1.0
                self.layer.addSublayer(shapeLayer)
                
                if dsource.openAnimation(barChartView: self) {
                    performAnimation(layer: shapeLayer)
                }
            }
            return shapeLayer
        }
    }
    
    private func clear() {
        _ = barLayers.map { $0.removeFromSuperlayer() }
        barLayers.removeAll()
    }
    
    private func performAnimation(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.fromValue = layer.strokeStart
        animation.toValue = layer.strokeEnd
        animation.autoreverses = false
        layer.add(animation, forKey: "strokeEnd")
    }
    
    func reloadData() {
        drawChartBar()
    }
}

///This protocol describe the presention of barChartView,only class can adopt it.
protocol SSFBarChartViewDataSource: class {
    
    //Horizontal presentaion
    func numberOfHorizontalAxis(barChartView: SSFBarChartView) -> Int
    func barChartView(barChartView: SSFBarChartView, titleForHorizontalIndex index: Int) -> String
    func barChartView(barChartView: SSFBarChartView, valueForHorizontalIndex index: Int) -> Double?
    
    //Vertical presentaion
    func numberOfVerticalAxis(barChartView: SSFBarChartView) -> Int
    func barChartView(barChartView: SSFBarChartView, titleForVerticalIndex index: Int) -> String
    
    //bar UI
    func colorOfBar(barChartView: SSFBarChartView) -> UIColor
    func widthOfBar(barChartView: SSFBarChartView) -> Float
    
    //Wheather start the animation.
    func openAnimation(barChartView: SSFBarChartView) -> Bool
}

extension SSFBarChartViewDataSource {
    func colorOfBar(barChartView: SSFBarChartView) -> UIColor {
        return UIColor.white
    }
    
    func widthOfBar(barChartView: SSFBarChartView) -> Float {
        return 10.0
    }
    
    func openAnimation(barChartView: SSFBarChartView) -> Bool {
        return false
    }
}

