//
//  GaugeRanges.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class GaugeRanges: TKExamplesExampleViewController {
    
    let linearGauge = TKLinearGauge()
    let radialGauge = TKRadialGauge()

    let redColors   = [ UIColor(red: 0.96, green: 0.80, blue: 0.80, alpha: 1.00),
                        UIColor(red: 0.80, green: 0.00, blue: 0.00, alpha: 1.00),
                        UIColor(red: 0.88, green: 0.40, blue: 0.40, alpha: 1.00) ]
    
    let greenColors = [ UIColor(red: 0.85, green: 0.92, blue: 0.83, alpha: 1.00),
                        UIColor(red: 0.71, green: 0.84, blue: 0.66, alpha: 1.00),
                        UIColor(red: 0.58, green: 0.77, blue: 0.49, alpha: 1.00) ]
    
    let blueColors  = [ UIColor(red: 0.62, green: 0.77, blue: 0.91, alpha: 1.00),
                        UIColor(red: 0.44, green: 0.66, blue: 0.86, alpha: 1.00),
                        UIColor(red: 0.11, green: 0.27, blue: 0.53, alpha: 1.00) ]

    let redValues = [ 0, 20, 40, 100 ]
    let greenValues = [ 0, 40, 80, 100 ]
    let blueValues = [ 0, 10, 90, 100 ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let legendStrings = [ "FATS", "CARBS", "PROTEINS" ]
        let legendColors = [ UIColor(red: 0.96, green: 0.80, blue: 0.80, alpha: 1.00),
                             UIColor(red: 0.85, green: 0.92, blue: 0.83, alpha: 1.00),
                             UIColor(red: 0.62, green: 0.77, blue: 0.91, alpha: 1.00)]

        for i in 0..<3 {
            let view = TKView(frame: CGRectMake(20, CGFloat(80 + i*25), 22, 22))
            view.fill = TKSolidFill(color: legendColors[i])
            view.shape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeZero)
            self.view.addSubview(view)
            
            let label = UILabel(frame: CGRectMake(50, CGFloat(80 + i*25), CGRectGetMaxX(self.view.frame) - 60, 20))
            label.text = legendStrings[i]
            label.font = UIFont(name: "HelveticaNeue-Light", size: 15)
            label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            self.view.addSubview(label)
        }
        
        setLinearGauge()
        setRadialGauge()
    }
    
    func setLinearGauge() {
        
        self.view.addSubview(self.linearGauge)
        
        let scale = TKGaugeLinearScale()
        self.linearGauge.addScale(scale)
        
        for i in 0..<3 {
            let segment = TKGaugeSegment(minimum: self.redValues[i], maximum: self.redValues[i+1])
            segment.fill = TKSolidFill(color: self.redColors[i])
            segment.location = 0.55
            segment.cap = TKGaugeSegmentCap.Round
            scale.addSegment(segment)
        }
        
        for i in 0..<3 {
            let segment = TKGaugeSegment(minimum: self.greenValues[i], maximum: self.greenValues[i+1])
            segment.fill = TKSolidFill(color: self.greenColors[i])
            segment.location = 0.67
            segment.cap = TKGaugeSegmentCap.Round
            scale.addSegment(segment)
        }
        
        for i in 0..<3 {
            let segment = TKGaugeSegment(minimum: self.blueValues[i], maximum: self.blueValues[i+1])
            segment.fill = TKSolidFill(color: self.blueColors[i])
            segment.location = 0.79
            segment.cap = TKGaugeSegmentCap.Round
            scale.addSegment(segment)
        }
        
        let lengths = [0.55, 0.67, 0.79]
        for i in 0..<3 {
            let needle = TKGaugeNeedle(value: CGFloat(arc4random_uniform(100)))
            needle.fill = TKSolidFill(color: UIColor.grayColor())
            needle.length = CGFloat(1 - lengths[i])
            scale.addIndicator(needle)
            
        }
    }
    
    func setRadialGauge() {

        self.view.addSubview(self.radialGauge)
        
        let scale = TKGaugeRadialScale()
        scale.radius = 0.76
        scale.ticks.position = TKGaugeTicksPosition.Outer
        scale.labels.position = TKGaugeLabelsPosition.Outer
        scale.labels.offset = 0.15
        scale.ticks.offset = 0.05
        self.radialGauge.addScale(scale)
        
        for i in 0..<3 {
            let segment = TKGaugeSegment(minimum: self.redValues[i], maximum: self.redValues[i+1])
            segment.fill = TKSolidFill(color: self.redColors[i])
            segment.cap = TKGaugeSegmentCap.Round
            segment.location = 0.76
            scale.addSegment(segment)
        }
        
        for i in 0..<3 {
            let segment = TKGaugeSegment(minimum: self.greenValues[i], maximum: self.greenValues[i+1])
            segment.fill = TKSolidFill(color: self.greenColors[i])
            segment.cap = TKGaugeSegmentCap.Round
            segment.location = 0.64
            scale.addSegment(segment)
        }
        
        for i in 0..<3 {
            let segment = TKGaugeSegment(minimum: self.blueValues[i], maximum: self.blueValues[i+1])
            segment.fill = TKSolidFill(color: self.blueColors[i])
            segment.cap = TKGaugeSegmentCap.Round
            segment.location = 0.52
            scale.addSegment(segment)
        }
        
        let lengths = [0.76, 0.64, 0.52]
        for i in 0..<3 {
            let needle = TKGaugeNeedle(value: CGFloat(arc4random_uniform(100)))
            needle.fill = TKSolidFill(color: UIColor.grayColor())
            needle.length = CGFloat(lengths[i])
            scale.addIndicator(needle)
        }
    }

    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
        
        let bounds = self.view.bounds
        let size = self.view.bounds.size
        let offset = CGFloat(20)
        let linearHeight = CGFloat(150)
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            let width = (CGRectGetWidth(bounds) - offset*3.0)/2.0
            let height = CGRectGetHeight(bounds) - offset*2.0
            self.linearGauge.frame = CGRectMake(offset, offset + (size.height - linearHeight)/2, width, linearHeight)
            self.radialGauge.frame = CGRectMake(2*offset + width, offset + (size.height - height)/2, width, height)
            
        }
        else {
            let width = CGRectGetWidth(bounds) - offset*2.0
            let height = (CGRectGetHeight(bounds) - offset*3.0)/2.0
            self.linearGauge.frame = CGRectMake(offset, (offset + height)/2.0, width, linearHeight)
            self.radialGauge.frame = CGRectMake(offset, (size.height + offset)/2.0, width, height)
        }
    }
}
