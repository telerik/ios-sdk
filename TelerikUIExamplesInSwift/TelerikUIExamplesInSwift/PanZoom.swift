//
//  PanZoom.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class PanZoom: ExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBounds
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        var items = NSMutableArray()
        for i in 0..<200 {
            items.addObject(TKChartDataPoint(x: Int(arc4random() % 200), y: Int(arc4random() % 1000)))
        }
        var series = TKChartScatterSeries(items: items)
        chart.addSeries(series)
        
        items = NSMutableArray()
        for i in 0..<200 {
            items.addObject(TKChartDataPoint(x: Int(arc4random() % 200), y: Int(arc4random() % 1000)))
        }
        series = TKChartScatterSeries(items: items)
        chart.addSeries(series)
        
        items = NSMutableArray()
        for i in 0..<200 {
            items.addObject(TKChartDataPoint(x: Int(arc4random() % 200), y: Int(arc4random() % 1000)))
        }
        
        series = TKChartScatterSeries(items: items)
        chart.addSeries(series)
        
        chart.xAxis.allowZoom = true
        chart.xAxis.allowPan = true
        chart.yAxis.allowZoom = true
        chart.yAxis.allowPan = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

