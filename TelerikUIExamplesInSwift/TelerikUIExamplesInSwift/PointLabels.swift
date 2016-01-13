//
//  PointLabels.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class PointLabels: TKExamplesExampleViewController, TKChartDelegate {

    let chart = TKChart()
    var columnData = [TKChartDataPoint]()
    var barData = [TKChartDataPoint]()
    var lineData = [TKChartDataPoint]()
    var pieData = [TKChartDataPoint]()
    var ohlcData = [TKChartFinancialDataPoint]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Bar Series", action: barSeries)
        self.addOption("Column Series", action: columnSeries)
        self.addOption("Line Series", action: lineSeries)
        self.addOption("Pie Series", action: pieSeries)
        self.addOption("Ohlc Series", action: ohlcSeries)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleHeight.rawValue | UIViewAutoresizing.FlexibleWidth.rawValue)
        chart.delegate = self
        chart.allowAnimations = true
        self.view.addSubview(chart)
        
        let categories = ["Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green"]
        for i in 0..<categories.count {
            let columnPoint = TKChartDataPoint(x: categories[i], y: Int(arc4random() % 100))
            let barPoint = TKChartDataPoint(x: Int(arc4random() % 100), y: categories[i])
            columnData.append(columnPoint)
            barData.append(barPoint)
        }
        
        let lineValues = [82, 68, 83, 46, 32, 75, 8, 54, 47, 51]
        for i in 0..<lineValues.count {
            let point = TKChartDataPoint(x: i, y: lineValues[i])
            lineData.append(point)
        }
        
        pieData.append(TKChartDataPoint(name: "Google", value: 20))
        pieData.append(TKChartDataPoint(name: "Apple", value: 30))
        pieData.append(TKChartDataPoint(name: "Microsoft", value: 10))
        pieData.append(TKChartDataPoint(name: "IBM", value: 5))
        pieData.append(TKChartDataPoint(name: "Oracle", value: 8))
        
        let openPrices = [100, 125, 69, 99, 140, 125]
        let closePrices = [85, 65, 135, 120, 80, 136]
        let lowPrices = [50, 60, 65, 55, 75, 90]
        let highPrices = [129, 142, 141, 123, 150, 161]
        let dateNow = NSDate()
        for i in 0..<openPrices.count {
            let date = dateNow.dateByAddingTimeInterval((Double)(60 * 60 * 24 * i))
            let dataPoint = TKChartFinancialDataPoint(x: date, open: openPrices[i], high: highPrices[i], low: lowPrices[i], close: closePrices[i])
            ohlcData.append(dataPoint)
        }
        
        self.barSeries()
    }
    
    func barSeries() {
        chart.removeAllData()
        let barSeries = TKChartBarSeries(items: barData)
        barSeries.style.pointLabelStyle.textHidden = false
        barSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(15, 0)
        
        chart.addSeries(barSeries)
        chart.reloadData()
    }
    
    func columnSeries() {
        chart.removeAllData()
        
        let columnSeries = TKChartColumnSeries(items: columnData)
        columnSeries.style.pointLabelStyle.textHidden = false
        columnSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -15)
        columnSeries.style.pointLabelStyle.font = UIFont.systemFontOfSize(9)
        
        chart.addSeries(columnSeries)
        chart.reloadData()
    }
    
    func lineSeries() {
        chart.removeAllData()
        
        let lineSeries = TKChartLineSeries(items: lineData)
        lineSeries.style.pointLabelStyle.textHidden = false
        lineSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, 15)
        lineSeries.style.pointLabelStyle.font = UIFont.systemFontOfSize(9)
        
        chart.addSeries(lineSeries)
        chart.reloadData()
    }
    
    func pieSeries() {
        chart.removeAllData()
        
        let pieSeries = TKChartPieSeries(items: pieData)
        pieSeries.style.pointLabelStyle.textHidden = false
        pieSeries.style.pointLabelStyle.textColor = UIColor.whiteColor()
        pieSeries.labelDisplayMode = TKChartPieSeriesLabelDisplayMode.Inside
        
        chart.addSeries(pieSeries)
        chart.reloadData()
    }
    
    func ohlcSeries() {
        chart.removeAllData()
        
        let ohlcSeries = TKChartOhlcSeries(items: ohlcData)
        ohlcSeries.style.pointLabelStyle.textHidden = false
        ohlcSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -40)
        ohlcSeries.style.pointLabelStyle.textAlignment = NSTextAlignment.Justified
        
        chart.addSeries(ohlcSeries)
        let xAxis = chart.xAxis as! TKChartDateTimeAxis
        xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days
        xAxis.majorTickInterval = 1
        xAxis.setPlotMode(TKChartAxisPlotMode.BetweenTicks)
    }
    
    func chart(chart: TKChart, textForLabelAtPoint dataPoint: TKChartData, property propertyName: String?, inSeries series: TKChartSeries, atIndex dataIndex: UInt) -> String? {
        if series.isKindOfClass(TKChartPieSeries) {
            return dataPoint.dataName!
        }
        else if series.isKindOfClass(TKChartBarSeries) {
            return "\(dataPoint.dataXValue)"
        }
        else if series.isKindOfClass(TKChartOhlcSeries) {
            return "O:\(dataPoint.open!)\nH:\(dataPoint.high!)\nL:\(dataPoint.low!)\nC:\(dataPoint.close!)"
        }
        
        return "\(dataPoint.dataYValue)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
