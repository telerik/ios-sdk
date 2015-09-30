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
        
        let bounds = self.exampleBoundsWithInset
        
        pieChart.frame = CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height / 2), 10, 10)
        pieChart.autoresizingMask = UIViewAutoresizing(rawValue:~UIViewAutoresizing.None.rawValue)
        pieChart.allowAnimations = true
        pieChart.legend.hidden = false
        pieChart.legend.style.position = TKChartLegendPosition.Right
        self.view.addSubview(pieChart)
        
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
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        series.selectionAngle = -M_PI_2
        series.expandRadius = 1.2
        pieChart.addSeries(series)
        
        series.style.pointLabelStyle.textHidden = false
        
        let donutSeries = TKChartDonutSeries(items:array)
        donutSeries.selectionMode = TKChartSeriesSelectionMode.DataPoint
        donutSeries.innerRadius = 0.6
        donutSeries.expandRadius = 1.1
        donutChart.addSeries(donutSeries)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        pieChart.select(TKChartSelectionInfo(series:pieChart.series[0], dataPointIndex: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
