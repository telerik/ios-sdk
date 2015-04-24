//
//  BindWithDelegate.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class BindWithDelegate : ExampleViewController {
    
    let chart = TKChart()
    let chartDataSource = ChartDataSource()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        chart.dataSource = chartDataSource
        self.view.addSubview(chart)
        
        chart.legend().hidden = false
        chart.legend().style.position = TKChartLegendPosition.Top
        chart.legend().container.stack.orientation = TKStackLayoutOrientation.Horizontal
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}