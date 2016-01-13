//
//  CustomAnimationPieChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation
import QuartzCore

class CustomAnimationPieChart: TKExamplesExampleViewController, TKChartDelegate {
    
    let chart = TKChart()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Animate", action: animate)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        chart.allowAnimations = true
        chart.delegate = self
        self.view.addSubview(chart)
        
        var array = [TKChartDataPoint]()
        array.append(TKChartDataPoint(name: "Apple", value: 10))
        array.append(TKChartDataPoint(name: "Google", value: 20))
        array.append(TKChartDataPoint(name: "Microsoft", value: 30))
        array.append(TKChartDataPoint(name: "IBM", value: 5))
        array.append(TKChartDataPoint(name: "Oracle", value: 8))
        
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
    
    func chart(chart: TKChart, animationForSeries series: TKChartSeries, withState state: TKChartSeriesRenderState, inRect rect: CGRect) -> CAAnimation? {
        var duration = 0.0
        var animations = [CAAnimation]()
        for i in 0..<state.points.count() {
            let pointKeyPath = state.animationKeyPathForPointAtIndex(i)!
            let keyPath = NSString(format: "%@.distanceFromCenter", pointKeyPath)
            var a = CAKeyframeAnimation(keyPath: keyPath as String)
            let interval = 0.3*(Double(i)+1.1)
            
            a.values = [50, 50, 0]
            a.keyTimes = [0.0, (Double(i)/(Double(i)+1.0)), 1.0]
            a.duration = interval
            animations.append(a)
            
            a = CAKeyframeAnimation(keyPath: "\(pointKeyPath).opacity")
            a.values = [0, 0, 1]
            a.keyTimes = [0.0, (Double(i)/(Double(i)+1.0)), 1.0]
            a.duration = interval
            animations.append(a)
            
            duration = interval
        }
        let g = CAAnimationGroup()
        g.duration = duration
        g.animations = animations
        return g
    }
}