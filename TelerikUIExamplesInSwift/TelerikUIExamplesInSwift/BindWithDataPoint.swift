//
//  BindWithDataPoint.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class BindWithDataPoint : ExampleViewController {
    
    let chart = TKChart()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        let data = NSMutableArray()
        for i in 0..<6 {
            data.addObject(DataPointImpl(ID: i, withValue: CGFloat(Int(arc4random() % 100))))
        }
        
        let columnSeries = TKChartColumnSeries(items: data)
        columnSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(columnSeries)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
