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
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    // >> chart-category-axis
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *categories = @[ @"Apple", @"Google", @"Microsoft", @"Samsung" ];
    for (int i = 0; i<categories.count; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:categories[i] Y:@(arc4random() % 100)]];
    }
    TKChartColumnSeries *series = [[TKChartColumnSeries alloc] initWithItems:array];
    series.selection = TKChartSeriesSelectionSeries;
    
    // >> chart-add-axis
    TKChartCategoryAxis *xAxis = [[TKChartCategoryAxis alloc] initWithCategories:categories];
    xAxis.position = TKChartAxisPositionBottom;
    xAxis.plotMode = TKChartAxisPlotModeBetweenTicks;
    xAxis.range = [TKRange rangeWithMinimumIndex:0 andMaximumIndex:3];
    _chart.xAxis = xAxis;
    // << chart-add-axis
    // << chart-category-axis
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(0) andMaximum:@(100)];
    yAxis.position = TKChartAxisPositionLeft;
    _chart.yAxis = yAxis;
    
    [_chart addSeries:series];
    
    // >> chart-title
    xAxis.title = @"Vendors";
    xAxis.style.titleStyle.textColor = [UIColor grayColor];
    xAxis.style.titleStyle.font = [UIFont boldSystemFontOfSize:11];
    xAxis.style.titleStyle.alignment = TKChartAxisTitleAlignmentRightOrBottom;
    [_chart reloadData];
    // << chart-title
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
