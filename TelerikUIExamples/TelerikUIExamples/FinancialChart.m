//
//  CandlestickChartViewController.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//
#import <TelerikUI/TelerikUI.h>
#import "FinancialChart.h"
#import "StockDataPoint.h"

@implementation FinancialChart
{
    TKChart *financialChart;
    NSArray *_dataPoints;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Candlestick" selector:@selector(reloadChart)];
        [self addOption:@"Ohlc" selector:@selector(reloadChart)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    financialChart = [[TKChart alloc] initWithFrame:CGRectInset(self.view.bounds, 10, 10)];
    financialChart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:financialChart];
    financialChart.gridStyle.verticalLinesHidden = NO;
    financialChart.gridStyle.horizontalLinesHidden = NO;
    
    _dataPoints = [StockDataPoint stockPoints:42];
    
    [self reloadChart];
}

- (void)reloadChart
{
    [financialChart removeAllData];
    
    TKChartSeries *series = nil;
    switch (self.selectedOption) {
        case 0:
            series = [[TKChartCandlestickSeries alloc] initWithItems:_dataPoints];
            break;
        case 1:
            series = [[TKChartOhlcSeries alloc] initWithItems:_dataPoints];
            break;
        default:
            break;
    }
    
    series.selectionMode = TKChartSeriesSelectionModeDataPoint;
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@300 andMaximum:@380];
    yAxis.majorTickInterval = @20;
    financialChart.yAxis = yAxis;
    
    [financialChart addSeries:series];
    
    TKChartDateTimeAxis *xAxis = (TKChartDateTimeAxis *)financialChart.xAxis;
    xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitDays;
    xAxis.style.majorTickStyle.ticksOffset = -3;
    xAxis.style.majorTickStyle.ticksHidden = NO;
    xAxis.style.majorTickStyle.ticksWidth = 1.5;
    xAxis.style.majorTickStyle.ticksFill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0]];
    xAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingModeVisible;

    financialChart.yAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignmentBottom | TKChartAxisLabelAlignmentRight;

    financialChart.xAxis.allowZoom = YES;
    financialChart.xAxis.allowPan = YES;
    financialChart.yAxis.allowZoom = YES;
    financialChart.yAxis.allowPan = YES;
}

@end
