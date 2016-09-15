//
//  CustomPointLabelRender.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CustomPointLabelRender.h"
#import "MyPointLabelRender.h"

@implementation CustomPointLabelRender
{
    TKChart *_chart;
    NSUInteger _selectedSeriesIndex;
    NSUInteger _selectedDataPointIndex;
    MyPointLabelRender *_labelRender;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.delegate = self;
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    _selectedSeriesIndex = 0;
    _selectedDataPointIndex = 3;
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        TKChartDataPoint *point = [TKChartDataPoint dataPointWithX:@(i) Y:@(arc4random() % 100)];
        [dataPoints addObject:point];
    }
    
    TKChartColumnSeries *columnSeries = [[TKChartColumnSeries alloc] initWithItems:dataPoints];
    columnSeries.selection = TKChartSeriesSelectionDataPoint;

    columnSeries.style.pointLabelStyle.textHidden = NO;
    columnSeries.style.pointLabelStyle.layoutMode = TKChartPointLabelLayoutModeManual;
    columnSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -10);
    columnSeries.style.pointLabelStyle.insets = UIEdgeInsetsMake(-1, -5, -1, -5);
    columnSeries.style.pointLabelStyle.font = [UIFont systemFontOfSize:10];
    columnSeries.style.pointLabelStyle.textAlignment = NSTextAlignmentCenter;
    columnSeries.style.pointLabelStyle.clipMode = TKChartPointLabelClipModeVisible;
    columnSeries.style.pointLabelStyle.textColor = [UIColor whiteColor];
    columnSeries.style.pointLabelStyle.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:108/255.0 green:181/255.0 blue:250/255.0 alpha:1.0]];

    [_chart addSeries:columnSeries];
    [_chart select:[[TKChartSelectionInfo alloc] initWithSeries:_chart.series[_selectedSeriesIndex] dataPointIndex:_selectedDataPointIndex]];
}

- (TKChartPointLabelRender *)chart:(TKChart *)chart pointLabelRenderForSeries:(TKChartSeries *)series withRender:(TKChartSeriesRender *)render
{
    if (!_labelRender) {
        _labelRender = [[MyPointLabelRender alloc] initWithRender:render selectedDataIndex:_selectedDataPointIndex selectedSeriesIndex:_selectedSeriesIndex];
    }
    
    if (series.index == 0) {
        return _labelRender;
    }
    
    return nil;
}

- (void)chart:(TKChart *)chart didSelectPoint:(id<TKChartData>)point inSeries:(TKChartSeries *)series atIndex:(NSInteger)index
{
    _labelRender.selectedSeries = series.index;
    _labelRender.selectedDataPoint = index;
}

- (void)chart:(TKChart *)chart didDeselectPoint:(id<TKChartData>)point inSeries:(TKChartSeries *)series atIndex:(NSInteger)index
{
    _labelRender.selectedSeries = -1;
    _labelRender.selectedDataPoint = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
