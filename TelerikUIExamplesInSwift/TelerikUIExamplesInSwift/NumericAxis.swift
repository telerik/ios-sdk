//
//  NumericAxis.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class NumericAxis: TKExamplesExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // >> chart-getting-started-swift
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        // << chart-getting-started-swift
        
        // >> chart-getting-started-cus-swift
        chart.title.hidden = false
        chart.title.text = "This is a chart demo"
        chart.legend.hidden = false
        chart.allowAnimations = true
        // << chart-getting-started-cus-swift
        
        // >> chart-getting-started-data-swift
        var array = [TKChartDataPoint]()
        for i in 0..<12 {
            array.append(TKChartDataPoint(x: i, y: Int(arc4random() % 2000)))
        }
        // << chart-getting-started-data-swift
        
        // >> chart-getting-started-series-swift
        let series = TKChartLineSeries(items:array)
        series.selection = TKChartSeriesSelection.Series
        chart.addSeries(series)
        // << chart-getting-started-series-swift
        
        let xAxis = TKChartNumericAxis(minimum:0, andMaximum:11)
        xAxis.position = TKChartAxisPosition.Bottom
        xAxis.majorTickInterval = 1;
        chart.xAxis = xAxis
        
        // >> chart-axis-numeric-swift
        let yAxis = TKChartNumericAxis(minimum:0, andMaximum:2000)
        yAxis.majorTickInterval = 400
        yAxis.position = TKChartAxisPosition.Left
        yAxis.labelDisplayMode = TKChartNumericAxisLabelDisplayMode.Percentage
        chart.yAxis = yAxis
        // << chart-axis-numeric-swift
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
