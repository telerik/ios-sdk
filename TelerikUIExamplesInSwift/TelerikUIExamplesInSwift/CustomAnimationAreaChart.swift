//
//  CustomAnimationAreaChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation
import QuartzCore

class CustomAnimationAreaChart: TKExamplesExampleViewController, TKChartDelegate {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        chart.allowAnimations = true
        chart.delegate = self
        self.view.addSubview(chart)

        var points = [TKChartDataPoint]()
        for i in 0..<10 {
            points.append(TKChartDataPoint(x: i, y: Int(arc4random() % 100)))
        }
        
        let areaSeries = TKChartAreaSeries(items: points)
        areaSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(areaSeries)
        
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChange:",
            name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        UIDevice.currentDevice().endGeneratingDeviceOrientationNotifications()
    }
    
    func deviceOrientationDidChange(notification: NSNotification) {
        chart.animate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TKChartDelegate
    
    func chart(chart: TKChart, animationForSeries series: TKChartSeries, withState state: TKChartSeriesRenderState, inRect rect: CGRect) -> CAAnimation? {
        let duration = 0.5
        var animations = [CAAnimation]()
        for i in 0..<state.points.count() {
            let keyPath = "seriesRenderStates.\(series.index).points.\(i).y"
            let point = state.points.objectAtIndex(i) as! TKChartVisualPoint
            let oldY = rect.size.height
            
            let half = oldY + (point.y - oldY)/2 as CGFloat
            let a = CAKeyframeAnimation(keyPath: keyPath)
            a.keyTimes = [0, 0, 1]
            a.values = [oldY, half, point.y]
            a.duration = duration
            a.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animations.append(a)
        }
        
        let group = CAAnimationGroup()
        group.duration = duration
        group.animations = animations
        return group
    }
}
