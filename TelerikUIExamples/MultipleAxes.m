//
//  MultipleAxes.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "MultipleAxes.h"
#import <TelerikUI/TelerikUI.h>

@implementation MultipleAxes
{
    TKChart *_chart;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];

    TKChartNumericAxis *gdpInPoundsYAxis = [[TKChartNumericAxis alloc] initWithMinimum:@1050 andMaximum:@1400];
    gdpInPoundsYAxis.majorTickInterval = @50;
    gdpInPoundsYAxis.position = TKChartAxisPositionLeft;
    gdpInPoundsYAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignmentLeft;
    gdpInPoundsYAxis.style.majorTickStyle.ticksHidden = NO;
    gdpInPoundsYAxis.style.lineHidden = NO;
    [_chart addAxis:gdpInPoundsYAxis];
    _chart.yAxis = gdpInPoundsYAxis;
    
    TKChartDateTimeAxis *periodXAxis = [[TKChartDateTimeAxis alloc] init];
    periodXAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitYears;
    periodXAxis.position = TKChartAxisPositionBottom;
    periodXAxis.plotMode = TKChartAxisPlotModeBetweenTicks;
    [_chart addAxis:periodXAxis];
     
    TKChartNumericAxis *gdpInvestmentYAxis = [[TKChartNumericAxis alloc] initWithMinimum:@0 andMaximum:@20];
    gdpInvestmentYAxis.majorTickInterval = @5;
    gdpInvestmentYAxis.position = TKChartAxisPositionRight;
    gdpInvestmentYAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignmentLeft;
    gdpInvestmentYAxis.style.majorTickStyle.ticksHidden = NO;
    gdpInvestmentYAxis.style.lineHidden = NO;
    [_chart addAxis:gdpInvestmentYAxis];
    
    TKChartNumericAxis *gdpGrowthUpAnnualChangeYAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(-6) andMaximum:@4];
    gdpGrowthUpAnnualChangeYAxis.majorTickInterval = @1;
    gdpGrowthUpAnnualChangeYAxis.position = TKChartAxisPositionRight;
    gdpGrowthUpAnnualChangeYAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignmentLeft;
    gdpGrowthUpAnnualChangeYAxis.style.majorTickStyle.ticksHidden = NO;
    gdpGrowthUpAnnualChangeYAxis.style.lineHidden = NO;
    [_chart addAxis:gdpGrowthUpAnnualChangeYAxis];
    
    TKChartNumericAxis *grossNationalSavingsAnnualGrowthUpYAxis = [[TKChartNumericAxis alloc] initWithMinimum:@0 andMaximum:@16];
    grossNationalSavingsAnnualGrowthUpYAxis.majorTickInterval = @2;
    grossNationalSavingsAnnualGrowthUpYAxis.position = TKChartAxisPositionRight;
    grossNationalSavingsAnnualGrowthUpYAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignmentLeft;
    grossNationalSavingsAnnualGrowthUpYAxis.style.majorTickStyle.ticksHidden = NO;
    grossNationalSavingsAnnualGrowthUpYAxis.style.lineHidden = NO;
    [_chart addAxis:grossNationalSavingsAnnualGrowthUpYAxis];
    
    NSDate *date2001 = [MultipleAxes dateWithYear:2001 month:12 day:31];
    NSDate *date2002 = [MultipleAxes dateWithYear:2002 month:12 day:31];
    NSDate *date2003 = [MultipleAxes dateWithYear:2003 month:12 day:31];
    NSDate *date2004 = [MultipleAxes dateWithYear:2004 month:12 day:31];
    NSDate *date2005 = [MultipleAxes dateWithYear:2005 month:12 day:31];
    
    NSArray *gdpInPounds = @[[[TKChartDataPoint alloc] initWithX:date2001 Y:@1200],
                             [[TKChartDataPoint alloc] initWithX:date2002 Y:@1200],
                             [[TKChartDataPoint alloc] initWithX:date2003 Y:@1225],
                             [[TKChartDataPoint alloc] initWithX:date2004 Y:@1300],
                             [[TKChartDataPoint alloc] initWithX:date2005 Y:@1350]];
    
    TKChartColumnSeries *gdpInPoundsSeries = [[TKChartColumnSeries alloc] initWithItems:gdpInPounds];
    gdpInPoundsSeries.xAxis = periodXAxis;
    gdpInPoundsSeries.yAxis = gdpInPoundsYAxis;
    gdpInPoundsSeries.selectionMode = TKChartSeriesSelectionModeSeries;
    [_chart addSeries:gdpInPoundsSeries];
    
    NSArray *gdpGrowthUpAnnual = @[[[TKChartDataPoint alloc] initWithX:date2001 Y:@4],
                                   [[TKChartDataPoint alloc] initWithX:date2002 Y:@3],
                                   [[TKChartDataPoint alloc] initWithX:date2003 Y:@2],
                                   [[TKChartDataPoint alloc] initWithX:date2004 Y:@(-5)],
                                   [[TKChartDataPoint alloc] initWithX:date2005 Y:@1]];
    
    CGFloat shapeSize = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 7 : 17;
    
    TKChartLineSeries *gdpGrowthUpSeries = [[TKChartLineSeries alloc] initWithItems:gdpGrowthUpAnnual];
    gdpGrowthUpSeries.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(shapeSize, shapeSize)];
    gdpGrowthUpSeries.xAxis = periodXAxis;
    gdpGrowthUpSeries.yAxis = gdpGrowthUpAnnualChangeYAxis;
    gdpGrowthUpSeries.selectionMode = TKChartSeriesSelectionModeDataPoint;
    gdpGrowthUpSeries.style.shapeMode = TKChartSeriesStyleShapeModeAlwaysShow;
    
    [_chart addSeries:gdpGrowthUpSeries];
    
    NSArray *grossAnualSavings = @[[[TKChartDataPoint alloc] initWithX:date2001 Y:@14],
                                   [[TKChartDataPoint alloc] initWithX:date2002 Y:@8],
                                   [[TKChartDataPoint alloc] initWithX:date2003 Y:@12],
                                   [[TKChartDataPoint alloc] initWithX:date2004 Y:@11],
                                   [[TKChartDataPoint alloc] initWithX:date2005 Y:@16]];
    
    TKChartLineSeries *grossAnualSavingsSeries = [[TKChartLineSeries alloc] initWithItems:grossAnualSavings];
    grossAnualSavingsSeries.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(shapeSize, shapeSize)];
    grossAnualSavingsSeries.xAxis = periodXAxis;
    grossAnualSavingsSeries.yAxis = grossNationalSavingsAnnualGrowthUpYAxis;
    grossAnualSavingsSeries.selectionMode = TKChartSeriesSelectionModeDataPoint;
    grossAnualSavingsSeries.style.shapeMode = TKChartSeriesStyleShapeModeAlwaysShow;
    [_chart addSeries:grossAnualSavingsSeries];
    
    
    NSArray *gdpInvestment = @[[[TKChartDataPoint alloc] initWithX:date2001 Y:@15],
                               [[TKChartDataPoint alloc] initWithX:date2002 Y:@13],
                               [[TKChartDataPoint alloc] initWithX:date2003 Y:@16],
                               [[TKChartDataPoint alloc] initWithX:date2004 Y:@19],
                               [[TKChartDataPoint alloc] initWithX:date2005 Y:@15]];
    
    TKChartLineSeries *gdpInvestmentSeries = [[TKChartLineSeries alloc] initWithItems:gdpInvestment];
    gdpInvestmentSeries.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(shapeSize, shapeSize)];
    gdpInvestmentSeries.xAxis = periodXAxis;
    gdpInvestmentSeries.yAxis = gdpInvestmentYAxis;
    gdpInvestmentSeries.selectionMode = TKChartSeriesSelectionModeDataPoint;
    gdpInvestmentSeries.style.shapeMode = TKChartSeriesStyleShapeModeAlwaysShow;
    [_chart addSeries:gdpInvestmentSeries];
    
    [self setStyles: gdpInPoundsSeries];
    [self setStyles: grossAnualSavingsSeries];
    [self setStyles: gdpGrowthUpSeries];
    [self setStyles: gdpInvestmentSeries];
    
    [_chart reloadData];
}
    
- (void)setStyles:(TKChartSeries*)series
{
    TKChartPaletteItem *item = [series.style.palette paletteItemAtIndex:series.index];
    
    if([series isKindOfClass:[TKChartColumnSeries class]] && item.drawables.count > 1) {
        id<TKDrawing> drawable = item.drawables[2];
        
        if([drawable isKindOfClass:[TKStroke class]]) {
            TKStroke *stroke = (TKStroke*)drawable;
            series.yAxis.style.lineStroke = [TKStroke strokeWithFill: stroke.fill];
        }
        else {
            series.yAxis.style.lineStroke = [TKStroke strokeWithFill: item.stroke.fill];
        }
    }
    else {
        series.yAxis.style.lineStroke = [TKStroke strokeWithFill: item.stroke.fill];
    }
    
    series.yAxis.style.majorTickStyle.ticksFill = series.yAxis.style.lineStroke.fill;
    series.yAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingModeVisible;
    series.yAxis.style.majorTickStyle.minTickClippingMode = TKChartAxisClippingModeVisible;
    
    if([series.yAxis.style.majorTickStyle.ticksFill isKindOfClass:[TKSolidFill class]]) {
        TKSolidFill *solidFill = (TKSolidFill*)series.yAxis.style.majorTickStyle.ticksFill;
        series.yAxis.style.labelStyle.textColor = solidFill.color;
    }
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

@end
