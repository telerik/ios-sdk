//
//  MyAnnotation.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "NeedleAnnotation.h"
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

@implementation NeedleAnnotation
{
    CGPoint center;
}

- (void)layoutInRect:(CGRect)bounds
{
    double xval = [self.series.xAxis numericValue:[self.position dataXValue]];
    double x = [TKChartSeriesRender locationOfValue:xval forAxis:self.series.xAxis inRect:bounds];
    double yval = [self.series.yAxis numericValue:[self.position dataYValue]];
    double y = [TKChartSeriesRender locationOfValue:yval forAxis: self.series.yAxis inRect: bounds];
    center = CGPointMake(x, y);
}

- (void)drawInContext:(CGContextRef)context
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, center.x-20, center.y);
    CGContextAddLineToPoint(context, center.x+20, center.y+20);
    CGContextAddLineToPoint(context, center.x+20, center.y-20);
        
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextFillPath(context);
}

@end
