//
//  RangeBarColumnChart.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "RangeBarColumnChart.h"
#import <TelerikUI/TelerikUI.h>

@implementation RangeBarColumnChart
{
    TKChart *_chart;
    NSArray *_lowValues;
    NSArray *_highValues;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Range Column" selector:@selector(rangeColumnSelected)];
        [self addOption:@"Range Bar" selector:@selector(rangeBarSelected)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.allowAnimations = YES;
    [self.view addSubview:_chart];
    
    _lowValues = @[@33, @29, @55, @21, @10, @39, @40, @11];
    _highValues = @[@47, @61, @64, @40, @33, @90, @87, @69];
    
    [self rangeColumnSelected];
}

- (void)rangeColumnSelected
{
    [_chart removeAllData];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        [dataPoints addObject:[TKChartRangeDataPoint dataPointWithX:@(i) low:_lowValues[i] high:_highValues[i]]];
    }
    
    TKChartRangeColumnSeries *series = [[TKChartRangeColumnSeries alloc] initWithItems:dataPoints];
    series.style.paletteMode = TKChartSeriesStylePaletteModeUseItemIndex;
    series.selection = TKChartSeriesSelectionDataPoint;
    
    [_chart addSeries:series];
    
    [_chart reloadData];
}

- (void)rangeBarSelected
{
    [_chart removeAllData];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<8; i++) {
        [array addObject:[TKChartRangeDataPoint dataPointWithY:@(i) low:_lowValues[i] high:_highValues[i]]];
    }
    
    TKChartRangeBarSeries *series = [[TKChartRangeBarSeries alloc] initWithItems:array];
    series.style.paletteMode = TKChartSeriesStylePaletteModeUseItemIndex;
    series.selection = TKChartSeriesSelectionDataPoint;
    [_chart addSeries:series];

    [_chart reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
