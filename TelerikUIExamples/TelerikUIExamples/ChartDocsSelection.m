//
//  ChartDocsSelection.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsSelection.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsSelection
{
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:chart];
    
    NSMutableArray *pointsWithValueAndName = [[NSMutableArray alloc] init];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Google" value:@20]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Apple" value:@30]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Microsoft" value:@10]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"IBM" value:@5]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Oracle" value:@8]];
    
    TKChartPieSeries *series = [[TKChartPieSeries alloc] initWithItems:pointsWithValueAndName];
    series.expandRadius = 1.2;
    [chart addSeries:series];
    
    // >> chart-get-selected-series
    for (TKChartSeries *series in chart.selectedSeries) {
        NSLog(@"selected series at index: %d", (int)series.index);
    }
    
    for (TKChartSelectionInfo *info in chart.selectedPoints) {
        NSLog(@"selected point at index %d from series %d", (int)info.dataPointIndex, (int)info.series.index);
    }
    // << chart-get-selected-series
    
    chart.dataPointSelectionMode = TKChartSelectionModeMultiple;
    
    // >> chart-progrm-selection
    [chart select:[[TKChartSelectionInfo alloc] initWithSeries:chart.series[0] dataPointIndex:0]];
    // << chart-progrm-selection
}


- (NSArray *)getSelectedSeries
{
    NSArray *selectedSeries = [chart selectedSeries];
    return selectedSeries;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// >> chart-selection-delegate
- (void)chart:(TKChart *)chart didSelectSeries:(TKChartSeries *)series
{
    // Here you can perform the desired action when the selection is changed.
}

- (void)chart:(TKChart *)chart didSelectPoint:(id<TKChartData>)point inSeries:(TKChartSeries *)series atIndex:(NSInteger)index
{
    // Here you can perform the desired action when the selection is changed.
}

- (void)chart:(TKChart *)chart didDeselectSeries:(TKChartSeries *)series
{
    // Here you can perform the desired action when the selection is changed.
}

- (void)chart:(TKChart *)chart didDeselectPoint:(id<TKChartData>)point inSeries:(TKChartSeries *)series atIndex:(NSInteger)index
{
    // Here you can perform the desired action when the selection is changed.
}
// << chart-selection-delegate

@end
