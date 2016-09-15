//
//  ChartDocsPopulatingWithData.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsPopulatingWithData.h"

@interface ModelObject : NSObject

@property (nonatomic) NSInteger objectID;
@property (nonatomic) NSInteger value1;
@property (nonatomic) NSInteger value2;
@property (nonatomic) NSInteger value3;

- (instancetype __nonnull)initWithObjectID:(NSInteger)objectId value1:(NSInteger)value1 value2:(NSInteger)value2 value3:(NSInteger)value3;

@end

@implementation ModelObject

- (instancetype)initWithObjectID:(NSInteger)objectId value1:(NSInteger)value1 value2:(NSInteger)value2 value3:(NSInteger)value3
{
    self = [self init];
    if (self) {
        _objectID = objectId;
        _value1 = value1;
        _value2 = value2;
        _value3 = value3;
    }
    
    return self;
}

@end


@implementation ChartDocsPopulatingWithData
{
    TKChart *chart;
}
// >> chart-populating-delegate
- (void)viewDidLoad
{
    [super viewDidLoad];
    chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:chart];
    chart.dataSource = self;
}

- (NSUInteger)numberOfSeriesForChart:(TKChart *)chart
{
    return 1;
}

- (TKChartSeries *)seriesForChart:(TKChart *)c atIndex:(NSUInteger)index
{
    TKChartLineSeries *series = [chart dequeueReusableSeriesWithIdentifier:@"series1"];
    if (!series) {
        series = [[TKChartLineSeries alloc] initWithItems:nil reuseIdentifier:@"series1"];
        series.title = @"Delegate series";
    }
    
    return series;
}

- (NSUInteger)chart:(TKChart *)chart numberOfDataPointsForSeriesAtIndex:(NSUInteger)seriesIndex
{
    return 10;
}

- (id<TKChartData>)chart:(TKChart *)chart dataPointAtIndex:(NSUInteger)dataIndex forSeriesAtIndex:(NSUInteger)seriesIndex
{
    TKChartDataPoint *point = [[TKChartDataPoint alloc] initWithX:@(dataIndex) Y:@(arc4random() % 100)];
    return point;
}

// << chart-populating-delegate

- (void) populateWithDataPoints{

    // >> chart-populating-datapoints
    chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    NSArray *categories = @[ @"Greetings", @"Perfecto", @"NearBy", @"Family Store", @"Fresh & Green" ];
    NSArray *values = @[ @70, @75, @58, @59, @88 ];
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i < categories.count; i++) {
        TKChartDataPoint *dataPoint = [[TKChartDataPoint alloc] initWithX:categories[i] Y:values[i]];
        [dataPoints addObject:dataPoint];
    }
    
    TKChartColumnSeries *series = [[TKChartColumnSeries alloc] initWithItems:dataPoints];
    [chart addSeries:series];
    // << chart-populating-datapoints
}

- (void)bindingToObjectModel {
    // >> chart-binding-props
    chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i<=5; i++) {
        ModelObject *object = [[ModelObject alloc] initWithObjectID:i value1:arc4random() % 100 value2:arc4random() % 100 value3:arc4random() % 100];
        [dataPoints addObject:object];
    }
    
    [chart beginUpdates];
    [chart addSeries:[[TKChartLineSeries alloc] initWithItems:dataPoints forKeys:@{ @"dataXValue": @"objectID", @"dataYValue": @"value1"}]];
    [chart addSeries:[[TKChartAreaSeries alloc] initWithItems:dataPoints forKeys:@{ @"dataXValue": @"objectID", @"dataYValue": @"value2"}]];
    [chart addSeries:[[TKChartScatterSeries alloc] initWithItems:dataPoints forKeys:@{ @"dataXValue": @"objectID", @"dataYValue": @"value3"}]];
    [chart endUpdates];
    // << chart-binding-props
}

@end


