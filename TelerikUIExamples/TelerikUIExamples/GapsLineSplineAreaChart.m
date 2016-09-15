//
//  GapsLineSplineAreaChart.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "GapsLineSplineAreaChart.h"

@interface GapsLineSplineAreaChart ()

@end

@implementation GapsLineSplineAreaChart
{
    TKChart *_chart;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Line" selector:@selector(reloadChart)];
        [self addOption:@"Spline" selector:@selector(reloadChart)];
        [self addOption:@"Area" selector:@selector(reloadChart)];
        [self addOption:@"Area Spline" selector:@selector(reloadChart)];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    [self reloadChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadChart
{
    [_chart removeAllData];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSArray *categories = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    NSArray *values = @[ @65, @56, @65, @38, @56, @78, @62, @89, @78, @65 ];
    
    for (int i = 0; i<categories.count; i++) {
        if (i == 4 || i == 5) {
            [array addObject:[[TKChartDataPoint alloc] initWithX:categories[i] Y:nil]];
        }
        else {
            [array addObject:[[TKChartDataPoint alloc] initWithX:categories[i] Y:values[i]]];
        }
    }
    
    TKChartLineSeries *series = nil;
    
    switch (self.selectedOption) {
        case 0:
            series = [[TKChartLineSeries alloc] initWithItems:array];
            break;
            
        case 1:
            series = [[TKChartSplineSeries alloc] initWithItems:array];
            break;
            
        case 2:
            series = [[TKChartAreaSeries alloc] initWithItems:array];
            break;
            
        case 3:
            series = [[TKChartSplineAreaSeries alloc] initWithItems:array];
            break;
    }
    
    series.selection = TKChartSeriesSelectionSeries;
    series.displayNilValuesAsGaps = YES;
    [_chart addSeries:series];
}

@end
