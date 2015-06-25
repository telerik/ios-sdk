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
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        var data = [DataPointImpl]()
        for i in 0..<6 {
            data.append(DataPointImpl(ID: i, withValue: CGFloat(Int(arc4random() % 100))))
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
