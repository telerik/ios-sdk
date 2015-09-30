//
//  GaugeScales.swift
//  TelerikUIExamplesInSwift
//
//  Created by Miroslava Ivanova on 9/24/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class GaugeScales: ExampleViewController {
    
    let linearGauge = TKLinearGauge()
    let radialGauge = TKRadialGauge()
    let colors = [ UIColor(red: 0.24, green: 0.47, blue: 0.85, alpha: 1.0),
                   UIColor(red: 0.46, green: 0.63, blue: 0.89, alpha: 1.0),
                   UIColor(red: 0.60, green: 0.73, blue: 0.93, alpha: 1.0) ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRadialGauge()
        setupLinearGauge()
    }
    
    func setupRadialGauge() {
        
        self.radialGauge.labelTitle.text = "celsius"
        self.radialGauge.labelSubtitle.text = "farenheit"
        self.radialGauge.labelOffset = CGPointMake(0, 60)
        self.view.addSubview(self.radialGauge)
        
        let scale1 = TKGaugeRadialScale(minimum: 34, maximum: 40)
        scale1.ticks.position = TKGaugeTicksPosition.Inner
        self.radialGauge.addScale(scale1)
        
        let blueSegment = TKGaugeSegment(minimum: 34, maximum: 36)
        blueSegment.location = 0.70
        blueSegment.width = 0.08
        scale1.addSegment(blueSegment)
        
        let redSegment = TKGaugeSegment(minimum: 36.05, maximum: 40)
        redSegment.location = 0.70
        redSegment.width = 0.08
        redSegment.fill = TKSolidFill(color: UIColor.redColor())
        scale1.addSegment(redSegment)

        let scale2 = TKGaugeRadialScale(minimum: 93.2, maximum: 104)
        self.radialGauge.addScale(scale2)

        scale2.ticks.position = TKGaugeTicksPosition.Outer
        scale2.ticks.majorTicksCount = 6
        scale2.ticks.minorTicksCount = 20
        scale2.labels.position = TKGaugeLabelsPosition.Outer
        scale2.labels.labelFormat = "%.01f"
        scale2.labels.count = 6
        
        for i in 0..<self.radialGauge.scales.count {
            let scale = self.radialGauge.scales[i] as! TKGaugeRadialScale
            scale.stroke = TKStroke(color:UIColor.grayColor(), width:2)
            scale.ticks.majorTicksStroke = TKStroke(color:UIColor.grayColor(), width:1)
            scale.labels.color = UIColor.grayColor()
            scale.ticks.offset = 0
             scale.labels.offset = 0.10
            scale.radius = CGFloat(i)*0.12 + 0.60
        }
        
        self.setNeedle(scale1)
    }
    
    func setupLinearGauge() {
        
        self.linearGauge.labelTitle.text = "celsius"
        self.linearGauge.labelSubtitle.text = "farenheit"
        self.linearGauge.labelOrientation = TKLinearGaugeOrientation.Vertical
        self.linearGauge.labelSpacing = 75
        self.linearGauge.labelOffset = CGPointMake(0, 85)
        self.view.addSubview(self.linearGauge)
        
        let scale1 = TKGaugeLinearScale(minimum: 34, maximum: 40)
        scale1.ticks.position = TKGaugeTicksPosition.Inner
        self.linearGauge.addScale(scale1)
        
        let blueSegment = TKGaugeSegment(minimum: 34, maximum: 36)
        blueSegment.width = 0.08
        blueSegment.width2 = 0.08
        blueSegment.location = 0.62
        scale1.addSegment(blueSegment)
        
        let redSegment = TKGaugeSegment(minimum: 36.05, maximum: 40)
        redSegment.location = 0.62
        redSegment.width = 0.08
        redSegment.width2 = 0.08
        redSegment.fill = TKSolidFill(color: UIColor.redColor())
        scale1.addSegment(redSegment)
        
        self.setNeedle(scale1)

        let scale2 = TKGaugeLinearScale(minimum: 93.2, maximum: 104)
        self.linearGauge.addScale(scale2)

        scale2.ticks.position = TKGaugeTicksPosition.Outer
        scale2.ticks.majorTicksCount = 6
        scale2.ticks.minorTicksCount = 20
        scale2.labels.position = TKGaugeLabelsPosition.Outer
        scale2.labels.labelFormat = "%.01f"
        scale2.labels.count = 6

        for i in 0..<self.linearGauge.scales.count {
            let s = self.linearGauge.scales[i] as! TKGaugeLinearScale
            s.stroke = TKStroke(color:UIColor.grayColor(), width:2)
            s.ticks.majorTicksStroke = TKStroke(color:UIColor.grayColor(), width:1)
            s.labels.color = UIColor.grayColor()
            s.ticks.offset = 0
            s.offset = CGFloat(i)*0.12 + 0.60
        }
    }
    
    func setNeedle(scale:TKGaugeScale) -> Void {
        let needle = TKGaugeNeedle(value: 36)
        needle.length = 0.5
        needle.width = 2
        needle.topWidth = 2
        needle.shadowOpacity = 0.5
        scale.addIndicator(needle)
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
        
        let bounds = self.exampleBounds
        let size = self.view.bounds.size
        let offset = CGFloat(20)
        let linearHeight = CGFloat(150)
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            let width = (CGRectGetWidth(bounds) - offset*3.0)/2.0
            let height = CGRectGetHeight(bounds) - offset*2.0
            self.linearGauge.frame = CGRectMake(offset, offset + (size.height - linearHeight)/2, width, linearHeight)
            self.radialGauge.frame = CGRectMake(offset + width, offset + (size.height - height)/2, width + offset, height)
            
        }
        else {
            let width = CGRectGetWidth(bounds) - offset*2.0
            let height = (CGRectGetHeight(bounds) - offset*3.0)/2.0
            self.linearGauge.frame = CGRectMake(offset, (offset + height)/2.0, width, linearHeight)
            self.radialGauge.frame = CGRectMake(offset, (size.height + offset)/2.0, width, height)
        }
    }
}

