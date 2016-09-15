//
//  BubbleChart.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "BubbleChart.h"
#import <TelerikUI/TelerikUI.h>

@implementation BubbleChart
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
    // >> chart-bubble
    for (int i = 0; i < 2; i++) {
        NSMutableArray *points = [[NSMutableArray alloc] init];
        for (int i = 0; i < 20; i++) {
            [points addObject:[[TKChartBubbleDataPoint alloc] initWithX:@(arc4random() % 1450) Y:@(arc4random() % 150) area:@(arc4random() % 200)]];
        }
        
        TKChartBubbleSeries *series = [[TKChartBubbleSeries alloc] initWithItems:points];
        // << chart-bubble
        series.title = [NSString stringWithFormat:@"Series %d", (i + 1)];
        series.scale = @1.5;
        series.marginForHitDetection = 2.f;
        if (i == 0) {
            series.selection = TKChartSeriesSelectionDataPoint;
        } else {
            series.selection = TKChartSeriesSelectionSeries;
        }
        
        [_chart addSeries:series];
    }
    
    [_chart endUpdates];
}

@end
