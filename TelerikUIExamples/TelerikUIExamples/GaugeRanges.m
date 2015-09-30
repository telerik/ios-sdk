//
//  GaugeRanges.m
//  TelerikUIExamples
//
//  Copyright © 2015 г. Telerik. All rights reserved.
//

#import "GaugeRanges.h"
#import <TelerikUI/TelerikUI.h>

@interface GaugeRanges ()

@property (nonatomic, strong) TKLinearGauge* linearGauge;
@property (nonatomic, strong) TKRadialGauge* radialGauge;

@end

@implementation GaugeRanges
{
    NSArray* _redColors;
    NSArray* _greenColors;
    NSArray* _blueColors;
    NSArray* _redValues;
    NSArray* _blueValues;
    NSArray* _greenValues;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _redColors =   @[[UIColor colorWithRed:0.96 green:0.80 blue:0.80 alpha:1.0],
                     [UIColor colorWithRed:0.80 green:0.00 blue:0.00 alpha:1.0],
                     [UIColor colorWithRed:0.88 green:0.40 blue:0.40 alpha:1.0]];
    
    _greenColors = @[[UIColor colorWithRed:0.85 green:0.92 blue:0.83 alpha:1.0],
                     [UIColor colorWithRed:0.71 green:0.84 blue:0.66 alpha:1.0],
                     [UIColor colorWithRed:0.58 green:0.77 blue:0.49 alpha:1.0]];
    
    _blueColors  = @[[UIColor colorWithRed:0.62 green:0.77 blue:0.91 alpha:1.0] ,
                     [UIColor colorWithRed:0.44 green:0.66 blue:0.86 alpha:1.0],
                     [UIColor colorWithRed:0.11 green:0.27 blue:0.53 alpha:1.0]];
    
    _redValues = @[@(0), @(20), @(40), @(100)];
    _greenValues = @[@(0), @(40), @(80), @(100)];
    _blueValues = @[@(0), @(10), @(90), @(100)];
    
    NSArray* legendStrings = @[@"FATS", @"CARBS", @"PROTEINS"];
    NSArray* legendColors = @[[UIColor colorWithRed:0.96 green:0.80 blue:0.80 alpha:1.0],
                              [UIColor colorWithRed:0.85 green:0.92 blue:0.83 alpha:1.0],
                              [UIColor colorWithRed:0.62 green:0.77 blue:0.91 alpha:1.0]];
    
    for (int i=0; i < 3; i++) {
        TKView *view = [[TKView alloc] initWithFrame:CGRectMake(20, 80 + i*25, 22, 22)];
        view.fill = [TKSolidFill solidFillWithColor:legendColors[i]];
        view.shape = [TKPredefinedShape shapeWithType:TKShapeTypeCircle andSize:CGSizeZero];
        [self.view addSubview:view];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(50, 80 + i * 25, CGRectGetMaxX(self.view.frame) - 60, 20)];
        label.text = legendStrings[i];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        label.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        [self.view addSubview:label];
    }

    [self setLinearGauge];
    [self setRadialGauge];
}

- (void)setLinearGauge
{
    self.linearGauge = [[TKLinearGauge alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.linearGauge];
    
    TKGaugeLinearScale* scale = [[TKGaugeLinearScale alloc] init];
    [self.linearGauge addScale:scale];
  
    for (int i = 0; i < 3; i++) {
        TKGaugeSegment* segment = [[TKGaugeSegment alloc] init];
        segment.range = [[TKRange alloc]initWithMinimum:_redValues[i] andMaximum:_redValues[i+1]];
        segment.fill = [TKSolidFill solidFillWithColor:_redColors[i]];
        segment.location = 0.55;
        segment.cap = TKGaugeSegmentCapRound;
        [scale addSegment:segment];
    }
  
    for (int i = 0; i < 3; i++) {
        TKGaugeSegment* segment = [[TKGaugeSegment alloc] init];
        segment.range = [[TKRange alloc]initWithMinimum:_greenValues[i] andMaximum:_greenValues[i+1]];
        segment.fill = [TKSolidFill solidFillWithColor:_greenColors[i]];
        segment.location = 0.67;
        segment.cap = TKGaugeSegmentCapRound;
        [scale addSegment:segment];
    }
    
    for (int i = 0; i < 3; i++) {
        TKGaugeSegment* segment = [[TKGaugeSegment alloc] init];
        segment.range = [[TKRange alloc]initWithMinimum:_blueValues[i] andMaximum:_blueValues[i+1]];
        segment.fill = [TKSolidFill solidFillWithColor:_blueColors[i]];
        segment.location = 0.79;
        segment.cap = TKGaugeSegmentCapRound;
        [scale addSegment:segment];
    }
    
    NSArray* lengths = @[@.55, @.67, @.79];
    
    for (int i = 0; i < 3 ; i++) {
        TKGaugeNeedle* needle = [TKGaugeNeedle new];
        needle.value = arc4random_uniform(100);
        needle.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
        needle.length = 1 - [lengths[i] doubleValue];
        [scale addIndicator:needle];
    }
}

- (void)setRadialGauge
{
    self.radialGauge = [[TKRadialGauge alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.radialGauge];
    
    TKGaugeRadialScale* scale = [[TKGaugeRadialScale alloc] init];
    scale.radius = 0.76;
    scale.ticks.position = TKGaugeTicksPositionOuter;
    scale.labels.position = TKGaugeTicksPositionOuter;
    scale.ticks.offset = 0.05;
    scale.labels.offset = 0.15;
    [self.radialGauge addScale:scale];
    
      for (int i = 0; i < 3; i++) {
        TKGaugeSegment* segment = [[TKGaugeSegment alloc] init];
        segment.range = [[TKRange alloc]initWithMinimum:_redValues[i] andMaximum:_redValues[i+1]];
        segment.fill = [TKSolidFill solidFillWithColor:_redColors[i]];
        segment.cap = TKGaugeSegmentCapRound;
        segment.location = .76;
        [scale addSegment:segment];
    }
    
    for (int i = 0; i < 3; i++) {
        TKGaugeSegment* segment = [[TKGaugeSegment alloc] init];
        segment.range = [[TKRange alloc]initWithMinimum:_greenValues[i] andMaximum:_greenValues[i+1]];
        segment.fill = [TKSolidFill solidFillWithColor:_greenColors[i]];
        segment.location = .64;
        segment.cap = TKGaugeSegmentCapRound;
        [scale addSegment:segment];
    }
    
    for (int i = 0; i < 3; i++) {
        TKGaugeSegment* segment = [[TKGaugeSegment alloc] init];
        segment.range = [[TKRange alloc]initWithMinimum:_blueValues[i] andMaximum:_blueValues[i+1]];
        segment.fill = [TKSolidFill solidFillWithColor:_blueColors[i]];
        segment.location = .52;
        segment.cap = TKGaugeSegmentCapRound;
        [scale addSegment:segment];
    }
    
    NSArray* lengths = @[@.76, @.64, @.52];
    
    for (int i = 0; i < 3 ; i++) {
        TKGaugeNeedle* needle = [TKGaugeNeedle new];
        needle.value = arc4random_uniform(100);
        needle.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
        needle.length = [lengths[i] doubleValue];
        [scale addIndicator:needle];
    }
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.exampleBounds;
    CGSize size = self.view.bounds.size;
    CGFloat offset = 20;
    CGFloat linearHeight = 135;
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        CGFloat width = (CGRectGetWidth(bounds)- offset* 3.)/2.;
        CGFloat height = CGRectGetHeight(bounds) - offset*2.;
        _linearGauge.frame = CGRectMake(offset, offset+ (size.height -linearHeight)/2 , width, linearHeight);
        _radialGauge.frame = CGRectMake(2*offset + width, offset + (size.height - height)/2, width, height);
    } else {
        CGFloat width = CGRectGetWidth(bounds) - offset*2.;
        CGFloat height = (CGRectGetHeight(bounds)- offset* 3.)/2.;
        _linearGauge.frame = CGRectMake(offset, (offset + height) /2., width, linearHeight);
        _radialGauge.frame = CGRectMake(offset, (size.height)/2., width, height + offset*2);
    }
}

@end
