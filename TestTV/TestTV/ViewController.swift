//
//  ViewController.swift
//  TestTV2
//
//  Created by Tsvetan Raikov on 9/10/15.
//  Copyright © 2015 TR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let calendar = TKCalendar(frame: CGRectMake(1000, 100, 800, 800))
        self.view.addSubview(calendar)
        
        let chart = TKChart(frame: CGRectMake(100, 100, 800, 800))
        chart.legend().hidden = false
        
        var items = [TKChartDataPoint]()
        items.append(TKChartDataPoint(name: "Apple", value: 17.9))
        items.append(TKChartDataPoint(name: "Samsung", value: 24.4))
        items.append(TKChartDataPoint(name: "Lenovo", value: 6.5))
        items.append(TKChartDataPoint(name: "Huawei", value: 5.1))
        items.append(TKChartDataPoint(name: "LG", value: 4.5))
        items.append(TKChartDataPoint(name: "Xiaomi", value: 4.5))
        items.append(TKChartDataPoint(name: "Others", value: 37.2))
        
        let series = TKChartPieSeries(items: items)
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        series.selectionAngle = -M_PI_2
        series.expandRadius = 1.2
        series.style.pointLabelStyle.textHidden = false
        chart.addSeries(series)
        
        self.view.addSubview(chart)
        
        chart.select(TKChartSelectionInfo(series: series, dataPointIndex: 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

