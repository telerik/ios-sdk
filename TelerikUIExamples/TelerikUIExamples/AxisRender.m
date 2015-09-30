//
//  AxisRender.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 г. Telerik. All rights reserved.
//

#import "AxisRender.h"

@implementation AxisRender

-(void)drawInContext:(CGContextRef)ctx
{
    CGRect rect = [self boundsRect];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colors [] = {
        0.42, 0.66, 0.31, 1.0,
        0.95, 0.76, 0.20, 1.0,
        0.80, 0.25, 0.15, 1.0
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 3);
    CGColorSpaceRelease(colorSpace);
    colorSpace = NULL;
    
    NSInteger tickSpaces = self.axis.majorTickCount - 1;
    NSInteger pointsCount = 5;
    if (self.chart.frame.size.height < self.chart.frame.size.width) {
        pointsCount = 3;
    }
    
    CGFloat diameter = 8;
    CGFloat spaceHeight = rect.size.height / tickSpaces;
    CGFloat spacing = (spaceHeight - (pointsCount * diameter)) / (pointsCount + 1);
    NSInteger allPointsCount = pointsCount * tickSpaces;
    CGMutablePathRef multipleCirclePath = CGPathCreateMutable();
    double y = CGRectGetMinY(rect) +  diameter / 2.0  + spacing;
    for (int i = 1; i <= allPointsCount; i++) {
        CGPoint center = CGPointMake(CGRectGetMidX(rect), y);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, NULL, center.x, center.y, diameter / 2.0, 0, M_PI * 2, YES);

        CGPathAddPath(multipleCirclePath, NULL, path);
        y += spacing + diameter;
        if (i % pointsCount == 0) {
            y += spacing;
        }
        
        CGPathRelease(path);
    }
    
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, multipleCirclePath);
    CGContextClip(ctx);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    gradient = NULL;
    CGContextRestoreGState(ctx);
    CGPathRelease(multipleCirclePath);
    [super drawInContext:ctx];
}

@end
