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
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    NSMutableArray *dataPoints = [NSMutableArray new];
    for(int i = 0; i < 10; i++) {
        CGFloat y = i * 10;
        [dataPoints addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(i % 2==0 ? -y : y)]];
    }
    
    TKChartNumericAxis *xAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(0) andMaximum:@(9)];
    xAxis.position = TKChartAxisPositionBottom;
    
    // >> chart-interval-set
    xAxis.majorTickInterval = @1;
    xAxis.minorTickInterval = @1;
    // << chart-interval-set
    
    xAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignmentRight;
    _chart.xAxis = xAxis;
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(-100) andMaximum:@(100)];
    yAxis.position = TKChartAxisPositionLeft;
    yAxis.majorTickInterval = @20;
    yAxis.minorTickInterval = @1;
    yAxis.offset = @0;
    yAxis.baseline = @0;
    
    // >> chart-fitmode
    yAxis.style.labelStyle.fitMode = TKChartAxisLabelFitModeRotate;
    // << chart-fitmode
    
    yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignmentLeft;
    yAxis.style.lineStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:0.85 alpha:1.] width:2];
    _chart.yAxis = yAxis;
    
    TKChartSplineAreaSeries *series = [[TKChartSplineAreaSeries alloc] initWithItems:dataPoints];
    CGFloat shapeSize = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 10 : 17;
    series.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(shapeSize, shapeSize)];
    series.selection = TKChartSeriesSelectionSeries;
    [_chart addSeries:series];
    _chart.xAxis.allowZoom = YES;
    _chart.yAxis.allowZoom = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
