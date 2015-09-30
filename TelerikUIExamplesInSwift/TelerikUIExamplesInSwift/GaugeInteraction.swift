//
//  GaugeInteraction.swift
//  TelerikUIExamplesInSwift
//
//  Created by Miroslava Ivanova on 9/24/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class GaugeInteraction: ExampleViewController, TKGaugeDelegate {
    
    let linearGauge = TKLinearGauge()
    let radialGauge = TKRadialGauge()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRadialGauge()
        addLinearGauge()
    }
    
    func addRadialGauge() {

        self.radialGauge.delegate = self
        self.radialGauge.labelTitle.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        self.radialGauge.labelTitle.text = "28˚C"
        self.radialGauge.labelSubtitle.text = "temperature"
        self.radialGauge.labelSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        self.view.addSubview(self.radialGauge)
        
        let scale = TKGaugeRadialScale(minimum: 10, maximum: 40)
        scale.ticks.hidden = true
        scale.radius = 0.8
        scale.stroke = TKStroke(color: UIColor(white: 0.7, alpha: 1.0), width: 3)
        scale.labels.position = TKGaugeLabelsPosition.Outer
        scale.labels.offset = 0.1
        self.radialGauge.addScale(scale)
        
        let segment = TKGaugeSegment(minimum: 10, maximum: 28)
        segment.allowTouch = true
        segment.location = 0.84
        segment.width = 0.08
        segment.shadowColor = UIColor.blackColor().CGColor
        segment.shadowOffset = CGSizeMake(5, 5)
        segment.shadowOpacity = 0.8
        segment.shadowRadius = 5
        scale.addSegment(segment)
    }
    
    func addLinearGauge() {
        
        self.linearGauge.frame = CGRectMake(0, 0, 0, 100)
        self.linearGauge.labelTitle.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        self.linearGauge.labelTitle.text = "85 %"
        self.linearGauge.labelSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        self.linearGauge.labelSubtitle.text = "humidity"
        self.linearGauge.delegate = self
        self.view.addSubview(self.linearGauge)
        
        let scale = TKGaugeLinearScale(minimum: 0, maximum: 100)
        scale.ticks.hidden = true
        scale.stroke = TKStroke(color: UIColor(white: 0.7, alpha: 1.0), width: 3)
        scale.labels.position = TKGaugeLabelsPosition.Outer
        scale.labels.offset = 0.2
        scale.offset = 0.2
        self.linearGauge.addScale(scale)
        
        let segment = TKGaugeSegment(minimum: 0, maximum: 85)
        segment.allowTouch = true
        segment.location = 0.13
        segment.shadowColor = UIColor.blackColor().CGColor
        segment.shadowOffset = CGSizeMake(5, 5)
        segment.shadowOpacity = 0.8
        segment.shadowRadius = 5
        segment.width = 0.1
        segment.width2 = 0.1
        scale.addSegment(segment)
    }
    
    func gauge(gauge: TKGauge, valueChanged value: CGFloat, forScale scale: TKGaugeScale) {
        if(gauge == self.radialGauge) {
            self.radialGauge.labelTitle.text = "\(Int(value))˚C"
        }
        else {
            self.linearGauge.labelTitle.text = "\(Int(value)) %"
        }
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        
        let bounds = self.exampleBounds
        let size = self.view.bounds.size
        let offset = CGFloat(20)
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            let width = CGFloat((size.width - offset*2.0)/2.0)
            linearGauge.frame = CGRectMake(offset + offset/2.0 + width, (size.height - offset*3 - bounds.origin.y)/2.0, width, linearGauge.frame.size.height)
            radialGauge.frame = CGRectMake(offset, bounds.origin.y + 20, width, size.height - bounds.origin.y - offset*3)
        }
        else {
            linearGauge.frame = CGRectMake(offset, size.height - linearGauge.frame.size.height - offset*2, size.width - offset*2, linearGauge.frame.size.height)
            radialGauge.frame = CGRectMake(offset, bounds.origin.y + 20, size.width - offset*2, linearGauge.frame.origin.y - bounds.origin.y - offset*2)
        }
    }
}

