//
//  DateTimeAxis.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class DateTimeAxis:TKExamplesExampleViewController {
    
    let chart = TKChart()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        let calendar = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)!
        let dateTimeComponents = NSDateComponents()
        dateTimeComponents.year = 2013
        dateTimeComponents.day = 1
        
        var array = [TKChartDataPoint]()
        for i in 1..<7 {
            dateTimeComponents.month = i
            array.append(TKChartDataPoint(x:calendar.dateFromComponents(dateTimeComponents), y:Int(arc4random() % (100))))
        }
        
        let series = TKChartSplineAreaSeries(items:array)
        series.selection = TKChartSeriesSelection.Series
        
        dateTimeComponents.month = 1
        let minDate = calendar.dateFromComponents(dateTimeComponents)!
        dateTimeComponents.month = 6
        let maxDate = calendar.dateFromComponents(dateTimeComponents)!
    
        // >> chart-axis-datetime-swift
        let xAxis = TKChartDateTimeAxis(minimumDate: minDate, andMaximumDate: maxDate)
        xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Months
        xAxis.majorTickInterval = 1
        // << chart-axis-datetime-swift
        
        // >> chart-category-plot-onticks-swift
        xAxis.setPlotMode(TKChartAxisPlotMode.OnTicks)
        // << chart-category-plot-onticks-swift
        
        chart.xAxis = xAxis
        
        chart.addSeries(series)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}