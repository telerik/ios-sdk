//
//  GaugeGettingStarted.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 г. Telerik. All rights reserved.
//

#import "GaugeGettingStarted.h"
#import <TelerikUI/TelerikUI.h>

@interface GaugeGettingStarted () <TKGaugeDelegate>

@property (nonatomic, strong) TKRadialGauge *radialGauge;
@property (nonatomic, strong) TKLinearGauge *linearGauge;

@end

@implementation GaugeGettingStarted

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setRadialGauge];
    [self setLinearGauge];
}

- (void)setRadialGauge
{
    self.radialGauge = [[TKRadialGauge alloc] initWithFrame:CGRectZero];
    self.radialGauge.delegate = self;
    [self.view addSubview:self.radialGauge];
    
    TKGaugeRadialScale *scale = [[TKGaugeRadialScale alloc] initWithMinimum:@0 maximum:@6];
    [self.radialGauge addScale:scale];
    
    [scale addIndicator:[[TKGaugeNeedle alloc] initWithValue:2.3 length:0.6]];
    
    NSArray *colors = @[ [UIColor colorWithRed:0.871f green:0.871f blue:0.871f alpha:1.00f],
                         [UIColor colorWithRed:0.533f green:0.796f blue:0.290f alpha:1.00f],
                         [UIColor colorWithRed:1.000f green:0.773f blue:0.247f alpha:1.00f],
                         [UIColor colorWithRed:1.000f green:0.467f blue:0.161f alpha:1.00f],
                         [UIColor colorWithRed:0.769f green:0.000f blue:0.043f alpha:1.00f]];
    
    CGFloat rangeWidth = [scale.range.maximum floatValue] / colors.count;
    CGFloat start = 0;
    for (UIColor *color in colors) {
        TKGaugeSegment *segment = [[TKGaugeSegment alloc] initWithMinimum:@(start) maximum:@(start + rangeWidth)];
        segment.fill = [TKSolidFill solidFillWithColor:color];
        [scale addSegment:segment];
        start += rangeWidth;
    }
}

- (void)setLinearGauge
{
    self.linearGauge = [[TKLinearGauge alloc] initWithFrame:CGRectMake(0, 0, 150, 0)];
    self.linearGauge.delegate = self;
    self.linearGauge.orientation = TKLinearGaugeOrientationVertical;
    [self.view addSubview:self.linearGauge];
    
    TKGaugeLinearScale* scale = [[TKGaugeLinearScale alloc] initWithMinimum:@-10 maximum:@40];
    [self.linearGauge addScale:scale];
    
    TKGaugeSegment* segment = [[TKGaugeSegment alloc] initWithMinimum:@-10 maximum:@18];
    segment.location = 0.60;
    segment.width = 0.05;
    segment.width2 = 0.05;
    segment.cap = TKGaugeSegmentCapRound;
    [scale addSegment: segment];
    
    NSArray *colors = @[ [UIColor colorWithRed:0.149f green:0.580f blue:0.776f alpha:1.00f],
                         [UIColor colorWithRed:0.537f green:0.796f blue:0.290f alpha:1.00f],
                         [UIColor colorWithRed:1.000f green:0.773f blue:0.247f alpha:1.00f],
                         [UIColor colorWithRed:1.000f green:0.463f blue:0.157f alpha:1.00f],
                         [UIColor colorWithRed:0.769f green:0.000f blue:0.047f alpha:1.00f]];
    [self addSegmentsInScale:scale withColors:colors atLocation:0.5 width:0.05];
}

- (void)addSegmentsInScale:(TKGaugeScale*)scale withColors:(NSArray*)colors atLocation:(CGFloat)location width:(CGFloat)width
{
    CGFloat rangeWidth = ([scale.range.maximum floatValue] - [scale.range.minimum floatValue]) / colors.count;
    CGFloat start = [scale.range.minimum floatValue];
    for (UIColor *color in colors) {
        TKGaugeSegment *segment = [[TKGaugeSegment alloc] initWithMinimum:@(start) maximum:@(start + rangeWidth)];
        segment.fill = [TKSolidFill solidFillWithColor:color];
        segment.location = location;
        segment.width = width;
        segment.width2 = width;
        [scale addSegment:segment];
        start += rangeWidth;
    }
}

#pragma mark - TKGaugeDelegate

- (NSString *)gauge:(TKGauge *)gauge textForLabel:(id)label
{
    if ([gauge isKindOfClass:[TKRadialGauge class]]) {
        return [NSString stringWithFormat:@"%d bar", (int)[label integerValue]];
    }
    else {
        return [NSString stringWithFormat:@"%d degrees", (int)[label integerValue]];
    }
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    CGSize size = self.view.bounds.size;
    CGFloat offset = 20;
    CGFloat linearWidth = CGRectGetWidth(_linearGauge.frame);
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        CGFloat width = (size.width - offset*3.)/2.;
        _radialGauge.frame = CGRectMake(offset*2, bounds.origin.y + offset, width, bounds.size.height - offset*2);
        CGFloat x = CGRectGetMaxX(_radialGauge.frame);
        _linearGauge.frame = CGRectMake(x + offset + (bounds.size.width - x - linearWidth)/2.,
                                        bounds.origin.y + offset, linearWidth, bounds.size.height - offset*2);
    }
    else {
        CGFloat height = (self.view.bounds.size.height - offset*3)/2.;
        _radialGauge.frame = CGRectMake(offset, bounds.origin.y + offset, size.width - offset*2, height);
        _linearGauge.frame = CGRectMake((bounds.size.width - linearWidth - offset*2)/2. + offset,
                                        size.height - height - offset, linearWidth, height);
    }
}

@end
