//
//  CategoricalAxis.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "CategoricalAxis.h"
#import <TelerikUI/TelerikUI.h>

@implementation CategoricalAxis
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
    NSArray *categories = @[ @"Apple", @"Google", @"Microsoft", @"Samsung" ];
    for (int i = 0; i<categories.count; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:categories[i] Y:@(arc4random() % 100)]];
    }
    TKChartColumnSeries *series = [[TKChartColumnSeries alloc] initWithItems:array];
    series.selectionMode = TKChartSeriesSelectionModeSeries;
    
    TKChartCategoryAxis *xAxis = [[TKChartCategoryAxis alloc] initWithCategories:categories];
    xAxis.position = TKChartAxisPositionBottom;
    xAxis.plotMode = TKChartAxisPlotModeBetweenTicks;
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
