//
//  ChartDocsPie.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsPie.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsPie
{
    NSMutableArray *_pointsWithValueAndName;
    TKChart *chart;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pointsWithValueAndName = [[NSMutableArray alloc] init];
}

- (void) handleSelection
{
    TKChartPieSeries *series = [[TKChartPieSeries alloc] initWithItems:_pointsWithValueAndName];
    [chart addSeries:series];
    
    // >> chart-pie-select
    series.selection = TKChartSeriesSelectionDataPoint;
    [chart select:[[TKChartSelectionInfo alloc] initWithSeries:chart.series[0] dataPointIndex:1]];
    // << chart-pie-select
}

- (void) visualAppearance
{
    TKChartPieSeries *series = [[TKChartPieSeries alloc] initWithItems:_pointsWithValueAndName];
    [chart addSeries:series];
    
    // >> chart-pie-format
    series.labelDisplayMode = TKChartPieSeriesLabelDisplayModeInside;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    series.style.pointLabelStyle.formatter = numberFormatter;
    // << chart-pie-format
    
    // >> chart-pie-format-percent
    series.style.pointLabelStyle.stringFormat = @"%.0f %%";
    // << chart-pie-format-percent
}

- (void) startEnd
{
    TKChartPieSeries *series = [[TKChartPieSeries alloc] initWithItems:_pointsWithValueAndName];
    [chart addSeries:series];
    
    // >> chart-pie-angle
    series.startAngle = - M_PI_4 / 2;
    series.endAngle = M_PI + M_PI_4 / 2;
    series.rotationAngle = M_PI;
    // << chart-pie-angle
}

- (void) pieSeries
{
    // >> chart-pie
    [_pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Google" value:@20]];
    [_pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Apple" value:@30]];
    [_pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Microsoft" value:@10]];
    [_pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"IBM" value:@5]];
    [_pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Oracle" value:@8]];
    
    TKChartPieSeries *series = [[TKChartPieSeries alloc] initWithItems:_pointsWithValueAndName];
    [chart addSeries:series];
    chart.legend.hidden = NO;
    chart.legend.style.position = TKChartLegendPositionRight;
    // << chart-pie
}

@end
