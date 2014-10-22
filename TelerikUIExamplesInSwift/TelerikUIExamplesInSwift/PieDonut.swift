//
//  PieDonut.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class PieDonut:ExampleViewController {
    
    let pieChart = TKChart()
    let donutChart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = CGRectInset(self.view.bounds, 10, 10)
        
        pieChart.frame = CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height / 2), 10, 10)
        pieChart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        pieChart.allowAnimations = true
        pieChart.legend().hidden = false
        pieChart.legend().style.position = TKChartLegendPosition.Right
        self.view.addSubview(pieChart)
        
        donutChart.frame = CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.height / 2, bounds.size.width, bounds.size.height / 2), 10, 10)
        donutChart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        donutChart.allowAnimations = true
        donutChart.legend().hidden = false
        donutChart.legend().style.position = TKChartLegendPosition.Right
        self.view.addSubview(donutChart)
        
        let array:NSMutableArray = [
            TKChartDataPoint(value: 20, name: "Google"),
            TKChartDataPoint(value: 30, name: "Apple"),
            TKChartDataPoint(value: 10, name:"Microsoft"),
            TKChartDataPoint(value: 5, name: "IBM"),
            TKChartDataPoint(value: 8, name: "Oracle") ]
        
        let series = TKChartPieSeries(items:array)
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        series.selectionAngle = -M_PI_2
        series.expandRadius = 1.2
        pieChart.addSeries(series)
        
        let donutSeries = TKChartDonutSeries(items:array)
        donutSeries.selectionMode = TKChartSeriesSelectionMode.DataPoint
        donutSeries.innerRadius = 0.6
        donutSeries.expandRadius = 1.1
        donutChart.addSeries(donutSeries)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        pieChart.select(TKChartSelectionInfo(series:pieChart.series()[0] as TKChartSeries, dataPointIndex: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
