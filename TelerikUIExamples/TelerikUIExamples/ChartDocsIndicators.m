//
//  ChartDocsIndicators.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsIndicators.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsIndicators
{
    NSMutableArray *financialDataPoints;
    TKChart *financialChart;
    TKChart *chart;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    financialChart = [[TKChart alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:financialChart];
    
    NSArray *openPrices = @[@100, @125, @69, @99, @140, @125, @100, @125, @69, @99, @140, @125, @100, @125, @69, @99, @140,
                            @125, @100, @125, @69, @99, @140, @125, @100, @125, @69, @99, @140, @125, @100, @125, @69, @99, @140, @125];
    NSArray *closePrices = @[@85, @65, @135, @120, @80, @136, @85, @65, @135, @120, @80, @136, @85, @65, @135, @120, @80,
                             @136, @85, @65, @135, @120, @80, @136, @85, @65, @135, @120, @80, @136, @85, @65, @135, @120, @80, @136];
    NSArray *lowPrices = @[@50, @60, @65, @55, @75, @90, @50, @60, @65, @55, @75, @90, @50, @60, @65, @55, @75, @90,
                           @50, @60, @65, @55, @25, @90, @50, @60, @65, @55, @75, @90, @50, @60, @65, @55, @75, @90];
    NSArray *highPrices = @[@129, @142, @141, @123, @150, @161, @129, @142,@141, @123, @150, @161,@129, @142, @141, @123,
                            @150, @161, @129, @142, @141, @123, @150, @161, @129, @142, @141, @123, @150, @161, @129, @142, @141, @123, @150, @161];
    NSDate *dateNow = [NSDate date];
    financialDataPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i < openPrices.count; i++) {
        NSDate *date = [dateNow dateByAddingTimeInterval:60 * 60 * 24 * i];
        TKChartFinancialDataPoint *dataPoint = [TKChartFinancialDataPoint dataPointWithX:date open:openPrices[i] high:highPrices[i] low:lowPrices[i] close:closePrices[i]];
        [financialDataPoints addObject:dataPoint];
    }
}

- (void)bollingerBands
{
    // >> chart-indicators-bollinger
    TKChartCandlestickSeries *candlesticks = [[TKChartCandlestickSeries alloc] initWithItems:financialDataPoints];
    TKChartBollingerBandIndicator *bollingerBands = [[TKChartBollingerBandIndicator alloc] initWithSeries:candlesticks];
    [financialChart addSeries:candlesticks];
    [financialChart addSeries:bollingerBands];
    // << chart-indicators-bollinger
    TKChartDateTimeAxis *xAxis = (TKChartDateTimeAxis *)financialChart.xAxis;
    xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitDays;
    
}

- (void)macdIndicator
{
    // >> chart-indicators-technical
    TKChartCandlestickSeries *candlesticks = [[TKChartCandlestickSeries alloc] initWithItems:financialDataPoints];
    TKChartMACDIndicator *macdIndicator = [[TKChartMACDIndicator alloc] initWithSeries:candlesticks];
    macdIndicator.longPeriod = 26;
    macdIndicator.shortPeriod = 12;
    macdIndicator.signalPeriod = 9;
    [financialChart addSeries:macdIndicator];
    // << chart-indicators-technical
    TKChartDateTimeAxis *xAxis = (TKChartDateTimeAxis *)financialChart.xAxis;
    xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitDays;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
