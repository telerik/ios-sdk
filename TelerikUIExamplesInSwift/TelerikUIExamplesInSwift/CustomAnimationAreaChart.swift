//
//  CustomAnimationAreaChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation
import QuartzCore

class CustomAnimationAreaChart: ExampleViewController, TKChartDelegate {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBounds
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        chart.allowAnimations = true
        chart.delegate = self
        self.view.addSubview(chart)

        let points = NSMutableArray()
        for i in 0..<10 {
            points.addObject(TKChartDataPoint(x: i, y: Int(arc4random() % 100)))
        }
        
        let areaSeries = TKChartAreaSeries(items: points)
        areaSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(areaSeries)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TKChartDelegate
    
    func chart(chart: TKChart!, animationForSeries series: TKChartSeries!, withState state: TKChartSeriesRenderState!, inRect rect: CGRect) -> CAAnimation! {
        let duration = 5.0
        let animations = NSMutableArray()
        for i in 0..<state.points.count() {
            let keyPath = NSString(format: "seriesRenderStates.%lu.points.%d.y", series.index, i)
            let point = state.points.objectAtIndex(i) as TKChartVisualPoint
            let oldY = rect.size.height
            
            let half = oldY + (point.y - oldY)/2 as CGFloat
            let a = CAKeyframeAnimation(keyPath: keyPath)
            a.keyTimes = [0, 0, 1]
            a.values = [oldY, half, point.y]
            a.duration = duration
            a.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animations.addObject(a)
        }
        
        let group = CAAnimationGroup()
        group.duration = duration
        group.animations = animations
        return group
    }
}
