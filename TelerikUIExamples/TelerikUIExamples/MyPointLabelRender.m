//
//  MyPointLabelRender.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "MyPointLabelRender.h"
#import <TelerikUI/TelerikUI.h>
#import "SelectedPointLabel.h"

@implementation MyPointLabelRender
{
    SelectedPointLabel *_labelLayer;
    BOOL _isSelectedPoint;
}

- (instancetype)initWithRender:(TKChartSeriesRender *)render selectedDataIndex:(NSUInteger)dataIndex selectedSeriesIndex:(NSUInteger)seriesIndex
{
    self = [super initWithRender:render];
    if (self) {
        _selectedDataPoint = dataIndex;
        _selectedSeries = seriesIndex;
    }
    return self;
}

- (void)renderPointLabelsForSeries:(TKChartSeries *)series inRect:(CGRect)bounds context:(CGContextRef)ctx
{
    [_labelLayer removeFromSuperlayer];
    for (int i = 0; i < series.items.count; i++) {
        id<TKChartData> dataPoint = series.items[i];
        CGPoint location = [self locationForDataPoint:dataPoint forSeries:series inRect:bounds];
        if (![self isPoint:location insideRect:bounds]) {
            continue;
        }
        
        TKChartPointLabel *label = [self labelForDataPoint:dataPoint property:@"dataYValue" inSeries:series atIndex:i];
        CGRect labelRect;
        TKChartPointLabelStyle *labelStyle = series.style.pointLabelStyle;
        if (_isSelectedPoint) {
            labelRect = CGRectMake(location.x - 17.5, location.y - 10 - 2.5 * fabs(labelStyle.labelOffset.vertical), 35, 30);
            if (labelRect.origin.y < self.render.bounds.origin.y) {
                _labelLayer.isOutsideBounds = YES;
                labelRect.origin.y = location.y + 10 + 2.5 * fabs(labelStyle.labelOffset.vertical) - labelRect.size.height;
            }
            else {
                _labelLayer.isOutsideBounds = NO;
            }
            
            _labelLayer.frame = labelRect;
            [self.render addSublayer:_labelLayer];
            [_labelLayer setNeedsDisplay];
        }
        else {
            CGSize labelSize = [label sizeThatFits:bounds.size];
            labelRect = CGRectMake(location.x - labelSize.width / 2. + labelStyle.labelOffset.horizontal,
                                   location.y - labelSize.height / 2. + labelStyle.labelOffset.vertical,
                                   labelSize.width, labelSize.height);
            
            if (labelStyle.clipMode == TKChartPointLabelClipModeVisible) {
                if (labelRect.origin.y < self.render.bounds.origin.y) {
                    labelRect.origin.y = location.y - labelSize.height / 2. + fabs(labelStyle.labelOffset.vertical);
                }
            }
            
            [label drawInContext:ctx inRect:labelRect forVisualPoint:nil];
        }
    }
}

- (TKChartPointLabel *)labelForDataPoint:(id<TKChartData>)dataPoint property:(NSString *)propertyName inSeries:(TKChartSeries *)series atIndex:(NSUInteger)dataIndex
{
    if (series.index == _selectedSeries && dataIndex == _selectedDataPoint) {
        
        if (!_labelLayer) {
            _labelLayer = [[SelectedPointLabel alloc] init];
        }
        
        _labelLayer.labelStyle = series.style.pointLabelStyle;
        _labelLayer.text = [NSString stringWithFormat:@"%@", dataPoint.dataYValue];
        _isSelectedPoint = YES;
        return nil;
    }
    
    _isSelectedPoint = NO;
    return [[TKChartPointLabel alloc] initWithPoint:dataPoint series:series text:[NSString stringWithFormat:@"%@", dataPoint.dataYValue]];
}

@end
