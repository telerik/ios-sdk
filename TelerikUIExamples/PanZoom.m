//
//  PanZoom.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "PanZoom.h"
#import "DowJonesData.h"

@implementation PanZoom
{
    TKChart *_chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    [_chart beginUpdates];
    for (int i = 0; i < 3; i++) {
        NSMutableArray *points = [[NSMutableArray alloc] init];
        for (int i = 0; i < 100; i++) {
            [points addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random() % 2000) Y:@(arc4random()%500)]];
        }
        TKChartScatterSeries *series = [[TKChartScatterSeries alloc] init];
        series.selectionMode = TKChartSeriesSelectionModeDataPoint;
        
        series.title = [NSString stringWithFormat:@"Series %d", (i+1)];
        if (2 == i) {
            // the last series data can be selected individually
            series.selectionMode = TKChartSeriesSelectionModeDataPoint;
        }
        else {
            series.selectionMode = TKChartSeriesSelectionModeSeries;
        }
        [_chart addSeries:series withItems:points];
    }
    [_chart endUpdates];
    
    _chart.xAxis.allowZoom = YES;
    _chart.yAxis.allowZoom = YES;
}

@end
