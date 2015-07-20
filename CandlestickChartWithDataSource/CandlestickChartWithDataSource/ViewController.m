//
//  ViewController.m
//  CandlestickChartWithDataSource
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "ViewController.h"
#import <TelerikUI/TelerikUI.h>

@interface ViewController ()

@end

@implementation ViewController
{
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    TKChart *chart = [[TKChart alloc] initWithFrame:CGRectInset(self.view.bounds, 20, 20) ];
    chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:chart];
    
    TKDataSource *dataSource = [TKDataSource new];
    NSString *url = @"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20%20%20yahoo.finance.historicaldata%20%20%20%20%20%20%20%20%20where%20%20symbol%20%20%20%20=%20%22PRGS%22%20%20%20%20%20%20%20%20%20and%20%20%20%20startDate%20=%20%222015-03-10%22%20%20%20%20%20%20%20%20%20and%20%20%20%20endDate%20%20%20=%20%222015-03-20%22&format=json&diagnostics=true&env=store://datatables.org/alltableswithkeys&callback=";
    [dataSource loadDataFromURL:url dataFormat:TKDataSourceDataFormatJSON rootItemKeyPath:@"query.results.quote" completion:^(NSError *error) {
        
        if (error) {
            NSLog(@"Can't connect with the server");
            return;
        }
        
        [dataSource.settings.chart createSeries:^TKChartSeries *(TKDataSourceGroup *group) {
            TKChartCandlestickSeries *series = [TKChartCandlestickSeries new];
            return series;
        }];
        
        [dataSource map:^id(id item) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormatter dateFromString: [item valueForKey:@"Date"]];
            [item setValue:date forKey:@"Date"];
            return item;
        }];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        [dataSource.settings.chart createPoint:^id<TKChartData>(NSInteger seriesIndex, NSInteger dataIndex, id item) {
            TKChartFinancialDataPoint *point = [[TKChartFinancialDataPoint alloc] initWithX:[item valueForKey:@"Date"] open:[formatter numberFromString:[item valueForKey:@"Open"]]  high:[formatter numberFromString:[item valueForKey:@"High"]]  low:[formatter numberFromString:[item valueForKey:@"Low"]]  close:[formatter numberFromString:[item valueForKey:@"Close"]]  volume:[formatter numberFromString:[item valueForKey:@"Volume"]]];
            return point;
        }];
        
        chart.dataSource = dataSource;
        
        TKChartDateTimeAxis *xAxis = [TKChartDateTimeAxis new];
        xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitDays;
        xAxis.plotMode = TKChartAxisPlotModeBetweenTicks;
        xAxis.majorTickInterval = 2;
        chart.xAxis = xAxis;
        
        TKChartNumericAxis *yAxis = (TKChartNumericAxis *)chart.yAxis;
        yAxis.range.minimum = @25;
        yAxis.majorTickInterval = @1;
    }];
}
@end
