//
//  DefaultAnimation.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "DefaultAnimation.h"
#import <TelerikUI/TelerikUI.h>

@implementation DefaultAnimation
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self) {
        
        NSArray *names = @[ @"Area Series", @"Pie Series", @"Line Series", @"Scatter Series", @"Bar Series", @"Column Series" ];
        UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];

        [self addOption:[self nameForOption:0 names:names idiom:idiom] selector:@selector(setupAreaSeries)];
        [self addOption:[self nameForOption:1 names:names idiom:idiom] selector:@selector(setupPieSeries)];
        [self addOption:[self nameForOption:2 names:names idiom:idiom] selector:@selector(setupLineSeries)];
        [self addOption:[self nameForOption:3 names:names idiom:idiom] selector:@selector(setupScatterSeries)];
        [self addOption:[self nameForOption:4 names:names idiom:idiom] selector:@selector(setupBarSeries)];
        [self addOption:[self nameForOption:5 names:names idiom:idiom] selector:@selector(setupColumnSeries)];
    }
    
    return self;
}

- (NSString*)nameForOption:(NSInteger)index names:(NSArray*)names idiom:(UIUserInterfaceIdiom)idiom
{
    NSString *name = names[index];
    if (idiom != UIUserInterfaceIdiomPad) {
        name = [NSString stringWithFormat:@"%@ Animation", name];
    }
    return name;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.allowAnimations = YES;
    [self.view addSubview:_chart];
    
    [self setupAreaSeries];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLineSeries
{
    [_chart removeAllData];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< 10; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random() % 100)]];
    }
    
    TKChartLineSeries *lineSeries = [[TKChartLineSeries alloc] initWithItems:array];
    lineSeries.selectionMode = TKChartSeriesSelectionModeSeries;
    [_chart addSeries: lineSeries];
}

- (void)setupAreaSeries
{
    [_chart removeAllData];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< 10; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random() % 100)]];
    }
    
    TKChartAreaSeries *areaSeries = [[TKChartAreaSeries alloc] initWithItems:array];
    areaSeries.selectionMode = TKChartSeriesSelectionModeSeries;
    [_chart addSeries: areaSeries];
}

- (void)setupPieSeries
{
    [_chart removeAllData];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Google" value:@20]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Apple" value:@30]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Microsoft" value:@10]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"IBM" value:@5]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Oracle" value:@8]];
    TKChartPieSeries *series = [[TKChartPieSeries alloc] initWithItems:array];
    series.selectionMode = TKChartSeriesSelectionModeDataPoint;
    [_chart addSeries:series];
}

- (void)setupScatterSeries
{
    [_chart removeAllData];
    
    NSMutableArray *points = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; i++) {
        [points addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random() % 1450) Y:@(arc4random()%150)]];
    }
    
    TKChartScatterSeries *scatterSeries = [[TKChartScatterSeries alloc] initWithItems:points];
    scatterSeries.selectionMode = TKChartSeriesSelectionModeSeries;
    [_chart addSeries: scatterSeries];
}

- (void)setupBarSeries
{
    [_chart removeAllData];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< 10; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random() % 100) Y:@(i)]];
    }
    
    TKChartBarSeries *barSeries = [[TKChartBarSeries alloc] initWithItems:array];
    barSeries.selectionMode = TKChartSeriesSelectionModeSeries;
    [_chart addSeries: barSeries];
}

- (void)setupColumnSeries
{
    [_chart removeAllData];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< 10; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random() % 100)]];
    }
    
    TKChartColumnSeries *columnSeries = [[TKChartColumnSeries alloc] initWithItems:array];
    columnSeries.selectionMode = TKChartSeriesSelectionModeSeries;
    [_chart addSeries:columnSeries];
}

@end
