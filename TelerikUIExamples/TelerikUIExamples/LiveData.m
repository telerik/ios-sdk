//
//  LiveData.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "LiveData.h"
#import <TelerikUI/TelerikUI.h>

@implementation LiveData
{
    TKChart *_chart;
    NSMutableArray *_dataPoints;
    TKChartLineSeries *_lineSeries;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _chart = [[TKChart alloc] initWithFrame:self.exampleBounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_chart];
    _dataPoints = [[NSMutableArray alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:0.127 target:self selector:@selector(updateChart:) userInfo:nil repeats:YES];
}

- (void)updateChart:(NSTimer *)timer
{
    [_chart removeAllData];
    
    TKChartDataPoint *dataPoint = [[TKChartDataPoint alloc] initWithX:[NSDate date] Y:@(arc4random() % 70)];
    [_dataPoints addObject:dataPoint];
    if (_dataPoints.count > 25) {
        [_dataPoints removeObjectAtIndex:0];
    }
    
    _chart.yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@0 andMaximum:@100];
    TKChartDataPoint *firstPoint = _dataPoints[0];
    TKChartDataPoint *lastPoint = _dataPoints[_dataPoints.count - 1];
    TKChartDateTimeAxis *xAxis = [[TKChartDateTimeAxis alloc] initWithMinimumDate:firstPoint.dataXValue andMaximumDate:lastPoint.dataXValue];
    xAxis.style.labelStyle.fitMode = TKChartAxisLabelFitModeNone;
    xAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingModeVisible;
    xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitSeconds;
    _chart.xAxis = xAxis;
    
    _lineSeries = [[TKChartLineSeries alloc] initWithItems:_dataPoints];
    [_chart addSeries:_lineSeries];
    [_chart reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
