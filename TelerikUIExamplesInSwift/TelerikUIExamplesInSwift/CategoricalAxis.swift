//
//  CategoricalAxis.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CategoricalAxis:TKExamplesExampleViewController {

    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        // >> chart-category-axis-swift
        var array = [TKChartBubbleDataPoint]()
        let categories = ["Apple", "Google", "Microsoft", "Samsung"]
        
        for item in 0..<categories.count {
            array.append(TKChartBubbleDataPoint(x: categories[item], y: Int(arc4random()%100), area: 0))
        }
        
        let series = TKChartColumnSeries(items:array)
        series.selection = TKChartSeriesSelection.Series
        
        // >> chart-add-axis-swift
        let xAxis = TKChartCategoryAxis(categories:categories)
        xAxis.position = TKChartAxisPosition.Bottom
        xAxis.setPlotMode(TKChartAxisPlotMode.BetweenTicks)
        xAxis.range = TKRange(minimumIndex: 0, andMaximumIndex: 3)
        chart.xAxis = xAxis
        // << chart-add-axis-swift
        // << chart-category-axis-swift
        
        let yAxis = TKChartNumericAxis(minimum:0, andMaximum:100)
        yAxis.position = TKChartAxisPosition.Left
        chart.yAxis = yAxis
        
        chart.addSeries(series)
        
        // >> chart-title-swift
        chart.xAxis!.title = "Vendors"
        chart.xAxis!.style.titleStyle.textColor = UIColor.grayColor()
        chart.xAxis!.style.titleStyle.font = UIFont.boldSystemFontOfSize(11)
        chart.xAxis!.style.titleStyle.alignment = TKChartAxisTitleAlignment.RightOrBottom
        chart.reloadData()
        // << chart-title-swift
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
