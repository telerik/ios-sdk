//
//  AxisRender.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

// >> chart-custom-axis-draw-swift
class AxisRender: TKChartAxisRender {

    override func drawInContext(ctx: CGContext) {
        let rect = self.boundsRect()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors: [CGFloat] = [
            0.42, 0.66, 0.31, 1.0,
            0.95, 0.76, 0.20, 1.0,
            0.80, 0.25, 0.15, 1.0]
        
        let gradient = CGGradientCreateWithColorComponents(colorSpace, colors, nil, 3)
        
        let tickSpaces = self.axis!.majorTickCount - 1
        var pointsCount: UInt = 5
        if self.chart?.frame.size.height < self.chart?.frame.size.width {
            pointsCount = 3
        }
        
        let diameter: UInt = 8
        let spaceHeight = rect.size.height / CGFloat(tickSpaces)
        let spacing = (spaceHeight - CGFloat(pointsCount * diameter)) / CGFloat(pointsCount + 1)
        let allPointsCount = pointsCount * tickSpaces
        let multipleCirclePath = CGPathCreateMutable()
        var y = CGRectGetMinY(rect) + CGFloat(diameter) / 2.0 + spacing
        for i in 1 ... allPointsCount {
            let center = CGPointMake(CGRectGetMidX(rect), y)
            let path = CGPathCreateMutable()
            CGPathAddArc(path, nil, center.x, center.y, CGFloat(diameter) / 2.0, 0, CGFloat(M_PI * 2.0), true)
            CGPathAddPath(multipleCirclePath, nil, path)
            y += spacing + CGFloat(diameter)
            if i % pointsCount == 0 {
                y += spacing
            }
        }
        
        CGContextSaveGState(ctx)
        CGContextAddPath(ctx, multipleCirclePath)
        CGContextClip(ctx)
        let startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect))
        let endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect))
        CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsAfterEndLocation)
        CGContextRestoreGState(ctx)
        super.drawInContext(ctx)
    }
    
}
// << chart-custom-axis-draw-swift