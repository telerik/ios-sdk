//
//  FinancialChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class FinancialChart: ExampleViewController {

    let chart = TKChart()
    var dataPoints = [TKChartDataPoint]()

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Candlestick") { self.reloadChart() }
        self.addOption("Ohlc") { self.reloadChart() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        chart.gridStyle().verticalLinesHidden = false
        chart.gridStyle().horizontalLinesHidden = false
        
        let data: NSArray = StockDataPoint.stockPoints()
        for i in 0..<42 {
            dataPoints.append(data[i] as! TKChartDataPoint)
        }
    
        self.reloadChart()
    }
    
    func reloadChart() {
        chart.removeAllData()
    
        var series:TKChartSeries
    
        switch self.selectedOption {
            case 0:
                series = TKChartCandlestickSeries(items: dataPoints)
            default:
                series = TKChartOhlcSeries(items: dataPoints)
                break
        }
    
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        let yAxis = TKChartNumericAxis(minimum: 300, andMaximum: 380)
        yAxis.majorTickInterval = 20
        chart.yAxis = yAxis
        chart.addSeries(series)
    
        let xAxis = chart.xAxis as! TKChartDateTimeAxis
        xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days
        xAxis.style.majorTickStyle.ticksOffset = -3
        xAxis.style.majorTickStyle.ticksHidden = false
        xAxis.style.majorTickStyle.ticksWidth = 1.5
        xAxis.style.majorTickStyle.ticksFill = TKSolidFill(color: UIColor(red: 203/255.0, green: 203/255.0, blue: 203/255.0, alpha: 1.0))
        xAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingMode.Visible
    
        chart.yAxis.style!.labelStyle!.textAlignment = TKChartAxisLabelAlignment.Bottom | TKChartAxisLabelAlignment.Right
        chart.xAxis.allowZoom = true
        chart.xAxis.allowPan = true
        chart.yAxis.allowZoom = true
        chart.yAxis.allowPan = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
