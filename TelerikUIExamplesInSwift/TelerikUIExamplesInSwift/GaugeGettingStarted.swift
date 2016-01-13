//
//  GaugeGettingStarted.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class GaugeGettingStarted: TKExamplesExampleViewController, TKGaugeDelegate {
    
    let radialGauge = TKRadialGauge()
    let linearGauge = TKLinearGauge(frame: CGRectMake(0, 0, 150, 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLinearGauge();
        setRadialGauge();
    }
    
    func setRadialGauge() {
        
        radialGauge.delegate = self
        self.view.addSubview(radialGauge)
        
        let scale = TKGaugeRadialScale(minimum: 0, maximum: 6)
        radialGauge.addScale(scale)

        scale.addIndicator(TKGaugeNeedle(value: 2.3, length: 0.6))

        let colors = [ UIColor(red: 0.871, green: 0.871, blue: 0.871, alpha: 1.00),
                       UIColor(red: 0.533, green: 0.796, blue: 0.290, alpha: 1.00),
                       UIColor(red: 1.000, green: 0.773, blue: 0.247, alpha: 1.00),
                       UIColor(red: 1.000, green: 0.467, blue: 0.161, alpha: 1.00),
                       UIColor(red: 0.769, green: 0.000, blue: 0.043, alpha: 1.00) ]

        let rangeWidth = scale.range.maximum!.floatValue / (Float)(colors.count)
        var start = Float(0)
        for color in colors {
            let segment = TKGaugeSegment(minimum: start, maximum: start+rangeWidth)
            segment.fill = TKSolidFill(color: color)
            scale.addSegment(segment)
            start += rangeWidth
        }
    }
    
    func setLinearGauge() {
        
        linearGauge.delegate = self
        linearGauge.orientation = TKLinearGaugeOrientation.Vertical
        self.view.addSubview(linearGauge)
        
        let scale = TKGaugeLinearScale(minimum: -10, maximum: 40)
        linearGauge.addScale(scale)
        
        let segment = TKGaugeSegment(minimum: -10, maximum: 18)
        segment.location = 0.56
        segment.width = 0.05
        segment.width2 = 0.05
        segment.cap = TKGaugeSegmentCap.Round
        scale.addSegment(segment)
        
        let colors = [ UIColor(red:0.149, green:0.580, blue:0.776, alpha:1.00),
                       UIColor(red:0.537, green:0.796, blue:0.290, alpha:1.00),
                       UIColor(red:1.000, green:0.773, blue:0.247, alpha:1.00),
                       UIColor(red:1.000, green:0.463, blue:0.157, alpha:1.00),
                       UIColor(red:0.769, green:0.000, blue:0.047, alpha:1.00) ]

        let rangeWidth = (scale.range.maximum!.floatValue - scale.range.minimum!.floatValue) / Float(colors.count)
        var start = Float(scale.range.minimum!.floatValue)
        for color in colors {
            let segment = TKGaugeSegment(minimum: start, maximum:start+rangeWidth)
            segment.fill = TKSolidFill(color: color)
            segment.location = 0.5
            segment.width = 0.05
            segment.width2 = 0.05
            scale.addSegment(segment)
            start += rangeWidth
        }
    }
    
    //MARK: - TKCalendarDelegate

    func gauge(gauge: TKGauge, textForLabel label: AnyObject) -> String? {
        
        if gauge.isKindOfClass(TKRadialGauge.self) {
            return NSString(format: "%d bar", label.integerValue) as String
        }
        else {
            return NSString(format: "%d degrees", label.integerValue) as String
        }
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let bounds = self.view.bounds
        let size = self.view.bounds.size
        let offset = CGFloat(20)
        let linearWidth = CGRectGetWidth(self.linearGauge.frame)
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            let width = (size.width - offset*3.0)/2.0
            self.radialGauge.frame = CGRectMake(offset*2, bounds.origin.y + offset, width, bounds.size.height - offset*2.0)
            let x = CGRectGetMaxX(self.radialGauge.frame)
            self.linearGauge.frame = CGRectMake(x + offset + (bounds.size.width - x - linearWidth)/2.0,
                bounds.origin.y + offset, linearWidth, bounds.size.height - offset*2)
        }
        else {
            let height = (self.view.bounds.size.height - offset*3.0)/2.0
            radialGauge.frame = CGRectMake(offset, bounds.origin.y + offset, size.width - offset*2.0, height)
            linearGauge.frame = CGRectMake((bounds.size.width - linearWidth - offset*2.0)/2.0 + offset,
                size.height - height - offset, linearWidth, height)
        }
    }
}
