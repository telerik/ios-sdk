//
//  CustomAnimationPieChart.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "CustomAnimationPieChart.h"
#import <TelerikUI/TelerikUI.h>

@interface CustomAnimationPieChart() <TKChartDelegate>
@end

@implementation CustomAnimationPieChart
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Animate" selector:@selector(animate)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.allowAnimations = YES;
    _chart.delegate = self;
    [self.view addSubview:_chart];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@10 name:@"Apple" ]];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@20 name:@"Google" ]];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@30 name:@"Microsoft" ]];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@5 name:@"IBM" ]];
    [array addObject:[[TKChartDataPoint alloc] initWithValue:@8 name:@"Oracle" ]];
    
    TKChartPieSeries *series = [[TKChartPieSeries alloc] init];
    series.selectionMode = TKChartSeriesSelectionModeDataPoint;
    [_chart addSeries:series withItems:array];
}

- (void)animate
{
    [_chart animate];
}

#pragma mark TKChartDelegate

- (CAAnimation *)chart:(TKChart *)chart animationForSeries:(TKChartSeries *)series withState:(TKChartSeriesRenderState *)state inRect:(CGRect)rect
{
    CFTimeInterval duration = 0;
    NSMutableArray *animations = [[NSMutableArray alloc] init];
    for (int i = 0; i<state.points.count; i++) {
        NSString *pointKeyPath = [state animationKeyPathForPointAtIndex:i];
        
        NSString *keyPath = [NSString stringWithFormat:@"%@.distanceFromCenter", pointKeyPath];
        CAKeyframeAnimation *a = [CAKeyframeAnimation animationWithKeyPath:keyPath];
        a.values = @[ @50, @50, @0 ];
        a.keyTimes = @[ @0, @(i/(i+1.)), @1 ];
        a.duration = 0.3 * (i+1.1);
        [animations addObject:a];
        
        keyPath = [NSString stringWithFormat:@"%@.opacity", pointKeyPath];
        a = [CAKeyframeAnimation animationWithKeyPath:keyPath];
        a.values = @[ @0, @0, @1 ];
        a.keyTimes = @[ @0, @(i/(i+1.)), @1 ];
        a.duration = 0.3 * (i+1.1);
        [animations addObject:a];
        
        duration = a.duration;
    }
    CAAnimationGroup *g = [[CAAnimationGroup alloc] init];
    g.duration = duration;
    g.animations = animations;
    return g;
}

@end
