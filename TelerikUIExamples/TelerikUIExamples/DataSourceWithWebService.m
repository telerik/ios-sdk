//
//  DataSourceWithWebService.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DataSourceWithWebService.h"
#import <TelerikUI/TelerikUI.h>

@interface DataSourceWithWebService ()

@property (nonatomic, strong) TKDataSource *dataSource;

@end

@implementation DataSourceWithWebService

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Consume web service";
    
    self.dataSource = [TKDataSource new];
    
    // >> remote-data
    TKChart *chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:chart];

    NSString *url = @"http://www.telerik.com/docs/default-source/ui-for-ios/weather.json?sfvrsn=2";
    [self.dataSource loadDataFromURL:url dataFormat:TKDataSourceDataFormatJSON rootItemKeyPath:@"dayList" completion:^(NSError *error) {
        
        if (error) {
            NSLog(@"Can't connect with the server");
            return;
        }
        
        [self.dataSource.settings.chart createSeries:^TKChartSeries *(TKDataSourceGroup *group) {
            TKChartSeries *series = nil;
            if ([group.valueKey isEqualToString:@"clouds"]) {
                series = [TKChartColumnSeries new];
                series.yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@0 andMaximum:@100];
                series.yAxis.title = @"clouds";
                series.yAxis.style.titleStyle.rotationAngle = M_PI_2;
            }
            else {
                series = [TKChartLineSeries new];
                series.yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@-10 andMaximum:@30];
                if ([group.valueKey isEqualToString:@"temp.min"]) {
                    series.yAxis.position = TKChartAxisPositionRight;
                    series.yAxis.title = @"temperature";
                    series.yAxis.style.titleStyle.rotationAngle = M_PI_2;
                    [chart addAxis:series.yAxis];
                }
            }
            return series;
        }];
        
        [self.dataSource map:^id(id item) {
            NSTimeInterval interval = [[item valueForKey:@"dateTime"] doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
            [item setValue:date forKey:@"dateTime"];
            return item;
        }];
        
        self.dataSource.valueKey = @"humidity";
        
        NSArray *items = self.dataSource.items;
        self.dataSource.itemSource = @[ [[TKDataSourceGroup alloc] initWithItems:items valueKey:@"clouds" displayKey:@"dateTime"],
                                        [[TKDataSourceGroup alloc] initWithItems:items valueKey:@"temp.min" displayKey:@"dateTime"],
                                        [[TKDataSourceGroup alloc] initWithItems:items valueKey:@"temp.max" displayKey:@"dateTime"] ];
        chart.dataSource = self.dataSource;
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"dd";
        TKChartDateTimeAxis *xAxis = (TKChartDateTimeAxis*)chart.xAxis;
        xAxis.majorTickInterval = 1;
        xAxis.plotMode = TKChartAxisPlotModeBetweenTicks;
        xAxis.labelFormatter = formatter;
        xAxis.title = @"date";
        xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitDays;
    }];
    // << remote-data
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
