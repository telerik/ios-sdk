//
//  ChartDocsIndicators.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsIndicators: UIViewController {
    let financialChart = TKChart()
    var financialDataPoints = [TKChartFinancialDataPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        financialChart.frame = self.view.bounds
        self.view.addSubview(financialChart)
        
        let openPrices = [100, 125, 69, 99, 140, 125, 100, 125, 69, 99, 140, 125, 100, 125, 69, 99, 140, 125, 100, 125, 69, 99, 140, 125, 100, 125, 69, 99, 140, 125, 100, 125, 69, 99, 140, 125]
        let closePrices = [85, 65, 135, 120, 80, 136, 85, 65, 135, 120, 80, 136, 85, 65, 135, 120, 80, 136, 85, 65, 135, 120, 80, 136, 85, 65, 135, 120, 80, 136, 85, 65, 135, 120, 80, 136]
        let lowPrices = [50, 60, 65, 55, 75, 90, 50, 60, 65, 55, 75, 90, 50, 60, 65, 55, 75, 90, 50, 60, 65, 55, 75, 90, 50, 60, 65, 55, 75, 90, 50, 60, 65, 55, 75, 90]
        let highPrices = [129, 142, 141, 123, 150, 161, 129, 142, 141, 123, 150, 161, 129, 142, 141, 123, 150, 161, 129, 142, 141, 123, 150, 161, 129, 142, 141, 123, 150, 161, 129, 142, 141, 123, 150, 161]
        let dateNow = NSDate()
        
        for i in 0..<openPrices.count {
            let date = dateNow.dateByAddingTimeInterval(CDouble(60 * 60 * 24 * i))
            financialDataPoints.append(TKChartFinancialDataPoint(x: date, open: openPrices[i], high: highPrices[i], low: lowPrices[i], close: closePrices[i]))
        }
    }
    
    func bollingerBands() {
        // >> chart-indicators-bollinger-swift
        let candlesticks = TKChartCandlestickSeries(items: financialDataPoints)
        let bollingerBands = TKChartBollingerBandIndicator(series: candlesticks)
        financialChart.addSeries(candlesticks)
        financialChart.addSeries(bollingerBands)
        // << chart-indicators-bollinger-swift
    }
    
    func macdIndicator() {
        // >> chart-indicators-technical-swift
        let candlesticks = TKChartCandlestickSeries(items: financialDataPoints)
        let macdIndicator = TKChartMACDIndicator(series: candlesticks)
        macdIndicator.longPeriod = 26
        macdIndicator.shortPeriod = 12
        macdIndicator.signalPeriod = 9
        financialChart.addSeries(macdIndicator)
        // << chart-indicators-technical-swift
    }
}
