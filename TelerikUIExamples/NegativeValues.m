//
//  NegativeValues.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "NegativeValues.h"
#import <TelerikUI/TelerikUI.h>

@implementation NegativeValues
{
    TKChart *_chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    NSMutableArray *dataPoints = [NSMutableArray new];
    for(int i = 0; i < 10; i++) {
        CGFloat y = i * 10;
        [dataPoints addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(i % 2==0 ? -y : y)]];
    }
    
    TKChartNumericAxis *xAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(0) andMaximum:@(9)];
    xAxis.position = TKChartAxisPositionBottom;
    xAxis.majorTickInterval = @1;
    xAxis.minorTickInterval = @1;
    xAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignmentRight;
    _chart.xAxis = xAxis;
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(-100) andMaximum:@(100)];
    yAxis.position = TKChartAxisPositionLeft;
    yAxis.majorTickInterval = @20;
    yAxis.minorTickInterval = @1;
    yAxis.offset = @0;
    yAxis.style.labelStyle.fitMode = TKChartAxisLabelFitModeRotate;
    yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignmentLeft;
    _chart.yAxis = yAxis;
    
    TKChartAreaSeries *series = [[TKChartAreaSeries alloc] initWithItems:dataPoints];
    series.spline = YES;
    CGFloat shapeSize = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 10 : 17;
    series.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(shapeSize, shapeSize)];
    series.selectionMode = TKChartSeriesSelectionModeSeries;
    [_chart addSeries:series];
}

@end
