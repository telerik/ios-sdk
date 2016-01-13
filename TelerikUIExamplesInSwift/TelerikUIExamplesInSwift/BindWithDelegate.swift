//
//  BindWithDelegate.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class BindWithDelegate : TKExamplesExampleViewController {
    
    let chart = TKChart()
    let chartDataSource = ChartDataSource()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        chart.dataSource = chartDataSource
        self.view.addSubview(chart)
        
        chart.legend.hidden = false
        chart.legend.style.position = TKChartLegendPosition.Top
        chart.legend.container.stack.orientation = TKCoreStackLayoutOrientation.Horizontal
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}