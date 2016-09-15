//
//  ChartDocsBarSeries.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsBarSeries.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsBarSeries
{
    NSMutableArray *pointsWithCategoriesAndValues;
    NSMutableArray *pointsWithCategoriesAndValues2;
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pointsWithCategoriesAndValues = [[NSMutableArray alloc] init];
    pointsWithCategoriesAndValues2 = [[NSMutableArray alloc] init];
    NSArray *categories = @[ @"Greetings", @"Perfecto", @"NearBy", @"Family Store", @"Fresh & Green" ];
    NSArray *values = @[ @70, @75, @58, @59, @88 ];
    for (int i = 0; i < categories.count; i++) {
        TKChartDataPoint *dataPoint = [[TKChartDataPoint alloc] initWithX:values[i] Y:categories[i]];
        [pointsWithCategoriesAndValues addObject:dataPoint];
    }
    
    NSArray *values2 = @[ @40, @80, @35, @69, @95 ];
    for (int i = 0; i < categories.count; i++) {
        TKChartDataPoint *dataPoint = [[TKChartDataPoint alloc] initWithX:values2[i] Y:categories[i]];
        [pointsWithCategoriesAndValues2 addObject:dataPoint];
    }
    
    //    [self visualAppearance];
}

- (void)simpleBarChart
{
    // >> chart-bar-width
    TKChartBarSeries *series = [[TKChartBarSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    series.minBarHeight = @20;
    series.maxBarHeight = @50;
    [chart addSeries:series];
    // << chart-bar-width
}

- (void)clusterBarSeries
{
    // >> chart-bar-cls
    NSArray *categories = @[ @"Greetings", @"Perfecto", @"NearBy", @"Family Store", @"Fresh & Green" ];
    TKChartCategoryAxis *categoryAxis = [[TKChartCategoryAxis alloc] initWithCategories:categories];
    chart.yAxis = categoryAxis;
    
    TKChartSeries *series1 = [[TKChartBarSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    series1.yAxis = categoryAxis;
    
    TKChartSeries *series2 = [[TKChartBarSeries alloc] initWithItems:pointsWithCategoriesAndValues2];
    series2.yAxis = categoryAxis;
    
    [chart beginUpdates];
    [chart addSeries:series1];
    [chart addSeries:series2];
    [chart endUpdates];
    // << chart-bar-cls
}

- (void)stackBarSeries
{
    // >> chart-bar-stack
    TKChartStackInfo *stackInfo = [[TKChartStackInfo alloc] initWithID:@(1) withStackMode:TKChartStackModeStack];
    
    TKChartBarSeries *series1 = [[TKChartBarSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    series1.stackInfo = stackInfo;
    
    TKChartBarSeries *series2 = [[TKChartBarSeries alloc] initWithItems:pointsWithCategoriesAndValues2];
    series2.stackInfo = stackInfo;
    
    [chart beginUpdates];
    [chart addSeries:series1];
    [chart addSeries:series2];
    [chart endUpdates];
    // << chart-bar-stack
}

- (void)stack100BarSeries
{
    // >> chart-bar-stack-100
    TKChartStackInfo *stackInfo = [[TKChartStackInfo alloc] initWithID:@(1) withStackMode:TKChartStackModeStack100];
    
    TKChartBarSeries *series1 = [[TKChartBarSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    series1.stackInfo = stackInfo;
    
    TKChartBarSeries *series2 = [[TKChartBarSeries alloc] initWithItems:pointsWithCategoriesAndValues2];
    series2.stackInfo = stackInfo;
    
    [chart beginUpdates];
    [chart addSeries:series1];
    [chart addSeries:series2];
    [chart endUpdates];
    // << chart-bar-stack-100
}

- (void)visualAppearance
{
    // >> chart-bar-visual
    TKChartBarSeries *series = [[TKChartBarSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    // >> chart-column-visual
    series.style.palette = [[TKChartPalette alloc] init];
    
    TKChartPaletteItem *palleteItem = [[TKChartPaletteItem alloc] init];
    palleteItem.fill = [TKSolidFill solidFillWithColor:[UIColor redColor]];
    palleteItem.stroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    
    [series.style.palette addPaletteItem:palleteItem];
    [chart addSeries:series];
    // << chart-column-visual
    // << chart-bar-visual
}

- (void)gapBetweenSeries
{
    // >> chart-bar-gap
    TKChartBarSeries *series = [[TKChartBarSeries alloc] initWithItems:pointsWithCategoriesAndValues];
    series.gapLength = 0.5;
    [chart addSeries:series];
    // << chart-bar-gap
}

- (void) barRange{
    // >> chart-range-bar
    NSArray *lowValues = @[@33, @29, @55, @21, @10, @39, @40, @11];
    NSArray *highValues = @[@47, @61, @64, @40, @33, @90, @87, @69];
    NSArray *lowValues2 = @[@31, @32, @57, @18, @12, @31, @45, @14];
    NSArray *highValues2 = @[@43, @66, @61, @49, @31, @80, @82, @78];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    NSMutableArray *dataPoints2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        [dataPoints addObject:[TKChartRangeDataPoint dataPointWithY:@(i) low:lowValues[i] high:highValues[i]]];
        [dataPoints2 addObject:[TKChartRangeDataPoint dataPointWithY:@(i) low:lowValues2[i] high:highValues2[i]]];
    }
    
    TKChartRangeBarSeries *series = [[TKChartRangeBarSeries alloc] initWithItems:dataPoints];
    TKChartRangeBarSeries *series2 = [[TKChartRangeBarSeries alloc] initWithItems:dataPoints2];
    
    [chart addSeries:series];
    [chart addSeries:series2];
    // << chart-range-bar
    
    // >> chart-range-bar-visual
    series.style.palette = [[TKChartPalette alloc] init];
    TKChartPaletteItem *paletteItem = [[TKChartPaletteItem alloc] init];
    paletteItem.fill = [TKSolidFill solidFillWithColor:[UIColor redColor]];
    paletteItem.stroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    [series.style.palette addPaletteItem:paletteItem];
    [chart addSeries:series];
    // << chart-range-bar-visual
    
    // >> chart-range-bar-gap
    series.gapLength = 0.5;
    // << chart-range-bar-gap
    
    // >> chart-range-bar-height
    series.minBarHeight = @20;
    series.maxBarHeight = @50;
    // << chart-range-bar-height
}

@end
