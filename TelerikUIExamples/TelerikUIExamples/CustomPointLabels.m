//
//  CustomPointLabels.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CustomPointLabels.h"
#import "MyPointLabel.h"

@implementation CustomPointLabels
{
    TKChart *_chart;
    NSUInteger _selectedSeriesIndex;
    NSUInteger _selectedDataPointIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _chart = [[TKChart alloc] initWithFrame:self.exampleBounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.delegate = self;
    [self.view addSubview:_chart];
    
    _selectedSeriesIndex = 0;
    _selectedDataPointIndex = 3;
    
    NSArray *values = @[@58, @59, @61, @64, @66, @69, @72, @72, @69];
    NSArray *values1 = @[@42, @44, @47, @51, @56, @61, @62, @64, @62];
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    NSMutableArray *dataPoints1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < values.count; i++) {
        TKChartDataPoint *point = [TKChartDataPoint dataPointWithX:@(i) Y:values[i]];
        TKChartDataPoint *point1 = [TKChartDataPoint dataPointWithX:@(i) Y:values1[i]];
        [dataPoints addObject:point];
        [dataPoints1 addObject:point1];
    }
    
    TKChartLineSeries *lineSeries = [[TKChartLineSeries alloc] initWithItems:dataPoints];
    lineSeries.selectionMode = TKChartSeriesSelectionModeDataPoint;
    lineSeries.style.pointShape = [TKPredefinedShape shapeWithType:TKShapeTypeCircle andSize:CGSizeMake(8, 8)];
    lineSeries.style.pointLabelStyle.textHidden = NO;
    lineSeries.style.pointLabelStyle.layoutMode = TKChartPointLabelLayoutModeManual;
    lineSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -24);
    lineSeries.style.pointLabelStyle.insets = UIEdgeInsetsMake(-1, -5, -1, -5);
    lineSeries.style.pointLabelStyle.font = [UIFont systemFontOfSize:10];
    lineSeries.style.pointLabelStyle.textAlignment = NSTextAlignmentCenter;
    lineSeries.style.pointLabelStyle.textColor = [UIColor whiteColor];
    lineSeries.style.pointLabelStyle.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:108/255.0 green:181/255.0 blue:250/255.0 alpha:1.0]];
    lineSeries.style.pointLabelStyle.clipMode = TKChartPointLabelClipModeHidden;
    
    TKChartLineSeries *lineSeries1 = [[TKChartLineSeries alloc] initWithItems:dataPoints1];
    lineSeries1.selectionMode = TKChartSeriesSelectionModeDataPoint;
    lineSeries1.style.pointShape = [TKPredefinedShape shapeWithType:TKShapeTypeCircle andSize:CGSizeMake(8, 8)];
    lineSeries1.style.pointLabelStyle.textHidden = NO;
    lineSeries1.style.pointLabelStyle.layoutMode = TKChartPointLabelLayoutModeManual;
    lineSeries1.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -24);
    lineSeries1.style.pointLabelStyle.insets = UIEdgeInsetsMake(-1, -5, -1, -5);
    lineSeries1.style.pointLabelStyle.font = [UIFont systemFontOfSize:10];
    lineSeries1.style.pointLabelStyle.textAlignment = NSTextAlignmentCenter;
    lineSeries1.style.pointLabelStyle.textColor = [UIColor whiteColor];
    lineSeries1.style.pointLabelStyle.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:241/255.0 green:140/255.0 blue:133/255.0 alpha:1.0]];
    lineSeries1.style.pointLabelStyle.clipMode = TKChartPointLabelClipModeHidden;
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@40 andMaximum:@80];
    yAxis.majorTickInterval = @10;
    _chart.yAxis = yAxis;

    [_chart addSeries:lineSeries];
    [_chart addSeries:lineSeries1];
}

- (TKChartPointLabel *)chart:(TKChart *)chart labelForDataPoint:(id<TKChartData>)dataPoint inSeries:(TKChartSeries *)series atIndex:(NSUInteger)dataIndex
{
    if (series.index == _selectedSeriesIndex && dataIndex == _selectedDataPointIndex) {
        return [[MyPointLabel alloc] initWithPoint:dataPoint style:series.style.pointLabelStyle text:[NSString stringWithFormat:@"%@", dataPoint.dataYValue]];
    }
    
    return [[TKChartPointLabel alloc] initWithPoint:dataPoint style:series.style.pointLabelStyle text:[NSString stringWithFormat:@"%@", dataPoint.dataYValue]];
}

- (TKChartPaletteItem *)chart:(TKChart *)chart paletteItemForPoint:(NSUInteger)index inSeries:(TKChartSeries *)series
{
    if (series.index == _selectedSeriesIndex && index == _selectedDataPointIndex) {
        return [[TKChartPaletteItem alloc] initWithStroke:
                [TKStroke strokeWithColor:[UIColor blackColor] width:2.] andFill:[TKSolidFill solidFillWithColor:[UIColor whiteColor]]];
    }
    
    if (series.index == 0) {
        return [TKChartPaletteItem paletteItemWithFill:
                [TKSolidFill solidFillWithColor:[UIColor colorWithRed:108/255.0 green:181/255.0 blue:250/255.0 alpha:1.0]]];
    }
    
    return [[TKChartPaletteItem alloc] initWithFill:
            [TKSolidFill solidFillWithColor:[UIColor colorWithRed:241/255.0 green:140/255.0 blue:133/255.0 alpha:1.0]]];
}

- (void)chart:(TKChart *)chart didSelectPoint:(id<TKChartData>)point inSeries:(TKChartSeries *)series atIndex:(NSInteger)index
{
    _selectedSeriesIndex = series.index;
    _selectedDataPointIndex = index;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
