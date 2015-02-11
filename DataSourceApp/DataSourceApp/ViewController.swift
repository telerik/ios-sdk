//
//  ViewController.swift
//  DataSourceApp
//
//  Copyright (c) 2014-2015 Telerik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataSource:TKDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dataSource = TKDataSource(array: [ 10, 5, 12, 13, 7, 44 ], displayKey: nil)
        
        //filter all values less or equal to 5
        dataSource.filter { $0 as Int > 5 }
        
        //sort ascending
        dataSource.sort {
            let a = $0 as Int
            let b = $1 as Int
            if a < b { return NSComparisonResult.OrderedDescending }
            else if a > b { return NSComparisonResult.OrderedAscending }
            return NSComparisonResult.OrderedSame
        }
        
        //group all odd values
        dataSource.group { ($0 as Int) % 2 == 0 }
        
        //visualize everything
        dataSource.enumerate { println($0) }
        
        //Here is how to set the dataSource to UITableView
        //let tableView = UITableView(frame: self.view.bounds)
        //self.view.addSubview(tableView)
        //tableView.dataSource = dataSource

        self.dataSource = dataSource
        
        let url = "http://www.telerik.com/docs/default-source/ui-for-ios/weather.json?sfvrsn=2"
        dataSource.loadDataFromURL(url, dataFormat: TKDataSourceDataFormat.JSON, rootItemKeyPath: "dayList") { (NSError err) -> Void in
            
            if (err != nil)
            {
                println("Can't connect to the server!")
                return
            }
            
            dataSource.settings.chart.createSeries { (TKDataSourceGroup group) -> TKChartSeries! in
                var series:TKChartSeries? = nil
                if group.valueKey == "clouds" {
                    series = TKChartColumnSeries()
                    series?.yAxis = TKChartNumericAxis(minimum: 0, andMaximum: 120)
                }
                else {
                    series = TKChartLineSeries()
                    series?.yAxis = TKChartNumericAxis(minimum: -5, andMaximum: 15)
                }
                return series
            }
            
            dataSource.map {
                let interval = $0.valueForKey("dateTime") as NSTimeInterval
                let date = NSDate(timeIntervalSince1970: interval)
                $0.setValue(date, forKey: "dateTime")
                return $0
            }
            
            dataSource.valueKey = "humidity"
            
            let items = dataSource.items
            dataSource.itemSource = [TKDataSourceGroup(items: items, valueKey: "clouds", displayKey: "dateTime"),
                TKDataSourceGroup(items: items, valueKey: "temp.min", displayKey: "dateTime"),
                TKDataSourceGroup(items: items, valueKey: "temp.max", displayKey: "dateTime")]

            let chart = TKChart(frame: CGRectInset(self.view.bounds, 0, 20))
            self.view.addSubview(chart)
            chart.dataSource = dataSource
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMM/dd"
            let xAxis:TKChartDateTimeAxis = chart.xAxis as TKChartDateTimeAxis
            xAxis.majorTickInterval = 1
            xAxis.setPlotMode(TKChartAxisPlotMode.BetweenTicks)
            xAxis.labelFormatter = formatter
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

