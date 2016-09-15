//
//  PieChartAnnotations.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "PieChartAnnotations.h"
#import <TelerikUI/TelerikUI.h>

@interface PieChartAnnotations ()

@property (nonatomic, weak) TKChart *pieChart;

@end

@implementation PieChartAnnotations

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TKChart *pieChart = [[TKChart alloc] initWithFrame:self.view.bounds];
    pieChart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    pieChart.allowAnimations = YES;
    [self.view addSubview:pieChart];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Auto &\nTransport" value:@25.0]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Food &\nDining" value:@25.0]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Fees &\nCharges" value:@25.0]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Business\nServices" value:@12.5]];
    [array addObject:[[TKChartDataPoint alloc] initWithName:@"Personal\nCare" value:@12.5]];
    
    TKChartPieSeries *series = [[TKChartPieSeries alloc] initWithItems:array];
    series.selection = TKChartSeriesSelectionDataPoint;
    series.expandRadius = 1.04;
    series.rotationAngle = -(M_PI_2 + M_PI_4);
    series.radiusInset = 50;
    series.labelDisplayMode = TKChartPieSeriesLabelDisplayModeInside;
    series.style.pointLabelStyle.textHidden = NO;
    series.style.pointLabelStyle.stringFormat = @"%.0f%%";
    series.style.pointLabelStyle.textColor = [UIColor whiteColor];
    [pieChart addSeries:series];
    
    for (TKChartDataPoint *pt in series.items) {
        TKChartBalloonAnnotation *annotation = [[TKChartBalloonAnnotation alloc] initWithText:[pt dataName] point:pt forSeries:series];
        annotation.style.fill = nil;
        annotation.style.stroke = nil;
        annotation.style.distanceFromPoint = 0;
        annotation.style.textColor = [UIColor grayColor];
        [pieChart addAnnotation:annotation];
    }
    
    self.pieChart = pieChart;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieChart select:[[TKChartSelectionInfo alloc] initWithSeries:self.pieChart.series[0] dataPointIndex:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
