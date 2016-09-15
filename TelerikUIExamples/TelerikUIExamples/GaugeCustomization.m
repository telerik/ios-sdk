//
//  GaugeCustomization.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 г. Telerik. All rights reserved.
//

#import "GaugeCustomization.h"
#import <TelerikUI/TelerikUI.h>

@implementation GaugeCustomization
{
    TKRadialGauge* _radialGauge;
    TKLinearGauge* _linearGauge;
    NSArray* _colors;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // >> gauge-customize
    _colors = @[[UIColor colorWithRed:0.00 green:0.70 blue:0.90 alpha:1.0],
                [UIColor colorWithRed:0.38 green:0.73 blue:0.00 alpha:1.0],
                [UIColor colorWithRed:0.96 green:0.56 blue:0.00 alpha:1.0],
                [UIColor colorWithRed:0.00 green:1.00 blue:1.00 alpha:1.0],
                [UIColor colorWithRed:0.77 green:1.00 blue:0.00 alpha:1.0],
                [UIColor colorWithRed:1.00 green:0.85 blue:0.00 alpha:1.0]];
    // << gauge-customize
    NSArray* legendStrings = @[@"MOVE", @"EXCERCISE", @"STAND"];
    
    for (int i=0; i < 3; i++) {
        TKView *view = [[TKView alloc] initWithFrame:CGRectMake(20, 30 + i*25, 22, 22)];
        view.fill = [[TKLinearGradientFill alloc] initWithColors:@[_colors[i], _colors[i+3]]];
        view.shape = [TKPredefinedShape shapeWithType:TKShapeTypeCircle andSize:CGSizeZero];
        [self.view addSubview:view];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(50, 30 + i * 25, CGRectGetMaxX(self.view.frame) - 60, 20)];
        label.text = legendStrings[i];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        label.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        [self.view addSubview:label];
    }
    
    [self setupRadialGauge];
    [self setupLinearGauge];
}

- (void)setupLinearGauge
{
    _linearGauge = [[TKLinearGauge alloc]  initWithFrame:CGRectZero];
    [self.view addSubview:_linearGauge];

    TKGaugeLinearScale* scale = [TKGaugeLinearScale new];
    scale.stroke = nil;
    scale.ticks.hidden = YES;
    scale.labels.hidden = YES;
    [_linearGauge addScale:scale];
    // >> gauge-customize
    for (int i=0; i < 3; i++) {
        TKGaugeSegment* segment = [[TKGaugeSegment alloc] initWithMinimum:@0 maximum:@100];
        segment.fill = [TKSolidFill solidFillWithColor:[_colors[i] colorWithAlphaComponent:0.4]];
        segment.width = 0.2;
        segment.width2 = 0.2;
        segment.location = i * .3;
        segment.cap = TKGaugeSegmentCapRound;
        [scale addSegment:segment];
        
        TKGaugeSegment* gradientSegment = [TKGaugeSegment new];
        gradientSegment.fill = [[TKLinearGradientFill alloc] initWithColors:@[_colors[i], _colors[i + 3]]];
        gradientSegment.width = 0.2;
        gradientSegment.width2 = 0.2;
        gradientSegment.location = i * .3;
        gradientSegment.cap = TKGaugeSegmentCapRound;
        [scale addSegment:gradientSegment];
        
        [gradientSegment setRangeAnimated:[[TKRange alloc] initWithMinimum:@0 andMaximum:@(arc4random_uniform(50) + 20)]
                             withDuration:0.5 + arc4random_uniform(200)/200.
                      mediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut];
    }
    // << gauge-customize
}

- (void)setupRadialGauge
{
    _radialGauge = [[TKRadialGauge alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_radialGauge];
    
    TKGaugeRadialScale* scale = [TKGaugeRadialScale new];
    scale.startAngle = 0;
    scale.endAngle = M_PI*2;
    scale.stroke = nil;
    scale.ticks.hidden = YES;
    scale.labels.hidden = YES;
    [_radialGauge addScale:scale];
    
    for (int i=0; i < 3; i++) {
        TKGaugeSegment* segment = [[TKGaugeSegment alloc] initWithMinimum:@0 maximum:@100];
        segment.fill = [TKSolidFill solidFillWithColor:[_colors[i] colorWithAlphaComponent:0.4]];
        segment.cap = TKGaugeSegmentCapRound;
        segment.width = 0.2;
        segment.location = .5 + i * .25;
        [scale addSegment:segment];
        
        TKGaugeSegment* gradientSegment = [TKGaugeSegment new];
        gradientSegment.cap = TKGaugeSegmentCapRound;
        gradientSegment.fill = [[TKLinearGradientFill alloc] initWithColors:@[_colors[i], _colors[i + 3]]];
        gradientSegment.width = 0.2;
        gradientSegment.location = .5 + i * .25;
        [scale addSegment:gradientSegment];
        
        [gradientSegment setRangeAnimated:[[TKRange alloc] initWithMinimum:@0 andMaximum:@(arc4random_uniform(50) + 30)]
                           withDuration:0.5 + arc4random_uniform(200)/200.
                    mediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut];
    }
}


#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    CGSize size = self.view.bounds.size;
    CGFloat offset = 20;
    CGFloat linearHeight = 130;
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        CGFloat width = (CGRectGetWidth(bounds)- offset* 3.)/2.;
        CGFloat height = CGRectGetHeight(bounds) - offset*2.;
        _linearGauge.frame = CGRectMake(offset, size.height/2., width, linearHeight);
        _radialGauge.frame = CGRectMake(2* offset + width, offset*1.5, width, height);
    } else {
        CGFloat width = CGRectGetWidth(bounds) - offset*2.;
        CGFloat height = (CGRectGetHeight(bounds)- offset* 3.)/2.;

        _linearGauge.frame = CGRectMake(offset, size.height/4., width, linearHeight);
        _radialGauge.frame = CGRectMake(offset, size.height/4. + linearHeight, width, height);
    }
}

@end
