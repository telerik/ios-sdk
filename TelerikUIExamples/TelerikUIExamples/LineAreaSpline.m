//
//  LineAreaSpline.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "LineAreaSpline.h"
#import <TelerikUI/TelerikUI.h>

@implementation LineAreaSpline
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    [self reloadChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadChart
{
    [_chart removeAllData];
    
    for (int i = 0; i<3; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i<7; i++) {
            [array addObject:[[TKChartDataPoint alloc] initWithX:@(i+1) Y:@(arc4random() % 100)]];
        }
        
        TKChartSeries *series = nil;
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
        series.selectionMode = TKChartSeriesSelectionModeSeries;
        [_chart addSeries:series];
    }

    [_chart reloadData];
}

@end
