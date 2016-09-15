//
//  ChartDocsSplineSeries.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsSplineSeries.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsSplineSeries
{
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // >> chart-spline
    NSMutableArray *profitData = [[NSMutableArray alloc] init];
    NSArray *profitValues = @[@10, @45, @8, @27, @57];
    NSArray *categories = @[@"Greetings", @"Perfecto", @"NearBy", @"Family Store", @"Fresh & Green"];
    for (int i = 0; i < categories.count ; i++) {
        [profitData addObject:[TKChartDataPoint dataPointWithX:categories[i] Y:profitValues[i]]];
    }
    
    TKChartSplineSeries *seriesForProfit = [[TKChartSplineSeries alloc] initWithItems:profitData];
    [chart addSeries:seriesForProfit];
    // << chart-spline
}

@end
