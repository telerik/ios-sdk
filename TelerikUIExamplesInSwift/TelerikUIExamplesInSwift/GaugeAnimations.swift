//
//  GaugeAnimations.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class GaugeAnimations: TKExamplesExampleViewController {
    
    var segmentedControl: UISegmentedControl?
    let radialGauge = TKRadialGauge()
    let linearGauge = TKLinearGauge()
    let label = UILabel()
    let segments = [ "60", "80", "120", "160" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRadialGauge()
        addLinearGauge()
        
        self.segmentedControl = UISegmentedControl(items: segments)
        self.segmentedControl!.selectedSegmentIndex = 0
        self.view.addSubview(self.segmentedControl!)
        self.segmentedControl!.addTarget(self, action: "segmentTouched:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.label.text = "km/h"
        self.label.font = UIFont.systemFontOfSize(12)
        self.view.addSubview(self.label)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var needle = radialGauge.scales[0].indicators[0] as! TKGaugeNeedle
        needle.setValueAnimated(60, withDuration: 0.5, mediaTimingFunction: kCAMediaTimingFunctionEaseInEaseOut)

        needle = linearGauge.scales[0].indicators[0] as! TKGaugeNeedle
        needle.setValueAnimated(1.8, withDuration: 0.7, mediaTimingFunction: kCAMediaTimingFunctionEaseInEaseOut)
    }
    
    func addRadialGauge() {

        self.radialGauge.labelSubtitle.text = "km/h"
        self.view.addSubview(self.radialGauge)
        
        let scale = TKGaugeRadialScale(minimum: 0, maximum: 180)
        scale.labels.count = 9
        scale.ticks.majorTicksCount = 18
        scale.ticks.minorTicksCount = 1
        scale.ticks.majorTicksLength = 4
        scale.ticks.offset = 0.1
        scale.ticks.majorTicksStroke = TKStroke(color: UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1.00), width: 2)
        self.radialGauge.addScale(scale)
        
        let ranges = [ TKRange(minimum: 0, andMaximum: 60),
                       TKRange(minimum: 61, andMaximum: 120),
                       TKRange(minimum: 121, andMaximum: 180) ]
        
        let colors = [ UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1.00),
                       UIColor(red: 0.200, green: 0.200, blue: 0.200, alpha: 1.00),
                       UIColor(red: 0.886, green: 0.329, blue: 0.353, alpha: 1.00) ]
        
        for i in 0..<ranges.count {
            let segment = TKGaugeSegment(range: ranges[i])
            segment.width = 0.02
            segment.fill = TKSolidFill(color: colors[i])
            scale.addSegment(segment)
        }

        let needle = TKGaugeNeedle()
        needle.length = 0.8
        needle.width = 3
        needle.topWidth = 3
        needle.shadowOffset = CGSizeMake(1, 1);
        needle.shadowOpacity = 0.8;
        needle.shadowRadius = 1.5;
        scale.addIndicator(needle)
    }
    
    func addLinearGauge() {
        self.linearGauge.frame = CGRectMake(0, 0, 0, 100)
        self.linearGauge.labelSubtitle.text = "rpm x 1000"
        self.view.addSubview(self.linearGauge)
        
        let scale = TKGaugeLinearScale(minimum: 0, maximum: 8)
        scale.offset = 0.55;
        scale.ticks.minorTicksCount = 1;
        scale.ticks.majorTicksCount = 14;
        scale.ticks.majorTicksLength = 4;
        scale.ticks.majorTicksStroke = TKStroke(color: UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1.00), width: 2)
        self.linearGauge.addScale(scale)
        
        var segment = TKGaugeSegment(minimum: 0, maximum: 5)
        segment.fill = TKSolidFill(color: UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1.00))
        scale.addSegment(segment)
        
        segment = TKGaugeSegment(minimum: 5.1, maximum: 8)
        segment.fill = TKSolidFill(color: UIColor(red: 0.886, green: 0.329, blue: 0.353, alpha: 1.00))
        scale.addSegment(segment)
        
        for segment in scale.segments {
            segment.location = 0.6
            segment.width = 0.01
            segment.width2 = 0.01
        }
        
        let needle = TKGaugeNeedle()
        needle.width = 3;
        needle.topWidth = 3;
        needle.length = 0.6;
        needle.shadowOffset = CGSizeMake(1, 1);
        needle.shadowOpacity = 0.8;
        needle.shadowRadius = 1.5;
        scale.addIndicator(needle)
    }
    
    //MARK: - Touch event
    
    func segmentTouched(source:UISegmentedControl)
    {
        let value = CGFloat(Int(segments[source.selectedSegmentIndex])!)
        var needle = radialGauge.scaleAtIndex(0)!.indicatorAtIndex(0) as! TKGaugeNeedle
        needle.setValueAnimated(value, withDuration: 0.5, mediaTimingFunction: kCAMediaTimingFunctionEaseInEaseOut)
        needle = linearGauge.scaleAtIndex(0)!.indicatorAtIndex(0) as! TKGaugeNeedle
        needle.setValueAnimated((value/180)*7.0, withDuration: 0.5, mediaTimingFunction: kCAMediaTimingFunctionEaseInEaseOut)
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        
        let bounds = self.view.bounds
        let size = self.view.bounds.size
        let offset = CGFloat(20)
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            let width = (size.width - offset*2.0)/2.0
            segmentedControl!.frame = CGRectMake((size.width - 200)/2.0, size.height - segmentedControl!.frame.size.height - offset, 200, segmentedControl!.frame.size.height)
            linearGauge.frame = CGRectMake(offset + offset/2.0 + width, (segmentedControl!.frame.origin.y - offset*2 - bounds.origin.y)/2.0, width, linearGauge.frame.size.height)
            radialGauge.frame = CGRectMake(offset, bounds.origin.y + 20, width, segmentedControl!.frame.origin.y - bounds.origin.y - offset*2)
            label.frame = CGRectMake(CGRectGetMaxX(segmentedControl!.frame) + 5, CGRectGetMinY(segmentedControl!.frame) - 7, 100, 44)
        }
        else {
            segmentedControl!.frame = CGRectMake((size.width - 200)/2.0, size.height - segmentedControl!.frame.size.height - offset, 200, segmentedControl!.frame.size.height)
            linearGauge.frame = CGRectMake(offset, segmentedControl!.frame.origin.y - linearGauge.frame.size.height - offset*2, size.width - offset*2, linearGauge.frame.size.height)
            radialGauge.frame = CGRectMake(offset, bounds.origin.y + 20, size.width - offset*2, linearGauge.frame.origin.y - bounds.origin.y - offset*2)
            label.frame = CGRectMake(CGRectGetMaxX(segmentedControl!.frame) + 5, CGRectGetMinY(segmentedControl!.frame) - 7, 100, 44)
        }
    }
}

