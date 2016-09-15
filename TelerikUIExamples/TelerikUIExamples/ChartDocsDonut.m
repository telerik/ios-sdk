//
//  ChartDocsDonut.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsDonut.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsDonut
{
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // >> chart-dnt
    NSMutableArray *pointsWithValueAndName = [[NSMutableArray alloc] init];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Google" value:@20]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Apple" value:@30]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Microsoft" value:@10]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"IBM" value:@5]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Oracle" value:@8]];
    
    TKChartDonutSeries *series = [[TKChartDonutSeries alloc] initWithItems:pointsWithValueAndName];
    series.innerRadius = 0.5;
    
    [chart addSeries:series];
    chart.legend.hidden = NO;
    chart.legend.style.position = TKChartLegendPositionRight;
    // << chart-dnt
}

@end
