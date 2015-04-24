//
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "ColumnAndBarChart.h"
#import <TelerikUI/TelerikUI.h>

@implementation ColumnAndBarChart
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Column" selector:@selector(columnSelected)];
        [self addOption:@"Bar" selector:@selector(barSelected)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	 
    _chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    [self columnSelected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)columnSelected
{
   [_chart removeAllData];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<8; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(i+1) Y:@(arc4random() % 100)]];
    }
    
    TKChartSeries *series = [[TKChartColumnSeries alloc] initWithItems:array];
    series.style.paletteMode = TKChartSeriesStylePaletteModeUseItemIndex;
    series.selectionMode = TKChartSeriesSelectionModeDataPoint;

    [_chart addSeries:series];
    
    [_chart reloadData];
}

- (void)barSelected
{
    [_chart removeAllData];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<8; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random() % 100) Y:@(i+1)]];
    }
    
    TKChartSeries *series = [[TKChartBarSeries alloc] initWithItems:array];
    series.style.paletteMode = TKChartSeriesStylePaletteModeUseItemIndex;
    series.selectionMode = TKChartSeriesSelectionModeDataPoint;
    [_chart addSeries:series];
    
    [_chart reloadData];
}

@end
