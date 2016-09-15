//
//  ChartDocsLegend.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsLegend.h"


@implementation ChartDocsLegend
{
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    chart.delegate = self;
    
    NSMutableArray *pointsWithValueAndName = [[NSMutableArray alloc] init];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Google" value:@20]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Apple" value:@30]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Microsoft" value:@10]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"IBM" value:@5]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Oracle" value:@8]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"Blackberry" value:@10]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"SAP" value:@5]];
    [pointsWithValueAndName addObject:[[TKChartDataPoint alloc] initWithName:@"SalesForce" value:@8]];
    
    TKChartDonutSeries *series = [[TKChartDonutSeries alloc] initWithItems:pointsWithValueAndName];
    series.innerRadius = 0.3;
    [chart addSeries:series];
    
    chart.legend.style.position = TKChartLegendPositionBottom;
    chart.legend.hidden = NO;
}

- (void)chart:(TKChart *)chart updateLegendItem:(TKChartLegendItem *)item forSeries:(TKChartSeries *)series atIndex:(NSUInteger)index
{
    UIImage *image = [UIImage imageNamed:[item.label.text stringByAppendingString:@".png"]];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    [item.icon addSubview:imgView];
}

- (void)customizeChartsLegend
{
    chart.legend.hidden = NO;
    chart.legend.style.position = TKChartLegendPositionBottom;
    // >> chart-legend-offset-pos
    chart.legend.style.position = TKChartLegendPositionFloating;
    chart.legend.style.offsetOrigin = TKChartLegendOffsetOriginTopLeft;
    chart.legend.style.offset = UIOffsetMake(10, 10);
    // << chart-legend-offset-pos
    
    // >> chart-legend-title
    chart.legend.titleLabel.text = @"Companies";
    chart.legend.showTitle = YES;
    // << chart-legend-title
}

- (void)createLegendView
{
    
    chart.title.text = @"Market Share";
    // >> chart-legend-outside
    TKChartLegendView *legendView = [[TKChartLegendView alloc] initWithChart:chart];
    legendView.frame = CGRectMake(20, 20, 320, 100);
    [self.view addSubview:legendView];
    [legendView reloadItems];
    // << chart-legend-outside
}

@end
