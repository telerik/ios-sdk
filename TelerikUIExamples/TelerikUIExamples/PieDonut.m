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
    TKChart *_chart;
    TKChart *_donutChart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect bounds = self.view.bounds;
    
    _chart = [[TKChart alloc] initWithFrame:CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y,
                                                                      bounds.size.width, bounds.size.height / 2), 10, 10)];
    _chart.autoresizingMask = ~UIViewAutoresizingNone;
    _chart.allowAnimations = YES;
     // >> chart-legend
    _chart.legend.hidden = NO;
    // << chart-legend
    
    // >> chart-legend-position
    _chart.legend.style.position = TKChartLegendPositionRight;
    // << chart-legend-position
    
    [self.view addSubview:_chart];
    
    _donutChart = [[TKChart alloc] initWithFrame:CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.height/2,
                                                                        bounds.size.width, bounds.size.height/2), 10, 10)];
    _donutChart.autoresizingMask = ~UIViewAutoresizingNone;
    _donutChart.allowAnimations = YES;
    
   
    _donutChart.legend.hidden = NO;
    
    
    _donutChart.legend.style.position = TKChartLegendPositionRight;
    [self.view addSubview:_donutChart];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Google" value:@20]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Apple" value:@30]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Microsoft" value:@10]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"IBM" value:@5]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Oracle" value:@8]];
    
    TKChartPieSeries *series = [[TKChartPieSeries alloc] initWithItems:array];
    series.selectionAngle = @(-M_PI_2);
    series.expandRadius = 1.2;
    [_chart addSeries:series];
    _chart.dataPointSelectionMode = TKChartSelectionModeSingle;

    TKChartDonutSeries *donutSeries = [[TKChartDonutSeries alloc] initWithItems:array];
    donutSeries.innerRadius = 0.6;
    donutSeries.expandRadius = 1.1;
    [_donutChart addSeries:donutSeries];
    _donutChart.dataPointSelectionMode = TKChartSelectionModeSingle;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_chart select:[[TKChartSelectionInfo alloc] initWithSeries:_chart.series[0] dataPointIndex:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
