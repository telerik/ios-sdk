//
//  DateTimeCategoryAxis.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "DateTimeCategoryAxis.h"
#import "StockDataPoint.h"

@interface DateTimeCategoryAxis ()
@end

@implementation DateTimeCategoryAxis

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TKChart *chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:chart];
    
    
    TKChartDateTimeCategoryAxis *xAxis = [TKChartDateTimeCategoryAxis new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"d MMM";
    xAxis.labelFormatter = formatter;
    xAxis.style.majorTickStyle.ticksOffset = -3;
    xAxis.style.majorTickStyle.ticksHidden = NO;
    xAxis.style.majorTickStyle.ticksWidth = 1.5;
    xAxis.style.majorTickStyle.ticksFill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0]];
    xAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingModeVisible;
    xAxis.plotMode = TKChartAxisPlotModeBetweenTicks;
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@320 andMaximum:@360];
    yAxis.majorTickInterval = @20;
    
    TKChartCandlestickSeries *series = [[TKChartCandlestickSeries alloc] initWithItems:[StockDataPoint stockPoints:10]];
    series.gapLength = 0.6;
    series.xAxis = xAxis;
    chart.yAxis = yAxis;

    [chart addSeries:series];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
