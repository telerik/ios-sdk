//
//  MyPointLabelRender.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class MyPointLabelRender: TKChartPointLabelRender {
    
    var selectedDataPointIndex: Int = 3
    var selectedSeriesIndex: Int = 0
    var labelLayer: SelectedPointLabel?
    var isSelectedPoint = false
   
    init(render: TKChartSeriesRender, selectedDataIndex: Int, selectedSeriesIndex: Int)
    {
        super.init(render: render)
        self.selectedDataPointIndex = selectedDataIndex
        self.selectedSeriesIndex = selectedSeriesIndex
    }
    
    override func renderPointLabelsForSeries(series: TKChartSeries!, inRect bounds: CGRect, context ctx: CGContext!) {
        if labelLayer != nil {
            labelLayer!.removeFromSuperlayer()
        }
        for i in 0..<series.items().count {
            let dataPoint = series.items()[i] as TKChartData
            let location = self.locationForDataPoint(dataPoint, forSeries: series, inRect: bounds)
            if !CGRectContainsPoint(bounds, location) {
                continue
            }
            
            let label: TKChartPointLabel? = self.labelForDataPoint(dataPoint, inSeries: series, atIndex:(UInt)(i))
            var labelRect = CGRectZero
            let labelStyle = series.style.pointLabelStyle
            if isSelectedPoint {
                var labelRect = CGRectMake(location.x - 17.5, location.y - 10 - 2.5 * abs(labelStyle.labelOffset.vertical), 35, 30)
                if labelRect.origin.y < bounds.origin.y {
                    labelRect.origin.y = location.y + 10 + 2.5 * abs(labelStyle.labelOffset.vertical) - labelRect.size.height
                    self.labelLayer!.isOutsideBounds = true
                }
                else {
                    self.labelLayer!.isOutsideBounds = false
                }
                
                self.labelLayer!.frame = labelRect
                self.render.addSublayer(labelLayer)
                self.labelLayer!.setNeedsDisplay()
            }
            else {
                let labelSize = label!.sizeThatFits(bounds.size)
                labelRect = CGRectMake(location.x - labelSize.width / 2.0 + labelStyle.labelOffset.horizontal,
                    location.y - labelSize.height / 2.0 + labelStyle.labelOffset.vertical,
                    labelSize.width, labelSize.height)
                
                if labelStyle!.clipMode == TKChartPointLabelClipMode.Visible {
                    if labelRect.origin.y < self.render.bounds.origin.y {
                        labelRect.origin.y = location.y - labelSize.height / 2.0 + fabs(labelStyle.labelOffset.vertical)
                    }
                }
                
                label!.drawInContext(ctx, inRect: labelRect, forVisualPoint: nil)
            }
        }
    }
    
    override func labelForDataPoint(dataPoint: TKChartData!, inSeries series: TKChartSeries!, atIndex dataIndex: UInt) -> TKChartPointLabel! {
        if Int(series.index) == self.selectedSeriesIndex && Int(dataIndex) == self.selectedDataPointIndex {
            if labelLayer == nil {
                labelLayer = SelectedPointLabel()
                labelLayer!.needsDisplayOnBoundsChange = true
                labelLayer!.contentsScale = UIScreen.mainScreen().scale
                labelLayer!.drawsAsynchronously = true
            }
            
            labelLayer!.labelStyle = series.style.pointLabelStyle
            labelLayer!.text = "\(dataPoint.dataYValue())"
            self.isSelectedPoint = true
            return nil
        }
        
        self.isSelectedPoint = false
        return TKChartPointLabel(point: dataPoint, style: series.style.pointLabelStyle, text: "\(dataPoint.dataYValue())")
    }
}
