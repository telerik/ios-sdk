//
//  MyAxis.swift
//  TelerikUIExamplesInSwift
//
//  Created by Adrian Gulyashki on 9/30/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

class MyAxis: TKChartNumericAxis {
    override func renderForChart(chart: TKChart) -> TKChartAxisRender {
        return AxisRender(axis: self, chart: chart)
    }
    
}
