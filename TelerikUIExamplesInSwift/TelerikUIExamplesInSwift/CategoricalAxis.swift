//
//  CategoricalAxis.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CategoricalAxis:ExampleViewController {

    let chart = TKChart()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        var array = [TKChartBubbleDataPoint]()
        let categories = ["Apple", "Google", "Microsoft", "Samsung"]
        
        for item in 0..<categories.count {
            array.append(TKChartBubbleDataPoint(x: categories[item], y: Int(arc4random()%100), area: 0))
        }
        
        let series = TKChartColumnSeries(items:array)
        series.selectionMode = TKChartSeriesSelectionMode.Series
        
        let xAxis = TKChartCategoryAxis(categories:categories)
        xAxis.position = TKChartAxisPosition.Bottom
        xAxis.setPlotMode(TKChartAxisPlotMode.BetweenTicks)
        chart.xAxis = xAxis
        
        let yAxis = TKChartNumericAxis(minimum:0, andMaximum:100)
        yAxis.position = TKChartAxisPosition.Left
        chart.yAxis = yAxis
        
        chart.addSeries(series)        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
