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
    
    // >> chart-getting-started
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    // << chart-getting-started
    
    // >> chart-getting-started-cus
    _chart.title.hidden = NO;
    _chart.title.text = @"This is a chart demo";
    _chart.legend.hidden = NO;
    _chart.allowAnimations = YES;
    // << chart-getting-started-cus
    
    // >> chart-getting-started-data
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random()%2000)]];
    }
    // << chart-getting-started-data
    
    // >> chart-getting-started-series
    TKChartLineSeries *series = [[TKChartLineSeries alloc] initWithItems:array];
    series.selection = TKChartSeriesSelectionSeries;
    [_chart addSeries:series];
    // << chart-getting-started-series
    
    TKChartNumericAxis *xAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(0) andMaximum:@(11)];
    xAxis.position = TKChartAxisPositionBottom;
    xAxis.majorTickInterval = @1;
    _chart.xAxis = xAxis;
    
    // >> chart-axis-numeric
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(0) andMaximum:@(2000)];
    yAxis.majorTickInterval = @400;
    yAxis.position = TKChartAxisPositionLeft;
    yAxis.labelDisplayMode = TKChartNumericAxisLabelDisplayModePercentage;
    _chart.yAxis = yAxis;
    // << chart-axis-numeric
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
