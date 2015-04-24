//
//  BindWithDataPoint.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "BindWithDataPoint.h"
#import <TelerikUI/TelerikUI.h>

@interface DataPointImpl : NSObject<TKChartData>

@property (nonatomic, assign) NSInteger objectID;
@property (nonatomic, assign) CGFloat value;

- (id)initWithID:(NSInteger)objectID withValue:(CGFloat)value;
- (id)dataXValue;
- (id)dataYValue;

@end

@implementation DataPointImpl

- (id)initWithID:(NSInteger)objectID withValue:(CGFloat)value
{
    self = [super init];
    if (self) {
        _objectID = objectID;
        _value = value;
    }
    return self;
}

- (id)dataXValue
{
    return @(self.objectID);
}

- (id)dataYValue
{
    return @(self.value);
}

@end

@implementation BindWithDataPoint
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
        DataPointImpl *impl = [[DataPointImpl alloc] initWithID:i withValue:arc4random() % 100];
        [data addObject:impl];
    }
    
    TKChartColumnSeries *columnSeries = [[TKChartColumnSeries alloc] initWithItems:data];
    columnSeries.selectionMode = TKChartSeriesSelectionModeSeries;
    [_chart addSeries: columnSeries];
}

@end
