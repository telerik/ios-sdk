//
//  MyPointLabelRender.h
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import <TelerikUI/TKChartPointLabelRender.h>

@interface MyPointLabelRender : TKChartPointLabelRender

- (id)initWithRender:(TKChartSeriesRender *)render selectedDataIndex:(NSUInteger)dataIndex selectedSeriesIndex:(NSUInteger)seriesIndex;

@property (nonatomic) NSUInteger selectedSeries;

@property (nonatomic) NSUInteger selectedDataPoint;

@end
