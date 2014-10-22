//
//  LiveData.swift
//  TelerikUIExamplesInSwift
//
//  Created by Adrian Gulyashki on 10/3/14.
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class LiveData: ExampleViewController {

    var chart: TKChart?
    var dataPoints = [TKChartDataPoint]()
    var lineSeries: TKChartLineSeries?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart = TKChart(frame: self.exampleBounds)
        chart?.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart!)
        NSTimer.scheduledTimerWithTimeInterval(0.127, target: self, selector: "updateChart", userInfo: nil, repeats: true)
    }
    
    func updateChart () -> Void {
        chart?.removeAllData()
        let dataPoint = TKChartDataPoint(x: NSDate(), y: Int(arc4random() % 70))
        dataPoints.append(dataPoint)
        if dataPoints.count > 25 {
            dataPoints.removeAtIndex(0)
        }
        
        chart?.yAxis = TKChartNumericAxis(minimum: 0, andMaximum: 100)
        let firstPoint = dataPoints[0]
        let lastPoint = dataPoints[dataPoints.count - 1]
        let xAxis = TKChartDateTimeAxis(minimumDate: firstPoint.dataXValue as NSDate, andMaximumDate: lastPoint.dataXValue as NSDate)
        xAxis.style.labelStyle.fitMode = TKChartAxisLabelFitMode.None
        xAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingMode.Visible
        xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Seconds
        chart?.xAxis = xAxis
        
        lineSeries = TKChartLineSeries(items: dataPoints)
        chart?.addSeries(lineSeries)
        chart?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
