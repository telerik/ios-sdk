//
//  BandAndLineAnnotations.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "BandAndLineAnnotations.h"
#import <TelerikUI/TelerikUI.h>

@implementation BandAndLineAnnotations
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    for (int i = 0; i < 2; i++) {
        NSMutableArray *points = [[NSMutableArray alloc] init];
        for (int i = 0; i < 20; i++) {
            [points addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random() % 1450) Y:@(arc4random()%150)]];
        }
        [_chart addSeries:[[TKChartScatterSeries alloc] initWithItems:points]];
    }
    
    // Add some gtid line annotations
    [_chart addAnnotation:[[TKChartGridLineAnnotation alloc] initWithValue:@80
                                                                   forAxis:_chart.yAxis
                                                                withStroke:[TKStroke strokeWithColor:[UIColor redColor] width:0.5]]];

    [_chart addAnnotation:[[TKChartGridLineAnnotation alloc] initWithValue:@600 forAxis:_chart.xAxis]];
    
    // Add two band annotations
    UIColor *color = [UIColor colorWithRed:1. green:0. blue:0. alpha:0.4];
    [_chart addAnnotation:[[TKChartBandAnnotation alloc] initWithRange:[[TKRange alloc] initWithMinimum:@10 andMaximum:@40]
                                                               forAxis:_chart.yAxis
                                                              withFill:[TKSolidFill solidFillWithColor:color]
                                                            withStroke:nil]];
    
    TKChartBandAnnotation *a = [[TKChartBandAnnotation alloc] initWithRange:[[TKRange alloc] initWithMinimum:@900 andMaximum:@1500] forAxis:_chart.xAxis];
    a.style.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:0. green:1. blue:0. alpha:0.3]];
    [_chart addAnnotation:a];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
