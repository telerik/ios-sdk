//
//  GaugeScales.m
//  TelerikUIExamples
//
//  Copyright © 2015 г. Telerik. All rights reserved.
//

#import "GaugeScales.h"
#import <TelerikUI/TelerikUI.h>

@interface GaugeScales ()

@property (nonatomic, strong) TKRadialGauge *radialGauge;
@property (nonatomic, strong) TKLinearGauge *linearGauge;


@end

@implementation GaugeScales

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupRadialGauge];
    [self setupLinearGauge];
}

- (void)setupRadialGauge
{
    self.radialGauge = [[TKRadialGauge alloc] initWithFrame:CGRectZero];
    self.radialGauge.labelTitle.text = @"celsius";
    self.radialGauge.labelSubtitle.text = @"farenheit";
    self.radialGauge.labelTitleOffset = CGPointMake(0, 60);
    [self.view addSubview:self.radialGauge];

    TKGaugeRadialScale* scale1 = [[TKGaugeRadialScale alloc] initWithMinimum:@34 maximum:@40];
    scale1.ticks.position = TKGaugeTicksPositionInner;
    [self.radialGauge addScale:scale1];
    
    TKGaugeSegment* blueSegment = [TKGaugeSegment new];
    blueSegment.range = [[TKRange alloc] initWithMinimum:@(34) andMaximum:@(36)];
    blueSegment.location = .70;
    blueSegment.width = 0.08;
    [scale1 addSegment: blueSegment];
    
    TKGaugeSegment* redSegment = [TKGaugeSegment new];
    redSegment.range = [[TKRange alloc] initWithMinimum:@(36.05) andMaximum:@(40)];
    redSegment.location = .70;
    redSegment.width = 0.08;
    redSegment.fill = [TKSolidFill solidFillWithColor:[UIColor redColor]];
    [scale1 addSegment: redSegment];
    
    [self setNeedle:scale1];
    
    TKGaugeRadialScale* scale2 = [[TKGaugeRadialScale alloc] initWithMinimum:@93.2 maximum:@104];
    scale2.ticks.position = TKGaugeTicksPositionOuter;
    scale2.ticks.majorTicksCount = 6;
    scale2.ticks.minorTicksCount = 20;
    scale2.labels.position = TKGaugeLabelsPositionOuter;
    scale2.labels.labelFormat = @"%.01f";
    scale2.labels.count = 6;
    [self.radialGauge addScale:scale2];
    
    for(int i = 0; i<self.radialGauge.scales.count; i++) {
        TKGaugeRadialScale* scale = self.radialGauge.scales[i];
        scale.stroke = [TKStroke strokeWithColor:[UIColor grayColor] width:2];
        scale.ticks.majorTicksStroke = [TKStroke strokeWithColor:[UIColor grayColor] width:1];
        scale.labels.color = [UIColor grayColor];
        scale.ticks.offset = 0;
        scale.labels.offset = 0.10;
        scale.radius = i*.12 + .60;
    }
}

- (void)setupLinearGauge
{
    self.linearGauge = [[TKLinearGauge alloc] initWithFrame:CGRectZero];
    self.linearGauge.labelTitle.text = @"celsius";
    self.linearGauge.labelSubtitle.text = @"farenheit";
    self.linearGauge.labelOrientation = TKLinearGaugeOrientationVertical;
    self.linearGauge.labelTitleOffset = CGPointMake(0, 35);
    self.linearGauge.labelSubtitleOffset = CGPointMake(0, 100);
    [self.view addSubview:self.linearGauge];

    TKGaugeLinearScale* scale1 = [[TKGaugeLinearScale alloc] initWithMinimum:@34 maximum:@40];
    scale1.ticks.position = TKGaugeTicksPositionInner;
    [self.linearGauge addScale:scale1];
    
    TKGaugeSegment* blueSegment = [TKGaugeSegment new];
    blueSegment.range = [[TKRange alloc] initWithMinimum:@(34) andMaximum:@(36)];
    blueSegment.location = .62;
    blueSegment.width = 0.08;
    blueSegment.width2 = 0.08;
    [scale1 addSegment: blueSegment];
    
    TKGaugeSegment* redSegment = [TKGaugeSegment new];
    redSegment.range = [[TKRange alloc] initWithMinimum:@(36.05) andMaximum:@(40)];
    redSegment.location = .62;
    redSegment.width = 0.08;
    redSegment.width2 = 0.08;
    redSegment.fill = [TKSolidFill solidFillWithColor:[UIColor redColor]];
    [scale1 addSegment: redSegment];
    
    [self setNeedle:scale1];
    
    TKGaugeLinearScale* scale2 = [[TKGaugeLinearScale alloc] initWithMinimum:@93.2 maximum:@104];
    scale2.ticks.position = TKGaugeTicksPositionOuter;
    scale2.ticks.majorTicksCount = 6;
    scale2.ticks.minorTicksCount = 20;
    scale2.labels.position = TKGaugeLabelsPositionOuter;
    scale2.labels.labelFormat = @"%.01f";
    scale2.labels.count = 6;
    [self.linearGauge addScale:scale2];
    
    for (int i = 0; i<self.linearGauge.scales.count; i++) {
        TKGaugeLinearScale *scale = self.linearGauge.scales[i];
        scale.stroke = [TKStroke strokeWithColor:[UIColor grayColor] width:2];
        scale.ticks.majorTicksStroke = [TKStroke strokeWithColor:[UIColor grayColor] width:1];
        scale.labels.color = [UIColor grayColor];
        scale.ticks.offset = 0;
        scale.offset = i*.12 + .60;
    }
}

- (void)setNeedle:(TKGaugeScale *)scale
{
    TKGaugeNeedle* needle = [TKGaugeNeedle new];
    needle.value = 36;
    needle.length = 0.5;
    needle.width = 2;
    needle.topWidth = 2;
    needle.shadowOpacity = 0.5;
    [scale addIndicator:needle];
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    CGSize size = self.view.bounds.size;
    CGFloat offset = 20;
    CGFloat linearHeight = 150;
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        CGFloat width = (CGRectGetWidth(bounds)- offset* 3.)/2.;
        CGFloat height = CGRectGetHeight(bounds) - offset*2.;
        _linearGauge.frame = CGRectMake(offset, (size.height - linearHeight)/2 , width, linearHeight);
        _radialGauge.frame = CGRectMake(offset + width, offset + (size.height - height)/2, width + offset, height);
    } else {
        CGFloat width = CGRectGetWidth(bounds) - offset*2.;
        CGFloat height = (CGRectGetHeight(bounds)- offset* 3.)/2.;
        _linearGauge.frame = CGRectMake(offset,linearHeight/2., width, linearHeight);
        _radialGauge.frame = CGRectMake(offset, (size.height+ offset)/2., width, height);
    }
}

@end
