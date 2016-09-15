//
//  ChartDocsSplineArea.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsSplineArea.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsSplineArea
{
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // >> chart-spline-area
    NSMutableArray *pointsWithCategoriesAndValues = [[NSMutableArray alloc] init];
    NSArray *categories = @[ @"Greetings", @"Perfecto", @"NearBy", @"Family Store", @"Fresh & Green" ];
    NSArray *values = @[@70, @75, @58, @59, @88 ];
    for (int i = 0; i < categories.count; i++) {
        TKChartDataPoint *dataPoint = [[TKChartDataPoint alloc] initWithX:categories[i] Y:values[i]];
        [pointsWithCategoriesAndValues addObject:dataPoint];
    }
    
    TKChartSplineAreaSeries *series = [[TKChartSplineAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    [chart addSeries:series];
    // << chart-spline-area
}

@end
