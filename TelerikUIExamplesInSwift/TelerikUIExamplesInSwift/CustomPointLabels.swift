//
//  CustomPointLabels.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class CustomPointLabels: ExampleViewController, TKChartDelegate {

    let chart = TKChart()
    var selectedSeriesIndex: UInt = 0
    var selectedDataPointIndex: UInt = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chart.frame = self.exampleBoundsWithInset;
        chart.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        chart.delegate = self
        self.view.addSubview(chart)
        
        let values = [58, 59, 61, 64, 66, 69, 72, 72, 69]
        let values1 = [42, 44, 47, 51, 56, 61, 62, 64, 62]
        var dataPoints = [TKChartDataPoint]()
        var dataPoints1 = [TKChartDataPoint]()
        for i in 0..<values.count {
            let dataPoint = TKChartDataPoint(x: i, y: values[i])
            let dataPoint1 = TKChartDataPoint(x: i, y: values1[i])
            dataPoints.append(dataPoint)
            dataPoints1.append(dataPoint1)
        }
        
        let lineSeries = TKChartLineSeries(items: dataPoints)
        lineSeries.selectionMode = TKChartSeriesSelectionMode.DataPoint
        lineSeries.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(8, 8))
        lineSeries.style.pointLabelStyle.textHidden = false
        lineSeries.style.pointLabelStyle.layoutMode = TKChartPointLabelLayoutMode.Manual
        lineSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -24)
        lineSeries.style.pointLabelStyle.insets = UIEdgeInsetsMake(-1, -5, -1, -5)
        lineSeries.style.pointLabelStyle.font = UIFont.systemFontOfSize(10)
        lineSeries.style.pointLabelStyle.textAlignment = NSTextAlignment.Center
        lineSeries.style.pointLabelStyle.textColor = UIColor.whiteColor()
        lineSeries.style.pointLabelStyle.fill = TKSolidFill(color: UIColor(red: 108/255.0, green: 181/255.0, blue: 250/255.0 , alpha: 1.0))
        lineSeries.style.pointLabelStyle.clipMode = TKChartPointLabelClipMode.Hidden
        
        let lineSeries1 = TKChartLineSeries(items: dataPoints1)
        lineSeries1.selectionMode = TKChartSeriesSelectionMode.DataPoint
        lineSeries1.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(8, 8))
        lineSeries1.style.pointLabelStyle.textHidden = false
        lineSeries1.style.pointLabelStyle.layoutMode = TKChartPointLabelLayoutMode.Manual
        lineSeries1.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -24)
        lineSeries1.style.pointLabelStyle.insets = UIEdgeInsetsMake(-1, -5, -1, -5)
        lineSeries1.style.pointLabelStyle.font = UIFont.systemFontOfSize(10)
        lineSeries1.style.pointLabelStyle.textAlignment = NSTextAlignment.Center
        lineSeries1.style.pointLabelStyle.textColor = UIColor.whiteColor()
        lineSeries1.style.pointLabelStyle.fill = TKSolidFill(color: UIColor(red: 241/255.0, green: 140/255.0, blue: 133/255.0 , alpha: 1.0))
        lineSeries1.style.pointLabelStyle.clipMode = TKChartPointLabelClipMode.Hidden
        
        let yAxis = TKChartNumericAxis(minimum: 40, andMaximum: 80)
        yAxis.majorTickInterval = 10
        chart.yAxis = yAxis
        
        chart.addSeries(lineSeries)
        chart.addSeries(lineSeries1)
    }
    
    func chart(chart: TKChart!, labelForDataPoint dataPoint: TKChartData!, inSeries series: TKChartSeries!, atIndex dataIndex: UInt) -> TKChartPointLabel! {
        if series.index == self.selectedSeriesIndex && dataIndex == self.selectedDataPointIndex {
            return MyPointLabel(point: dataPoint, style: series.style.pointLabelStyle, text: "\(dataPoint.dataYValue())")
        }
        
        return TKChartPointLabel(point: dataPoint, style: series.style.pointLabelStyle, text: "\(dataPoint.dataYValue())")
    }
    
    func chart(chart: TKChart!, paletteItemForPoint index: UInt, inSeries series: TKChartSeries!) -> TKChartPaletteItem! {
        if series.index == self.selectedSeriesIndex && index == self.selectedDataPointIndex {
            return TKChartPaletteItem(stroke: TKStroke(color: UIColor.blackColor(), width: 2.0), andFill: TKSolidFill(color: UIColor.whiteColor()))
        }
        
        if series.index == 0 {
            return TKChartPaletteItem(fill: TKSolidFill(color: UIColor(red: 108/255.0, green: 181/255.0, blue: 250/255.0, alpha: 1.0)))
        }
        
        return TKChartPaletteItem(fill: TKSolidFill(color: UIColor(red: 241/255.0, green: 140/255.0, blue: 133/255.0, alpha: 1.0)))
    }
    
    func chart(chart: TKChart!, didSelectPoint point: TKChartData!, inSeries series: TKChartSeries!, atIndex index: Int) {
        self.selectedSeriesIndex = series.index
        self.selectedDataPointIndex = (UInt)(index)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
