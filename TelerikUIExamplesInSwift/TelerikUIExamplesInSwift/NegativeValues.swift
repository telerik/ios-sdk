//
//  NegativeValues.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class NegativeValues: ExampleViewController {
    
    let chart = TKChart()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        let dataPoints = NSMutableArray()
        for i in 0..<10 {
            var y = CGFloat(i*10)
            dataPoints.addObject(TKChartDataPoint(x:i, y:(i % 2==0 ? -y : y)))
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