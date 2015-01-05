//
//  NeedleAnnotation.swift
//  SeismographSwift
//
//  Created by Nikolay Diyanov on 12/22/14.
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreMotion

class NeedleAnnotation : TKChartPointAnnotation {
    
    var center: CGPoint = CGPoint.zeroPoint
    
    override func layoutInRect(bounds: CGRect) {
        let xval = self.series.xAxis.numericValue(self.position.dataXValue())
        let x = TKChartSeriesRender.locationOfValue(xval, forAxis: self.series.xAxis, inRect: bounds)
        let yval = self.series.yAxis.numericValue(self.position.dataYValue())
        let y = TKChartSeriesRender.locationOfValue(yval, forAxis: self.series.yAxis, inRect: bounds)
        center = CGPointMake(x, y)
    }
    
    override func drawInContext(context: CGContextRef) {
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, center.x-20, center.y)
        CGContextAddLineToPoint(context, center.x+20, center.y+20)
        CGContextAddLineToPoint(context, center.x+20, center.y-20)
        
        CGContextSetRGBFillColor(context, 0, 0, 0, 1)
        CGContextFillPath(context)
    }
}
