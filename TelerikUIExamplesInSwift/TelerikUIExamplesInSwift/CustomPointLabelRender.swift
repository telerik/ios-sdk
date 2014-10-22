//
//  CustomPointLabelRender.swift
//  TelerikUIExamplesInSwift
//
//  Created by Adrian Gulyashki on 10/6/14.
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class CustomPointLabelRender: ExampleViewController, TKChartDelegate {

    let chart = TKChart()
    var selectedSeriesIndex = 0
    var selectedDataPointIndex = 3
    var labelRender: MyPointLabelRender?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBounds
        chart.delegate = self
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        var dataPoints = [TKChartDataPoint]()
        for i in 0..<10 {
            let point = TKChartDataPoint(x: i, y: Int(arc4random() % 80))
            dataPoints.append(point)
        }
        
        let columnSeries = TKChartColumnSeries(items: dataPoints)
        columnSeries.selectionMode = TKChartSeriesSelectionMode.DataPoint
        columnSeries.style.pointLabelStyle.textHidden = false
        columnSeries.style.pointLabelStyle.layoutMode = TKChartPointLabelLayoutMode.Manual
        columnSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -10)
        columnSeries.style.pointLabelStyle.insets = UIEdgeInsetsMake(-1, -5, -1, -5)
        columnSeries.style.pointLabelStyle.font = UIFont.systemFontOfSize(10)
        columnSeries.style.pointLabelStyle.textAlignment = NSTextAlignment.Center
        columnSeries.style.pointLabelStyle.clipMode = TKChartPointLabelClipMode.Hidden
        columnSeries.style.pointLabelStyle.textColor = UIColor.whiteColor()
        columnSeries.style.pointLabelStyle.fill = TKSolidFill(color: UIColor(red: 108/255.0, green: 181/255.0, blue: 250/255.0, alpha: 1.0))
        
        chart.addSeries(columnSeries)
        chart.select(TKChartSelectionInfo(series: chart.series()[selectedSeriesIndex] as TKChartSeries, dataPointIndex: selectedDataPointIndex))
    }
    
    func chart(chart: TKChart!, pointLabelRenderForSeries series: TKChartSeries!, withRender render: TKChartSeriesRender!) -> TKChartPointLabelRender! {
        if labelRender == nil {
            labelRender = MyPointLabelRender(render: render, selectedDataIndex: UInt(selectedDataPointIndex), selectedSeriesIndex: UInt(selectedSeriesIndex))
        }
        
        if series.index == 0 {
            return labelRender
        }
        
        return nil
    }
    
    func chart(chart: TKChart!, didSelectPoint point: TKChartData!, inSeries series: TKChartSeries!, atIndex index: Int) {
        if self.labelRender != nil {
            self.labelRender!.selectedSeriesIndex = series.index
            self.labelRender!.selectedDataPointIndex = UInt(index)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
