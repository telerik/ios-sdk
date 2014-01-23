//
//  BindWithDelegate.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "BindWithDelegate.h"
#import <TelerikUI/TelerikUI.h>

@interface ChartDataSource : NSObject<TKChartDataSource>
@end

@implementation ChartDataSource

- (NSUInteger)numberOfSeriesForChart:(TKChart *)chart
{
    return 3;
}

- (TKChartSeries *)seriesForChart:(TKChart *)chart atIndex:(NSUInteger)index
{
    TKChartLineSeries *series = [[TKChartLineSeries alloc] init];
    series.selectionMode = TKChartSeriesSelectionModeDataPoint;
    series.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(10, 10)];
    series.selectionMode = TKChartSeriesSelectionModeSeries;
    series.title = [NSString stringWithFormat:@"Series %u", index+1];
    if (index == 2) {
        series.spline = YES;
    }
    return series;
}

- (NSUInteger)chart:(TKChart *)chart numberOfDataPointsForSeriesAtIndex:(NSUInteger)seriesIndex
{
    return 10;
}

- (id<TKChartData>)chart:(TKChart *)chart dataPointAtIndex:(NSUInteger)dataIndex forSeriesAtIndex:(NSUInteger)seriesIndex
{
    TKChartDataPoint *point = [[TKChartDataPoint alloc] init];
    point.dataXValue = @(dataIndex);
    point.dataYValue = @(arc4random() % 100);
    return point;
}

@end

@implementation BindWithDelegate
{
    TKChart *_chart;
    ChartDataSource *_chartDataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _chartDataSource = [[ChartDataSource alloc] init];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.dataSource = _chartDataSource;
    _chart.legend.hidden = NO;
    _chart.legend.style.position = TKChartLegendPositionTop;
    _chart.legend.container.stack.orientation = TKStackLayoutOrientationHorizontal;
    [self.view addSubview:_chart];
}

@end
