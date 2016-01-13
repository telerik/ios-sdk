//
//  NegativeValues.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class NegativeValues: TKExamplesExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        var dataPoints = [TKChartDataPoint]()
        for i in 0..<10 {
            let y = CGFloat(i*10)
            dataPoints.append(TKChartDataPoint(x:i, y:(i % 2==0 ? -y : y)))
        }
        
        let xAxis = TKChartNumericAxis(minimum:0, andMaximum: 9)
        xAxis.position = TKChartAxisPosition.Bottom
        xAxis.majorTickInterval = 1
        xAxis.minorTickInterval = 1
        xAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignment.Right
        chart.xAxis = xAxis
        
        let yAxis = TKChartNumericAxis(minimum:-100, andMaximum: 100)
        yAxis.position = TKChartAxisPosition.Left
        yAxis.majorTickInterval = 20
        yAxis.minorTickInterval = 1
        yAxis.offset = 0
        yAxis.baseline = 0
        yAxis.style.labelStyle.fitMode = TKChartAxisLabelFitMode.Rotate
        yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignment.Left
        yAxis.style.lineStroke = TKStroke(color:UIColor(white:0.85, alpha:1.0), width:2)
        chart.yAxis = yAxis
        
        let series = TKChartSplineAreaSeries(items:dataPoints)
        let shapeSize = CGFloat(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone ? 10 :17)
        series.style.pointShape = TKPredefinedShape(type:TKShapeType.Circle, andSize: CGSizeMake(shapeSize, shapeSize))
        series.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(series)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}