//
//  CrossLineAnnotation.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CrossLineAnnotation.h"
#import <TelerikUI/TelerikUI.h>

@implementation CrossLineAnnotation
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"cross lines" selector:@selector(crossLines)];
        [self addOption:@"horizontal line" selector:@selector(horizontalLine)];
        [self addOption:@"vertical line" selector:@selector(verticalLine)];
        [self addOption:@"disable lines" selector:@selector(disableLines)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    for (int i = 0; i < 2; i++) {
        NSMutableArray *points = [[NSMutableArray alloc] init];
        for (int i = 0; i < 20; i++) {
            [points addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random() % 1450) Y:@(arc4random()%150)]];
        }
        [_chart addSeries:[[TKChartScatterSeries alloc] initWithItems:points]];
    }

    // Add a cross line annotation
    [_chart addAnnotation:[[TKChartCrossLineAnnotation alloc] initWithX:@900 Y:@60 forSeries:_chart.series[0]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Events

- (void)crossLines
{
    TKChartCrossLineAnnotation *a = (TKChartCrossLineAnnotation*)_chart.annotations[0];
    a.style.verticalLineStroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    a.style.horizontalLineStroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    a.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(4, 4)];
    [_chart updateAnnotations];
}

- (void)horizontalLine
{
    TKChartCrossLineAnnotation *a = (TKChartCrossLineAnnotation*)_chart.annotations[0];
    a.style.verticalLineStroke = nil;
    a.style.horizontalLineStroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    a.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(4, 4)];
    [_chart updateAnnotations];
}

- (void)verticalLine
{
    TKChartCrossLineAnnotation *a = (TKChartCrossLineAnnotation*)_chart.annotations[0];
    a.style.verticalLineStroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    a.style.horizontalLineStroke = nil;
    a.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(4, 4)];
    [_chart updateAnnotations];
}

- (void)disableLines
{
    TKChartCrossLineAnnotation *a = (TKChartCrossLineAnnotation*)_chart.annotations[0];
    a.style.verticalLineStroke = nil;
    a.style.horizontalLineStroke = nil;
    a.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeTriangleUp andSize:CGSizeMake(20, 20)];
    [_chart updateAnnotations];
}

@end
