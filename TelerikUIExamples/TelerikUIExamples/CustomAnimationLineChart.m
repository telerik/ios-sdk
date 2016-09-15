//
//  CustomAnimationLineChart.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "CustomAnimationLineChart.h"
#import <TelerikUI/TelerikUI.h>

@interface CustomAnimationLineChart() <TKChartDelegate>
@end

@implementation CustomAnimationLineChart
{
    TKChart *_chart;
    BOOL _grow;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Sequential animation" selector:@selector(applySequential)];
        [self addOption:@"Grow animation" selector:@selector(applyGrow)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.allowAnimations = YES;
    _chart.delegate = self;
    [self.view addSubview:_chart];
 
    NSMutableArray *points = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++) {
        [points addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random() % 100)]];
    }
    
    TKChartLineSeries *lineSeries = [[TKChartLineSeries alloc] initWithItems:points];
    CGFloat shapeSize = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 14 : 17;
    lineSeries.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(shapeSize, shapeSize)];
    lineSeries.style.shapeMode = TKChartSeriesStyleShapeModeAlwaysShow;
    lineSeries.selection = TKChartSeriesSelectionDataPoint;
    [_chart addSeries:lineSeries];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applySequential
{
    _grow = NO;
    [_chart animate];
}

- (void)applyGrow
{
    _grow = YES;
    [_chart animate];
}

#pragma mark TKChartDelegate

 // >> chart-anim-line
- (CAAnimation *)chart:(TKChart *)chart animationForSeries:(TKChartSeries *)series withState:(TKChartSeriesRenderState *)state inRect:(CGRect)rect
{
    CFTimeInterval duration = 0;
    NSMutableArray *animations = [[NSMutableArray alloc] init];
    for (int i = 0; i<state.points.count; i++) {
        
        if (_grow) {
            NSString *keyPath = [NSString stringWithFormat:@"seriesRenderStates.%lu.points.%d.x", (unsigned long)series.index, i];
            TKChartVisualPoint *point = [state.points objectAtIndex:i];
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
            animation.duration = 0.1 *(i + 0.2);
            animation.fromValue = @0;
            animation.toValue = @(point.x);
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            [animations addObject:animation];
            
            duration = animation.duration;
        }
        else {
            NSString *keyPath = [NSString stringWithFormat:@"seriesRenderStates.%lu.points.%d.y", (unsigned long)series.index, i];
            TKChartVisualPoint *point = [state.points objectAtIndex:i];
            CGFloat oldY = rect.size.height;
            
            if (i > 0) {
                CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
                animation.duration = 0.1* (i + 1);
                animation.values = @[ @(oldY), @(oldY), @(point.y) ];
                animation.keyTimes = @[ @0, @(i/(i+1.)), @1 ];
                animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                [animations addObject:animation];
                
                duration = animation.duration;
            }
            else {
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
                animation.fromValue = @(oldY);
                animation.toValue = @(point.y);
                animation.duration = 0.1f;
                [animations addObject:animation];
            }
        }
    }
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = duration;
    group.animations = animations;
    
    return group;
}
 // << chart-anim-line

@end
