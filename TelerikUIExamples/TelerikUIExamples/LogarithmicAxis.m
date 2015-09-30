//
//  LogarithmicAxis.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "LogarithmicAxis.h"
#import <TelerikUI/TelerikUI.h>

@implementation LogarithmicAxis

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TKChart *chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    chart.legend.hidden = NO;
    [self.view addSubview:chart];
    
    TKDataSource *dataSource = [[TKDataSource alloc] initWithDataFromJSONResource:@"electricity" ofType:@"json" rootItemKeyPath:@"data"];
    [dataSource sortWithKey:@"year" ascending:YES];

    dataSource.itemSource = @[ [[TKDataSourceGroup alloc] initWithItems:dataSource.items valueKey:@"nuclear" displayKey:@"year"],
                               [[TKDataSourceGroup alloc] initWithItems:dataSource.items valueKey:@"hydro" displayKey:@"year"],
                               [[TKDataSourceGroup alloc] initWithItems:dataSource.items valueKey:@"solar" displayKey:@"year"],
                             ];

    NSArray *colors = @[ [UIColor colorWithRed:0.318f green:0.384f blue:0.737f alpha:1.00f],
                         [UIColor colorWithRed:0.039f green:0.631f blue:0.933f alpha:1.00f],
                         [UIColor colorWithRed:0.271f green:0.678f blue:0.373f alpha:1.00f],
                       ];
    
    [dataSource.settings.chart createSeries:^TKChartSeries *(TKDataSourceGroup *group) {
        TKChartAreaSeries *series = [TKChartAreaSeries new];
        series.title = [group.valueKey capitalizedString];
        series.style.fill = [TKSolidFill solidFillWithColor:colors[[dataSource.items indexOfObject:group]]];
        return series;
    }];
    
    chart.yAxis = [TKChartLogarithmicAxis new];
    chart.dataSource = dataSource;
}

@end
