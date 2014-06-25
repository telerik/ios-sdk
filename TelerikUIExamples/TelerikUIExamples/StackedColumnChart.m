//
//  StackedColumnChart.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "StackedColumnChart.h"
#import <TelerikUI/TelerikUI.h>

@implementation StackedColumnChart
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Stack" selector:@selector(reloadData)];
        [self addOption:@"Stack 100" selector:@selector(reloadData)];
        [self addOption:@"Clustered" selector:@selector(reloadData)];
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
    if (self.selectedOption < 2) {
        TKChartStackMode stackMode = self.selectedOption == 0 ? TKChartStackModeStack : TKChartStackModeStack100;
        stackInfo = [[TKChartStackInfo alloc] initWithID:@(1) withStackMode:stackMode];
    }
    
    for (int i = 0; i < 4; i++) {
        NSMutableArray *points = [[NSMutableArray alloc] init];
        for (int i = 1; i < 8; i++) {
            [points addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random() % 100)]];
        }
        
        TKChartSeries *series = [[TKChartColumnSeries alloc] initWithItems:points];
        
        series.title = [NSString stringWithFormat:@"Series %d", i];
        series.stackInfo = stackInfo;
        series.selectionMode = TKChartSeriesSelectionModeSeries;
        [_chart addSeries:series];
    }
    
    [_chart reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
