//
//  ViewController.swift
//  TelerikChartInSwift
//
//  Copyright (c) 2014-2015 Telerik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var chart = TKChart(frame: CGRectInset(self.view.bounds, 30, 30))
        self.view.addSubview(chart)
        
        var items: [TKChartDataPoint] = []
        for x in 0..<10 {
            var y = 100.0 * sin(M_PI * CDouble(x) + 100.0)
            items.append(TKChartDataPoint(x:CDouble(x + x*3), y:y))
        }
        
        var series = TKChartSplineSeries(items: items)
        series.yAxis = TKChartNumericAxis(minimum: -100, andMaximum: 100)
        
        var xAxis = TKChartNumericAxis(minimum: 0, andMaximum: 20)
        xAxis.majorTickInterval = 5
        series.xAxis = xAxis
        chart.addSeries(series)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

