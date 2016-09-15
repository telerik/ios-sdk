//
//  ChartDocsStructure.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsStructure.h"


@implementation ChartDocsStructure

{
    NSArray *values1;
    NSArray *values2;
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:chart];
    
    chart.allowAnimations = YES;
    chart.delegate = self;
    
    values1 = @[@12, @10, @98, @64, @11, @27, @85, @72, @43, @39];
    values2 = @[@87, @22, @29, @87, @65, @99, @63, @12, @82, @87];
}

// >> chart-structure-animation
- (CAAnimation *)chart:(TKChart *)chart animationForSeries:(TKChartSeries *)series withState:(TKChartSeriesRenderState *)state inRect:(CGRect)rect
{
    CFTimeInterval duration = 0;
    NSMutableArray *animations = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<state.points.count; i++) {
        NSString *keyPath = [NSString stringWithFormat:@"%@.x", [state animationKeyPathForPointAtIndex:i]];
        TKChartVisualPoint *point = [state.points objectAtIndex:i];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
        animation.duration = (arc4random() % 100) / 100.;
        animation.fromValue = @0;
        animation.toValue = @(point.x);
        [animations addObject:animation];
        duration = MAX(animation.duration, duration);
    }
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = duration;
    group.animations = animations;
    
    return group;
}
// << chart-structure-animation

- (void) structureSeries
{
    // >> chart-structure-series
    values1 = @[@12, @10, @98, @64, @11, @27, @85, @72, @43, @39];
    values2 = @[@87, @22, @29, @87, @65, @99, @63, @12, @82, @87];
    
    NSMutableArray *expensesData = [[NSMutableArray alloc] init];
    NSMutableArray *incomesData = [[NSMutableArray alloc] init];
    for (int i = 0; i < values1.count; i++) {
        [expensesData addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:values2[i]]];
        [incomesData addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:values1[i]]];
    }
    TKChartStackInfo *stackInfo = [[TKChartStackInfo alloc] initWithID:@(1) withStackMode:TKChartStackModeStack];
    
    TKChartSeries *series1 = [[TKChartColumnSeries alloc] initWithItems:expensesData];
    series1.title = @"Expenses";
    series1.stackInfo = stackInfo;
    [chart addSeries:series1];
    
    TKChartSeries *series2 = [[TKChartColumnSeries alloc] initWithItems:incomesData];
    series2.title = @"Incomes";
    series2.stackInfo = stackInfo;
    [chart addSeries:series2];
    // << chart-structure-series
}

- (void) structureAxes
{
    // >> chart-structure-axes
    TKChartNumericAxis *xAxis = [[TKChartNumericAxis alloc] init];
    xAxis.position = TKChartAxisPositionBottom;
    [chart addAxis:xAxis];
    
    TKChartNumericAxis *yAxis1 = [[TKChartNumericAxis alloc] initWithMinimum:@0 andMaximum:@100];
    yAxis1.majorTickInterval = @50;
    yAxis1.position = TKChartAxisPositionLeft;
    yAxis1.style.lineHidden = NO;
    [chart addAxis:yAxis1];
    
    TKChartNumericAxis *yAxis2 = [[TKChartNumericAxis alloc] initWithMinimum:@0 andMaximum:@200];
    yAxis2.majorTickInterval = @50;
    yAxis2.position = TKChartAxisPositionRight;
    yAxis2.style.lineHidden = NO;
    [chart addAxis:yAxis2];
    
    NSMutableArray *incomesData = [[NSMutableArray alloc] init];
    for (int i = 0; i < values1.count; i++) {
        [incomesData addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:values1[i]]];
    }
    
    TKChartLineSeries *series = [[TKChartLineSeries alloc] initWithItems:incomesData];
    series.xAxis = xAxis;
    series.yAxis = yAxis1;
    [chart addSeries:series];
    // << chart-structure-axes
    
}

@end
