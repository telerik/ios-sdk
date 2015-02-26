//
//  CustomAnimationAreaChart.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "CustomAnimationAreaChart.h"
#import <TelerikUI/TelerikUI.h>

@interface CustomAnimationAreaChart ()

@end

@implementation CustomAnimationAreaChart
{
    TKChart *_chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.allowAnimations = YES;
    _chart.delegate = self;
    [self.view addSubview:_chart];
    
    NSMutableArray *points = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++) {
        [points addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random() % 100)]];
    }
    
    TKChartAreaSeries *areaSeries = [[TKChartAreaSeries alloc] initWithItems:points];
    areaSeries.selectionMode = TKChartSeriesSelectionModeSeries;
    [_chart addSeries:areaSeries];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
     [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(deviceOrientationDidChange:)
                                                  name:UIDeviceOrientationDidChangeNotification
                                                object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    [_chart animate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TKChartDelegate

- (CAAnimation *)chart:(TKChart *)chart animationForSeries:(TKChartSeries *)series withState:(TKChartSeriesRenderState *)state inRect:(CGRect)rect
{
    CFTimeInterval duration = .5;
    NSMutableArray *animations = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<state.points.count; i++) {
        NSString *keyPath = [NSString stringWithFormat:@"seriesRenderStates.%lu.points.%d.y", (unsigned long)series.index, i];
        TKChartVisualPoint *point = [state.points objectAtIndex:i];
        CGFloat oldY = rect.size.height;
        
        CGFloat half = oldY + (point.y - oldY)/2.;
        CAKeyframeAnimation *a = [CAKeyframeAnimation animationWithKeyPath:keyPath];
        a.keyTimes = @[ @0, @0, @1 ];
        a.values = @[ @(oldY), @(half), @(point.y) ];
        a.duration = duration;
        a.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [animations addObject:a];
    }
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = duration;
    group.animations = animations;
    return group;
}

@end
