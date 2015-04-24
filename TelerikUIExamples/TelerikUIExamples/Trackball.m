//
//  Trackball.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "Trackball.h"
#import <TelerikUI/TelerikUI.h>

@interface Trackball () <TKChartDelegate>
@end

@implementation Trackball
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self addOption:@"pin at top" selector:@selector(top)];
        [self addOption:@"pin at left" selector:@selector(left)];
        [self addOption:@"pin at right" selector:@selector(right)];
        [self addOption:@"pin at bottom" selector:@selector(bottom)];
        [self addOption:@"floating" selector:@selector(floating)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    NSMutableArray *array = [NSMutableArray new];
    NSMutableArray *array2 = [NSMutableArray new];
    for (int i = 0; i<=25; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(i+1) Y:@(arc4random() % 100)]];
        [array2 addObject:[[TKChartDataPoint alloc] initWithX:@(i+1) Y:@(arc4random() % 60)]];
    }
    
    TKChartNumericAxis *xAxis = [[TKChartNumericAxis alloc] initWithMinimum:@1 andMaximum:@26];
    xAxis.position = TKChartAxisPositionBottom;
    xAxis.majorTickInterval = @5;
    [_chart addAxis:xAxis];
    
    TKChartAreaSeries *series = [[TKChartAreaSeries alloc] initWithItems:array];
    series.xAxis = xAxis;
    [_chart addSeries:series];
    
    series = [[TKChartAreaSeries alloc] initWithItems:array2];
    series.xAxis = xAxis;
    [_chart addSeries:series];
    
    // enable the trackball
    _chart.allowTrackball = YES;
    _chart.trackball.snapMode = TKChartTrackballSnapModeAllClosestPoints;
    _chart.delegate = self;
    _chart.trackball.tooltip.style.textAlignment = NSTextAlignmentLeft;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TKChartDelegate

- (void)chart:(TKChart *)chart trackballDidTrackSelection:(NSArray *)selection
{
    NSMutableString *str = [NSMutableString new];
    BOOL first = YES;
    for (TKChartSelectionInfo *info in selection) {
        if (!first) {
            [str appendString:@"\n"];
        }
        else {
            first = !first;
        }
        [str appendFormat:@"Day %@ series %d - %@", info.dataPoint.dataXValue, (int)(info.series.index + 1), info.dataPoint.dataYValue];
    }
    chart.trackball.tooltip.text = str;
}

- (void)chart:(TKChart *)chart trackballDidHideSelection:(NSArray *)selection
{
    NSLog(@"trackball did hide");
}

#pragma mark Events

- (void)left
{
    [_chart.trackball hide];
    _chart.trackball.orientation = TKChartTrackballOrientationHorizontal;
    _chart.trackball.tooltip.pinPosition = TKChartTrackballPinPositionLeft;
    _chart.trackball.line.hidden = NO;
    _chart.trackball.snapMode = TKChartTrackballSnapModeAllClosestPoints;
}

- (void)right
{
    [_chart.trackball hide];
    _chart.trackball.orientation = TKChartTrackballOrientationHorizontal;
    _chart.trackball.tooltip.pinPosition = TKChartTrackballPinPositionRight;
    _chart.trackball.line.hidden = NO;
    _chart.trackball.snapMode = TKChartTrackballSnapModeAllClosestPoints;
}

- (void)top
{
    [_chart.trackball hide];
    _chart.trackball.orientation = TKChartTrackballOrientationVertical;
    _chart.trackball.tooltip.pinPosition = TKChartTrackballPinPositionTop;
    _chart.trackball.line.hidden = NO;
    _chart.trackball.snapMode = TKChartTrackballSnapModeAllClosestPoints;
}

- (void)bottom
{
    [_chart.trackball hide];
    _chart.trackball.orientation = TKChartTrackballOrientationVertical;
    _chart.trackball.tooltip.pinPosition = TKChartTrackballPinPositionBottom;
    _chart.trackball.line.hidden = NO;
    _chart.trackball.snapMode = TKChartTrackballSnapModeAllClosestPoints;
}

- (void)floating
{
    [_chart.trackball hide];
    _chart.trackball.orientation = TKChartTrackballOrientationVertical;
    _chart.trackball.tooltip.pinPosition = TKChartTrackballPinPositionNone;
    _chart.trackball.line.hidden = YES;
    _chart.trackball.snapMode = TKChartTrackballSnapModeClosestPoint;
}

@end
