//
//  ChartDataSource.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class ChartDataSource : NSObject, TKChartDataSource {
    
    func numberOfSeriesForChart(chart: TKChart!) -> UInt  {
        return 3
    }
    
    func seriesForChart(chart: TKChart!, atIndex index: UInt) -> TKChartSeries! {
        let series = index == 2 ? TKChartSplineSeries() : TKChartLineSeries()
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        series.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(10, 10))
        series.selectionMode = TKChartSeriesSelectionMode.Series
        series.title = "Series \(index + 1)"
        return series
    }
    
    func chart(chart: TKChart!, numberOfDataPointsForSeriesAtIndex seriesIndex: UInt) -> UInt {
        return 10
    }
    
    func chart(chart: TKChart!, dataPointAtIndex dataIndex: UInt, forSeriesAtIndex seriesIndex: UInt) -> TKChartData! {
        let point = TKChartDataPoint()
        point.dataXValue = Int(dataIndex)
        point.dataYValue = Int(arc4random() % 100)
        return point
    }
}