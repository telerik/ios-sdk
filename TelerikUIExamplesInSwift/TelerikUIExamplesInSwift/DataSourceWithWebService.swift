//
//  DataSourceWithWebService.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DataSourceWithWebService: ExampleViewController {

    let dataSource = TKDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Consume web service"
        
        let chart = TKChart(frame: self.view.bounds)
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)

        let url = "http://www.telerik.com/docs/default-source/ui-for-ios/weather.json?sfvrsn=2"
        dataSource.loadDataFromURL(url, dataFormat: TKDataSourceDataFormat.JSON, rootItemKeyPath: "dayList") { (NSError err) -> Void in

            if err != nil {
                println("Can't connect with the server!")
                return
            }
            
            self.dataSource.settings.chart.createSeries { (TKDataSourceGroup group) -> TKChartSeries! in
                var series:TKChartSeries? = nil
                if group.valueKey == "clouds" {
                    series = TKChartColumnSeries()
                    series?.yAxis = TKChartNumericAxis(minimum: 0, andMaximum: 100)
                    series?.yAxis.title = "clouds"
                    series?.yAxis.style.titleStyle.rotationAngle = CGFloat(M_PI_2);
                }
                else {
                    series = TKChartLineSeries()
                    series?.yAxis = TKChartNumericAxis(minimum: -10, andMaximum: 30)
                    if group.valueKey == "temp.min" {
                        series?.yAxis.position = TKChartAxisPosition.Right
                        series?.yAxis.title = "temperature"
                        series?.yAxis.style.titleStyle.rotationAngle = CGFloat(M_PI_2);
                        chart.addAxis(series?.yAxis)
                    }
                }
                return series
            }
            
            self.dataSource.map {
                let interval = $0.valueForKey("dateTime") as NSTimeInterval
                let date = NSDate(timeIntervalSince1970: interval)
                $0.setValue(date, forKey: "dateTime")
                return $0
            }
            
            let items = self.dataSource.items
            self.dataSource.itemSource = [TKDataSourceGroup(items: items, valueKey: "clouds", displayKey: "dateTime"),
                TKDataSourceGroup(items: items, valueKey: "temp.min", displayKey: "dateTime"),
                TKDataSourceGroup(items: items, valueKey: "temp.max", displayKey: "dateTime")]
            
            chart.dataSource = self.dataSource
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd"
            let xAxis:TKChartDateTimeAxis = chart.xAxis as TKChartDateTimeAxis
            xAxis.majorTickInterval = 1
            xAxis.setPlotMode(TKChartAxisPlotMode.BetweenTicks)
            xAxis.labelFormatter = formatter
            xAxis.title = "date"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
