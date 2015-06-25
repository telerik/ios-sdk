//
//  MyAnnotation.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class MyAnnotation:TKChartPointAnnotation {
    
    var center: CGPoint = CGPoint.zeroPoint
    var shape: TKShape?
    var fill: TKFill?
    var stroke: TKStroke?
    
    override init() {
        super.init()
    }
    
    init(Shape shape: TKShape, X xValue: AnyObject, Y yValue: AnyObject, forSeries series: TKChartSeries) {
        super.init(x: xValue, y: yValue, forSeries: series)
        self.shape = shape
    }

    override func layoutInRect(bounds: CGRect) {
        center = self.locationInRect(bounds)
        if let s = shape {
            center.x -= s.size.width/2
            center.y -= s.size.height/2
        }
    }
    
    override func drawInContext(context: CGContext!) {
        if let s = shape {
            var drawables = [TKDrawing]()
            drawables.append(fill!)
            drawables.append(stroke!)
            s.drawInContext(context, withCenter: center, drawings: drawables)
        }
    }
}