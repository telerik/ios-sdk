//
//  DateTimeAxis.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class DateTimeAxis:ExampleViewController {
    
    let chart = TKChart()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        let calendar = NSCalendar(calendarIdentifier:NSGregorianCalendar)!
        let dateTimeComponents = NSDateComponents()
        dateTimeComponents.year = 2013
        dateTimeComponents.day = 1
        
        let array = NSMutableArray()
        for i in 1..<7 {
            dateTimeComponents.month = i
            array.addObject(TKChartDataPoint(x:calendar.dateFromComponents(dateTimeComponents), y:Int(arc4random() % (100))))
        }
        
        let series = TKChartSplineAreaSeries(items:array)
        series.selectionMode = TKChartSeriesSelectionMode.Series
        
        dateTimeComponents.month = 1
        let minDate = calendar.dateFromComponents(dateTimeComponents)
        dateTimeComponents.month = 6
        let maxDate = calendar.dateFromComponents(dateTimeComponents)
        
        let xAxis = TKChartDateTimeAxis(minimumDate: minDate, andMaximumDate: maxDate)
        xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Months
        xAxis.majorTickInterval = 1
        chart.xAxis = xAxis
        
        chart.addSeries(series)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}