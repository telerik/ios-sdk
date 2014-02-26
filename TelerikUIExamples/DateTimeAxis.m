//
//  DateTimeAxis.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "DateTimeAxis.h"
#import <TelerikUI/TelerikUI.h>

@implementation DateTimeAxis
{
    TKChart *_chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:2013];
    [comps setDay:1];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 6; i++) {
        [comps setMonth:i];
        
        NSDate *date = [gregorian dateFromComponents:comps];
        [array addObject:[[TKChartDataPoint alloc] initWithX:date Y:@(arc4random() % 100)]];
    }
    TKChartSplineAreaSeries *series = [[TKChartSplineAreaSeries alloc] initWithItems:array];
    series.selectionMode = TKChartSeriesSelectionModeSeries;
    
    [comps setMonth:1];
    NSDate *minDate = [gregorian dateFromComponents:comps];
    [comps setMonth:6];
    NSDate *maxDate = [gregorian dateFromComponents:comps];
    TKChartDateTimeAxis *xAxis = [[TKChartDateTimeAxis alloc] initWithMinimumDate:minDate andMaximumDate:maxDate];
    xAxis.position = TKChartAxisPositionBottom;
    xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitMonths;
    _chart.xAxis = xAxis;
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(0) andMaximum:@(100)];
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
