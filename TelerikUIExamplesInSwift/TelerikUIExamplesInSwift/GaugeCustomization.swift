//
//  GaugeCustomization.swift
//  TelerikUIExamplesInSwift
//
//  Created by Miroslava Ivanova on 9/24/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class GaugeCustomization: ExampleViewController {
    
    let linearGauge = TKLinearGauge()
    let radialGauge = TKRadialGauge()
    let colors = [ UIColor(red: 0.00, green: 0.70, blue: 0.90, alpha: 1.00),
                   UIColor(red: 0.38, green: 0.73, blue: 0.00, alpha: 1.00),
                   UIColor(red: 0.96, green: 0.56, blue: 0.00, alpha: 1.00),
                   UIColor(red: 0.00, green: 1.00, blue: 1.00, alpha: 1.00),
                   UIColor(red: 0.77, green: 1.00, blue: 0.00, alpha: 1.00),
                   UIColor(red: 1.00, green: 0.85, blue: 0.00, alpha: 1.00) ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let legedStrings = ["MOVE", "EXCERCISE", "STAND"]
        for i in 0..<3 {
            let view = TKView(frame: CGRectMake(20, 80 + CGFloat(i)*25, 22, 22))
            view.fill = TKLinearGradientFill(colors: [colors[i], colors[i+3]])
            view.shape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeZero)
            self.view.addSubview(view)
            
            let label = UILabel(frame: CGRectMake(50, 80 + CGFloat(i)*25, CGRectGetMaxX(self.view.frame) - 60, 20))
            label.text = legedStrings[i]
            label.font = UIFont(name: "HelveticaNeue-Light", size: 15)
            label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            self.view.addSubview(label)
        }
        
        setupRadialGauge()
        setupLinearGauge()
    }
    
    func setupRadialGauge() {
        
        self.view.addSubview(radialGauge)
        
        let scale = TKGaugeRadialScale()
        scale.startAngle = 0
        scale.endAngle = CGFloat(M_PI*2)
        scale.stroke = nil
        scale.ticks.hidden = true
        scale.labels.hidden = true
        radialGauge.addScale(scale)
        
        for i in 0..<3 {
            let segment = TKGaugeSegment(minimum: 0, maximum: 100)
            segment.fill = TKSolidFill(color:colors[i].colorWithAlphaComponent(0.4))
            segment.cap = TKGaugeSegmentCap.Round
            segment.width = 0.2
            segment.location = 0.5 + CGFloat(i) * 0.25
            scale.addSegment(segment)
            
            let gradientSegment = TKGaugeSegment()
            gradientSegment.fill = TKLinearGradientFill(colors: [colors[i], colors[i + 3]])
            gradientSegment.cap = TKGaugeSegmentCap.Round
            gradientSegment.width = 0.2
            gradientSegment.location = 0.5 + CGFloat(i) * 0.25
            scale.addSegment(gradientSegment)
            
            gradientSegment.setRangeAnimated(TKRange(minimum: 0.0, andMaximum: Double(arc4random_uniform(50)) + 30.0),
                withDuration: 0.5 + CGFloat(arc4random_uniform(200))/200.0, mediaTimingFunction: kCAMediaTimingFunctionEaseInEaseOut)
        }
    }
    
    func setupLinearGauge() {
        
        self.view.addSubview(linearGauge)
        
        let scale = TKGaugeLinearScale()
        scale.stroke = nil
        scale.ticks.hidden = true
        scale.labels.hidden = true
        linearGauge.addScale(scale)
        
        for i in 0..<3 {
            let segment = TKGaugeSegment(minimum: 0, maximum: 100)
            segment.fill = TKSolidFill(color: colors[i].colorWithAlphaComponent(0.4))
            segment.width = 0.2
            segment.width2 = 0.2
            segment.location = CGFloat(i) * 0.3
            segment.cap = TKGaugeSegmentCap.Round
            scale.addSegment(segment)
            
            let gradientSegment = TKGaugeSegment()
            gradientSegment.fill = TKLinearGradientFill(colors: [colors[i], colors[i + 3]])
            gradientSegment.width = 0.2
            gradientSegment.width2 = 0.2
            gradientSegment.location = CGFloat(i) * 0.3
            gradientSegment.cap = TKGaugeSegmentCap.Round
            scale.addSegment(gradientSegment)
            
            gradientSegment.setRangeAnimated(TKRange(minimum: 0.0, andMaximum: Double(arc4random_uniform(50)) + 20.0),
                withDuration: 0.5 + CGFloat(arc4random_uniform(200))/200.0, mediaTimingFunction: kCAMediaTimingFunctionEaseInEaseOut)
        }
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let bounds = self.exampleBoundsWithInset
        let size = self.view.bounds.size
        let offset = CGFloat(20)
        let linearHeight = CGFloat(130)
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            let width = (CGRectGetWidth(bounds) - offset*3.0)/2.0
            let height = CGRectGetHeight(bounds) - offset*2.0
            linearGauge.frame = CGRectMake(offset, size.height/2.0, width, linearHeight)
            radialGauge.frame = CGRectMake(2*offset + width, offset*2.0, width, height)
        }
        else {
            let width = CGRectGetWidth(bounds) - offset*2.0
            let height = (CGRectGetHeight(bounds) - offset*3.0)/2.0
            linearGauge.frame = CGRectMake(offset, size.height/3.0, width, linearHeight)
            radialGauge.frame = CGRectMake(offset, size.height/3.0 + linearHeight, width, height)
        }
    }
}
