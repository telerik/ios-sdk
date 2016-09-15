//
//  ChartDocsAreaSeries.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsAreaSeries.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsAreaSeries
{
    NSMutableArray *pointsWithCategoriesAndValues;
    NSMutableArray *pointsWithCategoriesAndValues2;
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // >> chart-area
    pointsWithCategoriesAndValues = [[NSMutableArray alloc] init];
    pointsWithCategoriesAndValues2 = [[NSMutableArray alloc] init];
    NSArray *categories = @[ @"Greetings", @"Perfecto", @"NearBy", @"Family Store", @"Fresh & Green" ];
    NSArray *values = @[ @70, @75, @58, @59, @88 ];
    for (int i = 0; i < categories.count; i++) {
        TKChartDataPoint *dataPoint = [[TKChartDataPoint alloc] initWithX:categories[i] Y:values[i]];
        [pointsWithCategoriesAndValues addObject:dataPoint];
    }
    
    NSArray *values2 = @[ @40, @80, @35, @69, @95 ];
    for (int i = 0; i < categories.count; i++) {
        TKChartDataPoint *dataPoint = [[TKChartDataPoint alloc] initWithX:categories[i] Y:values2[i]];
        [pointsWithCategoriesAndValues2 addObject:dataPoint];
    }
    
    TKChartAreaSeries* seriesForIncomes = [[TKChartAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    [chart addSeries:seriesForIncomes];
    
    TKChartAreaSeries *seriesForExpenses = [[TKChartAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues2];
    [chart addSeries:seriesForExpenses];
    // << chart-area
    
    [self visualAppearance];
}

- (void) visualAppearance
{
    // >> chart-style-fill
    TKChartAreaSeries* seriesForAnnualRevenue = [[TKChartAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    seriesForAnnualRevenue.style.palette = [[TKChartPalette alloc] init];
    TKChartPaletteItem *palleteItem = [[TKChartPaletteItem alloc] init];
    palleteItem.stroke = [TKStroke strokeWithColor:[UIColor brownColor]];
    palleteItem.fill = [TKSolidFill solidFillWithColor:[UIColor redColor]];
    [seriesForAnnualRevenue.style.palette addPaletteItem:palleteItem];
    [chart addSeries:seriesForAnnualRevenue];
    // << chart-style-fill
}

- (void) stackingAreaSeries
{
    // >> chart-stack-area
    TKChartStackInfo *stackInfo = [[TKChartStackInfo alloc] initWithID:@(1) withStackMode:TKChartStackModeStack];
    
    TKChartAreaSeries *seriesForIncome = [[TKChartAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    seriesForIncome.stackInfo = stackInfo;
    
    TKChartAreaSeries *seriesForExpences = [[TKChartAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues2];
    seriesForExpences.stackInfo = stackInfo;
    
    [chart beginUpdates];
    [chart addSeries:seriesForIncome];
    [chart addSeries:seriesForExpences];
    [chart endUpdates];
    // << chart-stack-area
}

- (void) stacking100AreaSeries
{
    // >> chart-stack-area-100
    TKChartStackInfo *stackInfo = [[TKChartStackInfo alloc] initWithID:@(1) withStackMode:TKChartStackModeStack100];
    
    TKChartAreaSeries *seriesForIncome = [[TKChartAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    seriesForIncome.stackInfo = stackInfo;
    
    TKChartAreaSeries *seriesForExpences = [[TKChartAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues2];
    seriesForExpences.stackInfo = stackInfo;
    
    [chart beginUpdates];
    [chart addSeries:seriesForIncome];
    [chart addSeries:seriesForExpences];
    [chart endUpdates];
    // << chart-stack-area-100
}

- (void) areaSeries
{
    TKChartAreaSeries* seriesForIncomes = [[TKChartAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    [chart addSeries:seriesForIncomes];
    
    TKChartAreaSeries *seriesForExpenses = [[TKChartAreaSeries alloc] initWithItems:pointsWithCategoriesAndValues2];
    [chart addSeries:seriesForExpenses];
}

@end
