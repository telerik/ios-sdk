//
//  ChartDocsOhlc.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsOhlc: UIViewController, TKChartDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let chart = TKChart(frame: CGRectInset(self.view.bounds, 10, 10))
        chart.delegate = self
        
        self.view.addSubview(chart)
        // >> chart-ohlc-swift
        let openPrices = [100, 125, 69, 99, 140, 125]
        let closePrices = [85, 65, 135, 120, 80, 136]
        let lowPrices = [50, 60, 65, 55, 75, 90]
        let highPrices = [129, 142, 141, 123, 150, 161]
        let dateNow = NSDate()
        var financialDataPoints = [TKChartFinancialDataPoint]()
        
        for i in 0 ..< openPrices.count {
            let date = dateNow.dateByAddingTimeInterval(CDouble(60 * 60 * 24 * i))
            financialDataPoints.append(TKChartFinancialDataPoint(x: date, open: openPrices[i], high: highPrices[i], low: lowPrices[i], close: closePrices[i]))
        }
        
        let ohlcSeries = TKChartOhlcSeries(items: financialDataPoints)
        chart.addSeries(ohlcSeries)
        
        let xAxis = chart.xAxis as! TKChartDateTimeAxis
        xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days
        xAxis.setPlotMode(TKChartAxisPlotMode.BetweenTicks)
        xAxis.majorTickInterval = 1
        // << chart-ohlc-swift
    }
    
    // >> chart-ohlc-visual-swift
    func chart(chart: TKChart, paletteItemForSeries series: TKChartSeries, atIndex index: Int) -> TKChartPaletteItem? {
        let dataPoint = series.dataPointAtIndex(UInt(index))
        
        var stroke: TKStroke
        if dataPoint?.close!.doubleValue < dataPoint?.open!.doubleValue  {
            stroke = TKStroke(color: UIColor.redColor())
        } else {
            stroke = TKStroke(color: UIColor.greenColor())
        }
        
        let paletteItem = TKChartPaletteItem(stroke: stroke)
        return paletteItem
    }
    // << chart-ohlc-visual-swift
    
}
