//
//  CustomAnimationLineChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation
import QuartzCore

class CustomAnimationLineChart: ExampleViewController, TKChartDelegate {
    
    let chart = TKChart()
    var grow = false

    override init() {
        super.init()

        self.addOption("Sequential animation") { self.applySequential() }
        self.addOption("Grow animation") { self.applyGrow() }
        
        self.selectedOption = 0
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
        
        let points = NSMutableArray()
        for i in 0..<10 {
            points.addObject(TKChartDataPoint(x: i, y: Int(arc4random() % 100)))
        }
        
        let lineSeries = TKChartLineSeries(items: points)
        let shapeSize = CGFloat(UIDevice.currentDevice().userInterfaceIdiom == .Phone ? 14 : 17)
        lineSeries.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(shapeSize, shapeSize))
        lineSeries.style.shapeMode = TKChartSeriesStyleShapeMode.AlwaysShow
        lineSeries.selectionMode = TKChartSeriesSelectionMode.DataPoint
        chart.addSeries(lineSeries)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func applySequential() {
        self.grow = false
        chart.delegate = self
        chart.animate()
    }
    
    func applyGrow() {
        self.grow = true
        chart.delegate = self
        chart.animate()
    }
    
    //MARK: - TKChartDelegate
    
    func chart(chart: TKChart!, animationForSeries series: TKChartSeries!, withState state: TKChartSeriesRenderState!, inRect rect: CGRect) -> CAAnimation! {
        var duration = 0.0
        let animations = NSMutableArray()
        for i in 0..<state.points.count() {
            if grow {
                let keyPath = NSString(format: "seriesRenderStates.%lu.points.%d.x", series.index, i)
                let point = state.points.objectAtIndex(i) as TKChartVisualPoint
                let animation = CABasicAnimation(keyPath: keyPath)
                animation.duration = 0.1*(Double(i)+0.2)
                animation.fromValue = 0
                animation.toValue = point.x
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                animations.addObject(animation)
                
                duration = animation.duration
            }
            else {
                let keyPath = NSString(format: "seriesRenderStates.%lu.points.%d.y", series.index, i)
                let point = state.points.objectAtIndex(i) as TKChartVisualPoint
                let oldY = rect.size.height as CGFloat
                
                if i > 0 {
                    let animation = CAKeyframeAnimation(keyPath: keyPath)
                    animation.duration = 0.1*(Double(i)+1.0)
                    animation.values = [oldY, oldY, point.y]
                    animation.keyTimes = [0, (i/(i+1)), 1]
                    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                    animations.addObject(animation)
                    
                    duration = animation.duration
                }
                else {
                    let animation = CABasicAnimation(keyPath: keyPath)
                    animation.fromValue = oldY
                    animation.toValue = point.y
                    animation.duration = 0.1
                    animations.addObject(animation)
                }
            }
        }
        
        let group = CAAnimationGroup()
        group.duration = duration
        group.animations = animations
        
        return group
    }
}