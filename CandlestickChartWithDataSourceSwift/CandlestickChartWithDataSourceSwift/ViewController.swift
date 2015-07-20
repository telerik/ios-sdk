//
//  ViewController.swift
//  CandlestickChartWithDataSourceSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        let chart = TKChart(frame: CGRectInset(self.view.bounds, 20, 20))
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        let dataSource = TKDataSource()
        let url = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20%20%20yahoo.finance.historicaldata%20%20%20%20%20%20%20%20%20where%20%20symbol%20%20%20%20=%20%22PRGS%22%20%20%20%20%20%20%20%20%20and%20%20%20%20startDate%20=%20%222015-03-10%22%20%20%20%20%20%20%20%20%20and%20%20%20%20endDate%20%20%20=%20%222015-03-20%22&format=json&diagnostics=true&env=store://datatables.org/alltableswithkeys&callback="
        
        dataSource.loadDataFromURL(url, dataFormat: TKDataSourceDataFormat.JSON, rootItemKeyPath: "query.results.quote") { (error:NSError!) -> Void in
            if(error != nil){
                NSLog("Can't connect with the server")
            }
            
            dataSource.map { (item:AnyObject!) -> AnyObject! in
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date: NSDate = dateFormatter.dateFromString(item.valueForKey("Date") as! String)!
                item.setValue(date, forKey: "Date")
                return item
            }
            
            dataSource.settings.chart.createSeries { (group: AnyObject!) -> TKChartSeries! in
                let series = TKChartCandlestickSeries()
                return series
            }
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            
            dataSource.settings.chart.createPoint { ( seriesIndex:Int,  dataIndex:Int,  item:AnyObject!) -> TKChartData! in
                var point = TKChartFinancialDataPoint(x: item.valueForKey("Date"), open: formatter.numberFromString(item.valueForKey("Open")as! String), high: formatter.numberFromString(item.valueForKey("High")as! String), low: formatter.numberFromString(item.valueForKey("Low")as! String), close: formatter.numberFromString(item.valueForKey("Close")as! String), volume: formatter.numberFromString(item.valueForKey("Volume") as! String))
                return point
            }
            
            chart.dataSource = dataSource
            let xAxis = TKChartDateTimeAxis()
            xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days
            xAxis.setPlotMode(TKChartAxisPlotMode.BetweenTicks)
            xAxis.majorTickInterval = 2
            chart.xAxis = xAxis;
            
            let yAxis = chart.yAxis as! TKChartNumericAxis
            yAxis.range.minimum = 25
            yAxis.majorTickInterval = 1
            
        }
    }
}

