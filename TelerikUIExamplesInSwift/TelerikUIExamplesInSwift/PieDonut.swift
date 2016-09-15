//
//  PieDonut.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class PieDonut:TKExamplesExampleViewController {
    
    let chart = TKChart()
    let donutChart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = self.view.bounds
        
        chart.frame = CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height / 2), 10, 10)
        chart.autoresizingMask = UIViewAutoresizing(rawValue:~UIViewAutoresizing.None.rawValue)
        chart.allowAnimations = true
        
        // >> chart-legend-swift
        chart.legend.hidden = false
        // << chart-legend-swift
        
        // >> chart-legend-position-swift
        chart.legend.style.position = TKChartLegendPosition.Right
        // << chart-legend-position-swift
        
        self.view.addSubview(chart)
        
        donutChart.frame = CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.height / 2, bounds.size.width, bounds.size.height / 2), 10, 10)
        donutChart.autoresizingMask = UIViewAutoresizing(rawValue:~UIViewAutoresizing.None.rawValue)
        donutChart.allowAnimations = true
        donutChart.legend.hidden = false
        donutChart.legend.style.position = TKChartLegendPosition.Right
        self.view.addSubview(donutChart)
        
        let array:[TKChartDataPoint] = [
            TKChartDataPoint(name: "Google", value: 20),
            TKChartDataPoint(name: "Apple", value: 30),
            TKChartDataPoint(name:"Microsoft", value: 10),
            TKChartDataPoint(name: "IBM", value: 5),
            TKChartDataPoint(name: "Oracle", value: 8) ]
        
        let series = TKChartPieSeries(items:array)
        series.selection = TKChartSeriesSelection.DataPoint
        series.selectionAngle = -M_PI_2
        series.expandRadius = 1.2
        chart.addSeries(series)
        
        let donutSeries = TKChartDonutSeries(items:array)
        donutSeries.selection = TKChartSeriesSelection.DataPoint
        donutSeries.innerRadius = 0.6
        donutSeries.expandRadius = 1.1
        donutChart.addSeries(donutSeries)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        chart.select(TKChartSelectionInfo(series:chart.series[0], dataPointIndex: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
