//
//  MyAxis.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

class MyAxis: TKChartNumericAxis {
    override func renderForChart(chart: TKChart) -> TKChartAxisRender {
        return AxisRender(axis: self, chart: chart)
    }
}
