//
//  ChartDocsRangeColumn.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//


class ChartDocsRangeColumn: UIViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // >> chart-range-col-cluster-swift
        let lowValues = [33, 29, 55, 21, 10, 39, 40, 11]
        let highValues = [47, 61, 64, 40, 33, 90, 87, 69]
        let lowValues2 = [31, 32, 57, 18, 12, 31, 45, 14]
        let highValues2 = [43, 66, 61, 49, 31, 80, 82, 78]
        
        var items = [TKChartRangeDataPoint]()
        var items2 = [TKChartRangeDataPoint]()
        for i in 0..<8 {
            items.append(TKChartRangeDataPoint(x: i, low: lowValues[i], high: highValues[i]))
            items2.append(TKChartRangeDataPoint(x: i, low: lowValues2[i], high: highValues2[i]))
        }
        
        let series = TKChartRangeColumnSeries(items:items)
        let series2 = TKChartRangeColumnSeries(items:items2)
        
        chart.addSeries(series)
        chart.addSeries(series2)
        // << chart-range-col-cluster-swift
        
        // >> chart-range-col-visual-swift
        series.style.palette = TKChartPalette()
        let paletteItem = TKChartPaletteItem()
        paletteItem.fill = TKSolidFill(color: UIColor.redColor())
        paletteItem.stroke = TKStroke(color: UIColor.blackColor())
        series.style.palette!.addPaletteItem(paletteItem)
        // << chart-range-col-visual-swift
        
        // >> chart-range-col-gap-swift
        series.gapLength = 0.5
        // << chart-range-col-gap-swift
        
        // >> chart-range-col-width-swift
        series.minColumnWidth = 20
        series.maxColumnWidth = 50
        // << chart-range-col-width-swift
    }
    
}
