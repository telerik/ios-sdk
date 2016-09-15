//
//  BindWithDataPoint.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "BindWithDataPoint.h"
#import <TelerikUI/TelerikUI.h>

@interface DataPointImpl : NSObject<TKChartData>

@property (nonatomic, strong) id dataXValue;

@property (nonatomic, strong) id dataYValue;

@property (nonatomic, assign) NSInteger objectID;

@property (nonatomic, assign) CGFloat value;

- (instancetype)initWithID:(NSInteger)objectID withValue:(CGFloat)value;

@end

@implementation DataPointImpl

- (instancetype)initWithID:(NSInteger)objectID withValue:(CGFloat)value
{
    self = [self init];
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
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (int i = 0; i<=5; i++) {
        DataPointImpl *impl = [[DataPointImpl alloc] initWithID:i withValue:arc4random() % 100];
        [data addObject:impl];
    }
    
    TKChartColumnSeries *columnSeries = [[TKChartColumnSeries alloc] initWithItems:data];
    columnSeries.selection = TKChartSeriesSelectionSeries;
    [_chart addSeries: columnSeries];
}

@end
