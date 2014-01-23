//
//  StackedAreaChart.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "StackedAreaChart.h"
#import <TelerikUI/TelerikUI.h>

@implementation StackedAreaChart
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Stacked" selector:@selector(reloadData)];
        [self addOption:@"Stacked 100" selector:@selector(reloadData)];
        [self addOption:@"No Stacking" selector:@selector(reloadData)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    [self reloadData];
}

- (void)reloadData
{
    [_chart removeAllData];
    
    TKChartStackInfo *stackInfo = nil;
    
    if (self.selectedOption == 0) {
        stackInfo = [[TKChartStackInfo alloc] initWithID:@(1) withStackMode:TKChartStackModeStack];
    }
    else if (self.selectedOption == 1) {
        stackInfo = [[TKChartStackInfo alloc] initWithID:@(1) withStackMode:TKChartStackModeStack100];
    }
    
    for (int i = 0; i<3; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i<8; i++) {
            [array addObject:[[TKChartDataPoint alloc] initWithX:@(i+1) Y:@(arc4random() % 100)]];
        }
        
        TKChartSeries *series = [[TKChartAreaSeries alloc] initWithItems:array];
        series.selectionMode = TKChartSeriesSelectionModeSeries;
        series.stackInfo = stackInfo;
        [_chart addSeries:series withItems:array];
    }
    
    [_chart reloadData];
}

@end
