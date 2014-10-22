//
//  PieDonut.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "PieDonut.h"
#import <TelerikUI/TelerikUI.h>

@implementation PieDonut
{
    TKChart *_pieChart;
    TKChart *_donutChart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect bounds = [self exampleBounds];
    
    _pieChart = [[TKChart alloc] initWithFrame:CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y,
                                                                       bounds.size.width, bounds.size.height / 2), 10, 10)];
    _pieChart.autoresizingMask = ~UIViewAutoresizingNone;
    _pieChart.allowAnimations = YES;
    _pieChart.legend.hidden = NO;
    _pieChart.legend.style.position = TKChartLegendPositionRight;
    [self.view addSubview:_pieChart];
    
    _donutChart = [[TKChart alloc] initWithFrame:CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.height/2,
                                                                       bounds.size.width, bounds.size.height/2), 10, 10)];
    _donutChart.autoresizingMask = ~UIViewAutoresizingNone;
    _donutChart.allowAnimations = YES;
    _donutChart.legend.hidden = NO;
    _donutChart.legend.style.position = TKChartLegendPositionRight;
    [self.view addSubview:_donutChart];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@20 name:@"Google"]];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@30 name:@"Apple"]];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@10 name:@"Microsoft"]];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@5 name:@"IBM"]];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@8 name:@"Oracle"]];
    
    TKChartPieSeries *series = [[TKChartPieSeries alloc] initWithItems:array];
    series.selectionMode = TKChartSeriesSelectionModeDataPoint;
    series.selectionAngle = @(-M_PI_2);
    series.expandRadius = 1.2;
    [_pieChart addSeries:series];
    
    TKChartDonutSeries *donutSeries = [[TKChartDonutSeries alloc] initWithItems:array];
    donutSeries.selectionMode = TKChartSeriesSelectionModeDataPoint;
    donutSeries.innerRadius = 0.6;
    donutSeries.expandRadius = 1.1;
    [_donutChart addSeries:donutSeries];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_pieChart select:[[TKChartSelectionInfo alloc] initWithSeries:_pieChart.series[0] dataPointIndex:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
