//
//  NumericAxis.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "NumericAxis.h"
#import <TelerikUI/TelerikUI.h>

@implementation NumericAxis
{
    TKChart *_chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random()%2000)]];
    }
    TKChartLineSeries *series = [[TKChartLineSeries alloc] initWithItems:array];
    series.selectionMode = TKChartSeriesSelectionModeSeries;
    
    TKChartNumericAxis *xAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(0) andMaximum:@(11)];
    xAxis.position = TKChartAxisPositionBottom;
    xAxis.majorTickInterval = @1;
    _chart.xAxis = xAxis;
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(0) andMaximum:@(2000)];

    yAxis.majorTickInterval = @400;
    yAxis.position = TKChartAxisPositionLeft;
    _chart.yAxis = yAxis;
    
    [_chart addSeries:series];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
