//
//  CustomAnimationPieChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation
import QuartzCore

class CustomAnimationPieChart: ExampleViewController, TKChartDelegate {
    
    let chart = TKChart()
    
    override init() {
        super.init()

        self.addOption("Animate") { self.animate() }
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBounds
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        chart.allowAnimations = true
        chart.delegate = self
        self.view.addSubview(chart)
        
        let array = NSMutableArray()
        array.addObject(TKChartDataPoint(name: "Apple", value: 10))
        array.addObject(TKChartDataPoint(name: "Google", value: 20))
        array.addObject(TKChartDataPoint(name: "Microsoft", value: 30))
        array.addObject(TKChartDataPoint(name: "IBM", value: 5))
        array.addObject(TKChartDataPoint(name: "Oracle", value: 8))
        
        let series = TKChartPieSeries(items: array)
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        chart.addSeries(series)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animate()
    {
        chart.animate()
    }
    
    //MARK: - TKChartDelegate
    
    func chart(chart: TKChart!, animationForSeries series: TKChartSeries!, withState state: TKChartSeriesRenderState!, inRect rect: CGRect) -> CAAnimation! {
        var duration = 0.0
        let animations = NSMutableArray()
        for i in 0..<state.points.count() {
            let pointKeyPath = state.animationKeyPathForPointAtIndex(i) as NSString
            var keyPath = NSString(format: "%@.distanceFromCenter", pointKeyPath)
            var a = CAKeyframeAnimation(keyPath: keyPath)
            var interval = 0.3*(Double(i)+1.1)
            
            a.values = [50, 50, 0]
            a.keyTimes = [0.0, (Double(i)/(Double(i)+1.0)), 1.0]
            a.duration = interval
            animations.addObject(a)
            
            keyPath = NSString(format: "%@.opacity", pointKeyPath)
            a = CAKeyframeAnimation(keyPath: keyPath)
            a.values = [0, 0, 1]
            a.keyTimes = [0.0, (Double(i)/(Double(i)+1.0)), 1.0]
            a.duration = interval
            animations.addObject(a)
            
            duration = interval
        }
        let g = CAAnimationGroup()
        g.duration = duration
        g.animations = animations
        return g
    }
}