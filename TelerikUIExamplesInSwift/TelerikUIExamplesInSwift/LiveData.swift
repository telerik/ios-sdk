//
//  LiveData.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class LiveData: TKExamplesExampleViewController {

    let chart = TKChart()
    var dataPoints = [TKChartDataPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)

        NSTimer.scheduledTimerWithTimeInterval(0.127, target: self, selector: #selector(LiveData.updateChart), userInfo: nil, repeats: true)
    }
    
    func updateChart () -> Void {
        chart.removeAllData()
        let dataPoint = TKChartDataPoint(x: NSDate(), y: Int(arc4random() % 70))
        dataPoints.append(dataPoint)
        if dataPoints.count > 25 {
            dataPoints.removeAtIndex(0)
        }
        
        chart.yAxis = TKChartNumericAxis(minimum: 0, andMaximum: 100)
        let firstPoint = dataPoints[0]
        let lastPoint = dataPoints[dataPoints.count - 1]
        let xAxis = TKChartDateTimeAxis(minimumDate: firstPoint.dataXValue as! NSDate, andMaximumDate: lastPoint.dataXValue as! NSDate)
        xAxis.style.labelStyle.fitMode = TKChartAxisLabelFitMode.None
        xAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingMode.Visible
        xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Seconds
        chart.xAxis = xAxis
        
        chart.addSeries(TKChartLineSeries(items: dataPoints))
        chart.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
