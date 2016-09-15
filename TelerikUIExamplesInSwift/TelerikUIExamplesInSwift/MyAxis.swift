//
//  MyAxis.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

// >> chart-custom-axis-render-swift
class MyAxis: TKChartNumericAxis {
    override func renderForChart(chart: TKChart) -> TKChartAxisRender {
        return AxisRender(axis: self, chart: chart)
    }
}
// << chart-custom-axis-render-swift
