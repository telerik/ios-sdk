//
//  PieChartAnnotations.swift
//  TelerikUIExamplesInSwift
//
//  Created by wfmac on 12/1/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class PieChartAnnotations: TKExamplesExampleViewController {

    let pieChart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pieChart.frame = self.view.bounds
        pieChart.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
        pieChart.allowAnimations = true
        self.view.addSubview(pieChart)
        
        var array = [TKChartDataPoint]()
        array.append(TKChartDataPoint(name:"Auto &\nTransport", value:25.0))
        array.append(TKChartDataPoint(name:"Food &\nDining", value:25.0))
        array.append(TKChartDataPoint(name:"Fees &\nCharges", value:25.0))
        array.append(TKChartDataPoint(name:"Business\nServices", value:12.5))
        array.append(TKChartDataPoint(name:"Personal\nCare", value:12.5))
        
        let series = TKChartPieSeries(items:array)
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        series.expandRadius = 1.04
        series.rotationAngle = -CGFloat(M_PI_2 + M_PI_4)
        series.radiusInset = 50
        series.labelDisplayMode = TKChartPieSeriesLabelDisplayMode.Inside
        series.style.pointLabelStyle.textHidden = false
        series.style.pointLabelStyle.stringFormat = "%.0f%%"
        series.style.pointLabelStyle.textColor = UIColor.whiteColor()
        pieChart.addSeries(series)
        
        for pt in series.items as! [TKChartData] {
            let annotation = TKChartBalloonAnnotation(text:pt.dataName!, point:pt, forSeries:series)
            annotation.style.fill = nil
            annotation.style.stroke = nil
            annotation.style.distanceFromPoint = 0
            annotation.style.textColor = UIColor.grayColor()
            pieChart.addAnnotation(annotation)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.pieChart.select(TKChartSelectionInfo(series:self.pieChart.series[0], dataPointIndex:0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
