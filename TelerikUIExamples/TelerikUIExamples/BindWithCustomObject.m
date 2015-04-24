//
//  BindWithCustomObject.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "BindWithCustomObject.h"
#import <TelerikUI/TelerikUI.h>

@interface CustomObject : NSObject

@property (nonatomic, assign) NSInteger objectID;
@property (nonatomic, assign) CGFloat value1;
@property (nonatomic, assign) CGFloat value2;
@property (nonatomic, assign) CGFloat value3;

@end

@implementation CustomObject
@end

@implementation BindWithCustomObject
{
    TKChart *_chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (int i = 0; i<=5; i++) {
        CustomObject *obj = [[CustomObject alloc] init];
        obj.objectID = i;
        obj.value1 = arc4random() % 100;
        obj.value2 = arc4random() % 100;
        obj.value3 = arc4random() % 100;
        [data addObject:obj];
    }
    
    [_chart addSeries:[[TKChartAreaSeries alloc] initWithItems:data forKeys:@{ @"dataXValue": @"objectID", @"dataYValue": @"value1"}]];
    [_chart addSeries:[[TKChartAreaSeries alloc] initWithItems:data forKeys:@{ @"dataXValue": @"objectID", @"dataYValue": @"value2" }]];
    [_chart addSeries:[[TKChartAreaSeries alloc] initWithItems:data xValueKey:@"objectID" yValueKey:@"value3"]];
    
    TKChartStackInfo *stackInfo = [[TKChartStackInfo alloc] initWithID:@(1) withStackMode:TKChartStackModeStack];
    for (int i =0; i<_chart.series.count; i++) {
        TKChartSeries *series = _chart.series[i];
        series.selectionMode = TKChartSeriesSelectionModeSeries;
        series.stackInfo = stackInfo;
    }

    [_chart reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
