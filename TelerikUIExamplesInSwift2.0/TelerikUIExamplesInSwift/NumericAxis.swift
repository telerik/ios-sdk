//
//  NumericAxis.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class NumericAxis:ExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        var array = [TKChartDataPoint]()
        for i in 0..<12 {
            array.append(TKChartBubbleDataPoint(x:i, y:Int(arc4random() % (2000))))
        }
        let series = TKChartLineSeries(items:array)
        series.selectionMode = TKChartSeriesSelectionMode.Series
        
        let xAxis = TKChartNumericAxis(minimum:0, andMaximum:11)
        xAxis.position = TKChartAxisPosition.Bottom
        xAxis.majorTickInterval = 1;
        chart.xAxis = xAxis
        
        let yAxis = TKChartNumericAxis(minimum:0, andMaximum:2000)
        yAxis.majorTickInterval = 400
        yAxis.position = TKChartAxisPosition.Left
        chart.yAxis = yAxis
        
        chart.addSeries(series)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
