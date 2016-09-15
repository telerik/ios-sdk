//
//  ChartDocsScatter.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsScatter: UIViewController {
    
    var chart = TKChart()
    var scatterPoints = [TKChartDataPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xValues = [460, 510, 600, 640, 700, 760, 800, 890, 920, 1000, 1060, 1120, 1200, 1342, 1440]
        let yValues = [7, 9 ,12, 17, 19, 25, 32, 42, 50, 16, 56, 77, 24, 80, 90]
        for i in 0 ..< xValues.count {
            scatterPoints.append(TKChartDataPoint(x: xValues[i], y: yValues[i]))
        }
    }
    
    func selection() {
        // >> chart-scatter-selection-swift
        let series = TKChartScatterSeries(items: scatterPoints)
        series.selection = TKChartSeriesSelection.DataPoint
        series.marginForHitDetection = 30.0
        chart.addSeries(series)
        // << chart-scatter-selection-swift
    }
    
    func visualAppearance() {
        // >> chart-scatter-visual-swift
        let series = TKChartScatterSeries(items: scatterPoints)
        let paletteItem = TKChartPaletteItem()
        paletteItem.fill = TKSolidFill(color: UIColor.redColor())
        series.style.palette = TKChartPalette()
        series.style.palette!.addPaletteItem(paletteItem)
        chart.addSeries(series)
        // << chart-scatter-visual-swift
    }
    
    func scatterSeries() {
        let series = TKChartScatterSeries(items: scatterPoints)
        chart.addSeries(series)
    }
}
