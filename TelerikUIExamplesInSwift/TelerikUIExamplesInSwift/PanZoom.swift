//
//  PanZoom.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class PanZoom: TKExamplesExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        chart.allowPanDeceleration = true
        self.view.addSubview(chart)
        
        var items = [TKChartDataPoint]()
        for _ in 0..<200 {
            items.append(TKChartDataPoint(x: Int(arc4random() % 200), y: Int(arc4random() % 1000)))
        }
        var series = TKChartScatterSeries(items: items)
        chart.addSeries(series)
        
        items = [TKChartDataPoint]()
        for _ in 0..<200 {
            items.append(TKChartDataPoint(x: Int(arc4random() % 200), y: Int(arc4random() % 1000)))
        }
        series = TKChartScatterSeries(items: items)
        chart.addSeries(series)
        
        items = [TKChartDataPoint]()
        for _ in 0..<200 {
            items.append(TKChartDataPoint(x: Int(arc4random() % 200), y: Int(arc4random() % 1000)))
        }
        
        series = TKChartScatterSeries(items: items)
        chart.addSeries(series)
        
        chart.xAxis!.allowZoom = true
        chart.xAxis!.allowPan = true
        chart.yAxis!.allowZoom = true
        chart.yAxis!.allowPan = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

