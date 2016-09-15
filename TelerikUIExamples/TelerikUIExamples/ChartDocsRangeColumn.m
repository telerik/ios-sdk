//
//  ChartDocsRangeColumn.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsRangeColumn.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsRangeColumn
{
    TKChart *chart;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    // >> chart-range-col-cluster
    NSArray *lowValues = @[@33, @29, @55, @21, @10, @39, @40, @11];
    NSArray *highValues = @[@47, @61, @64, @40, @33, @90, @87, @69];
    NSArray *lowValues2 = @[@31, @32, @57, @18, @12, @31, @45, @14];
    NSArray *highValues2 = @[@43, @66, @61, @49, @31, @80, @82, @78];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    NSMutableArray *dataPoints2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        [dataPoints addObject:[TKChartRangeDataPoint dataPointWithX:@(i) low:lowValues[i] high:highValues[i]]];
        [dataPoints2 addObject:[TKChartRangeDataPoint dataPointWithX:@(i) low:lowValues2[i] high:highValues2[i]]];
    }
    
    TKChartRangeColumnSeries *series = [[TKChartRangeColumnSeries alloc] initWithItems:dataPoints];
    TKChartRangeColumnSeries *series2 = [[TKChartRangeColumnSeries alloc] initWithItems:dataPoints2];
    
    [chart addSeries:series];
    [chart addSeries:series2];
    // << chart-range-col-cluster
    
    // >> chart-range-col-visual
    series.style.palette = [[TKChartPalette alloc] init];
    TKChartPaletteItem *paletteItem = [[TKChartPaletteItem alloc] init];
    paletteItem.fill = [TKSolidFill solidFillWithColor:[UIColor redColor]];
    paletteItem.stroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    [series.style.palette addPaletteItem:paletteItem];
    [chart addSeries:series];
    // << chart-range-col-visual
    
    // >> chart-range-col-gap
    series.gapLength = 0.5;
    // << chart-range-col-gap
    
    // >> chart-range-col-width
    series.minColumnWidth = @20;
    series.maxColumnWidth = @50;
    // << chart-range-col-width
}

@end
