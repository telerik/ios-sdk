//
//  ScatterChart.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "ScatterChart.h"
#import <TelerikUI/TelerikUI.h>

@implementation ScatterChart
{
    TKChart *_chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_chart];
    
    [_chart beginUpdates];
    
    for (int i = 0; i < 2; i++) {
        // >> chart-scatter
        NSMutableArray *points = [[NSMutableArray alloc] init];
        for (int i = 0; i < 20; i++) {
            [points addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random() % 1450) Y:@(arc4random()%150)]];
        }
        TKChartScatterSeries *series = [[TKChartScatterSeries alloc] initWithItems:points];
        // << chart-scatter
        series.title = [NSString stringWithFormat:@"Series %d", (i+1)];
        if (2 == i) {
            // the last series data can be selected individually
            series.selection = TKChartSeriesSelectionDataPoint;
        }
        else {
            series.selection = TKChartSeriesSelectionSeries;
        }
        
        series.style.paletteMode = TKChartSeriesStylePaletteModeUseItemIndex;
        series.marginForHitDetection = 300;
        [_chart addSeries:series];
    }
    
    [_chart endUpdates];
    _chart.xAxis.allowZoom = YES;
    _chart.yAxis.allowZoom = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

