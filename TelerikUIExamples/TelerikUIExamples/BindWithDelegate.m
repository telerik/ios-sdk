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
    TKChartLineSeries *series = index == 2 ? [[TKChartSplineSeries alloc] init]: [[TKChartLineSeries alloc] init];
    series.selectionMode = TKChartSeriesSelectionModeDataPoint;
    series.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(10, 10)];
    series.selectionMode = TKChartSeriesSelectionModeSeries;
    series.title = [NSString stringWithFormat:@"Series %u", (int)index+1];
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
    
    _chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.dataSource = _chartDataSource;
    _chart.legend.hidden = NO;
    _chart.legend.style.position = TKChartLegendPositionTop;
    _chart.legend.container.stack.orientation = TKCoreStackLayoutOrientationHorizontal;
    [self.view addSubview:_chart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
