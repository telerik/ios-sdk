//
//  FinancialChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class FinancialChart: TKExamplesExampleViewController {

    let chart = TKChart()
    var dataPoints = [TKChartData]()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Candlestick", action: reloadChart)
        self.addOption("Ohlc", action: reloadChart)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        chart.gridStyle.verticalLinesHidden = false
        chart.gridStyle.horizontalLinesHidden = false
        
        let data: NSArray = StockDataPoint.stockPoints()
        for i in 0..<42 {
            dataPoints.append(data[i] as! TKChartData)
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
    
        series.selection = TKChartSeriesSelection.DataPoint
        
        let yAxis = TKChartNumericAxis(minimum: 300, andMaximum: 380)
        yAxis.majorTickInterval = 20
        yAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignment(rawValue:TKChartAxisLabelAlignment.Bottom.rawValue | TKChartAxisLabelAlignment.Right.rawValue)
        yAxis.allowZoom = true
        yAxis.allowPan = true
        series.yAxis = yAxis

        chart.addSeries(series)
    
        let xAxis = chart.xAxis as! TKChartDateTimeAxis
        xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days
        
        // >> chart-tick-style-set-swift
        xAxis.style.majorTickStyle.ticksOffset = -3
        xAxis.style.majorTickStyle.ticksHidden = false
        xAxis.style.majorTickStyle.ticksWidth = 1.5
        xAxis.style.majorTickStyle.ticksFill = TKSolidFill(color: UIColor(red: 203/255.0, green: 203/255.0, blue: 203/255.0, alpha: 1.0))
        xAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingMode.Visible
        // << chart-tick-style-set-swift
        
        chart.yAxis!.style.labelStyle.textAlignment = TKChartAxisLabelAlignment(rawValue: TKChartAxisLabelAlignment.Bottom.rawValue | TKChartAxisLabelAlignment.Right.rawValue)
        
        // >> chart-zoom-swift
        chart.xAxis!.allowZoom = true
        chart.yAxis!.allowZoom = true
        // << chart-zoom-swift
        
        // >> chart-pan-swift
        chart.xAxis!.allowPan = true
        chart.yAxis!.allowPan = true
        // << chart-pan-swift
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
