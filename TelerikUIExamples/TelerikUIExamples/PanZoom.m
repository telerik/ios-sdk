//
//  PanZoom.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "PanZoom.h"

@implementation PanZoom
{
    TKChart *_chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.allowPanDeceleration = YES;
    [self.view addSubview:_chart];
    
    NSMutableArray *items = [NSMutableArray new];
    for (int i = 0; i < 200; i++) {
        [items addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random()%200) Y:@(arc4random()%1000)]];
    }
    TKChartScatterSeries *series = [[TKChartScatterSeries alloc] initWithItems:items];
    [_chart addSeries:series];
    
    items = [NSMutableArray new];
    for (int i = 0; i < 200; i++) {
        [items addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random()%200) Y:@(arc4random()%1000)]];
    }
    series = [[TKChartScatterSeries alloc] initWithItems:items];
    [_chart addSeries:series];
    
    items = [NSMutableArray new];
    for (int i = 0; i < 200; i++) {
        [items addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random()%200) Y:@(arc4random()%1000)]];
    }
    
    series = [[TKChartScatterSeries alloc] initWithItems:items];
    [_chart addSeries:series];
    
    _chart.xAxis.allowZoom = YES;
    _chart.xAxis.allowPan = YES;
    _chart.yAxis.allowZoom = YES;
    _chart.yAxis.allowPan = YES;
}

@end