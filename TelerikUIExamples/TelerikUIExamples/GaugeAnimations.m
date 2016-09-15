//
//  GaugeAnimations.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "GaugeAnimations.h"
#import <TelerikUI/TelerikUI.h>

@interface GaugeAnimations ()

@property (nonatomic, strong) TKRadialGauge *radialGauge;
@property (nonatomic, strong) TKLinearGauge *linearGauge;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *segments;
@property (nonatomic, strong) UILabel *label;

@end

@implementation GaugeAnimations

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self addRadialGauge];
    [self addLinearGauge];
    
    self.segments = @[ @"60", @"80", @"120", @"160" ];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.segments];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl addTarget:self action:@selector(segmentTouched:) forControlEvents:UIControlEventValueChanged];
    
    self.label = [UILabel new];
    self.label.text = @"km/h";
    self.label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.label];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    TKGaugeNeedle *needle = (TKGaugeNeedle*)[[_radialGauge scaleAtIndex:0] indicatorAtIndex:0];
    [needle setValueAnimated:60
                withDuration:0.5
         mediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut];
    
    needle = (TKGaugeNeedle*)[[_linearGauge scaleAtIndex:0] indicatorAtIndex:0];
    [needle setValueAnimated:1.8
                withDuration:0.7
         mediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut];
}

- (void)addRadialGauge
{
    self.radialGauge = [[TKRadialGauge alloc] initWithFrame:CGRectZero];
    self.radialGauge.labelSubtitle.text = @"km/h";
    self.radialGauge.labelTitleOffset = CGPointMake(0, 20);
    [self.view addSubview:self.radialGauge];
    
    TKGaugeRadialScale* scale = [[TKGaugeRadialScale alloc] initWithMinimum:@0 maximum:@180];
    scale.labels.count = 9;
    scale.ticks.majorTicksCount = 18;
    scale.ticks.minorTicksCount = 1;
    scale.ticks.majorTicksLength = 4;
    scale.ticks.offset = 0.1;
    scale.ticks.majorTicksStroke = [TKStroke strokeWithColor:[UIColor colorWithRed:0.522f green:0.522f blue:0.522f alpha:1.00f] width:2];
    [self.radialGauge addScale:scale];
    
    NSArray *ranges = @[ [TKRange rangeWithMinimum:@0 andMaximum:@60],
                         [TKRange rangeWithMinimum:@61 andMaximum:@120],
                         [TKRange rangeWithMinimum:@121 andMaximum:@180]];
    NSArray *colors = @[ [UIColor colorWithRed:0.522f green:0.522f blue:0.522f alpha:1.00f],
                         [UIColor colorWithRed:0.200f green:0.200f blue:0.200f alpha:1.00f],
                         [UIColor colorWithRed:0.886f green:0.329f blue:0.353f alpha:1.00f]];
    NSInteger i = 0;
    for (TKRange *range in ranges) {
        TKGaugeSegment *segment = [[TKGaugeSegment alloc] initWithRange:range];
        segment.width = 0.02;
        segment.fill = [TKSolidFill solidFillWithColor:colors[i]];
        [scale addSegment:segment];
        i++;
    }

    // >> gauge-needle
    TKGaugeNeedle* needle = [TKGaugeNeedle new];
    needle.length = .8;
    needle.width = 3;
    needle.topWidth = 3;
    needle.shadowOffset = CGSizeMake(1, 1);
    needle.shadowOpacity = 0.8;
    needle.shadowRadius = 1.5;
    [scale addIndicator:needle];
    // << gauge-needle
}

- (void)addLinearGauge
{
    self.linearGauge = [[TKLinearGauge alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    self.linearGauge.labelSubtitle.text = @"rpm x 1000";
    [self.view addSubview:self.linearGauge];
    
    TKGaugeLinearScale* scale = [[TKGaugeLinearScale alloc] initWithMinimum:@0 maximum:@8];
    scale.offset = .55;
    scale.ticks.minorTicksCount = 1;
    scale.ticks.majorTicksCount = 14;
    scale.ticks.majorTicksLength = 4;
    scale.ticks.majorTicksStroke = [TKStroke strokeWithColor:[UIColor colorWithRed:0.522f green:0.522f blue:0.522f alpha:1.00f] width:2];
    [self.linearGauge addScale:scale];
    
    TKGaugeSegment *segment = [[TKGaugeSegment alloc] initWithMinimum:@0 maximum:@5];
    segment.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:0.522f green:0.522f blue:0.522f alpha:1.00f]];
    segment.location = .6;
    segment.width = 0.1;
    segment.width2 = 0.1;
    [scale addSegment:segment];
    
    segment = [[TKGaugeSegment alloc] initWithMinimum:@5.1 maximum:@8];
    segment.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:0.886f green:0.329f blue:0.353f alpha:1.00f]];
    segment.location = .6;
    segment.width = 0.1;
    segment.width2 = 0.1;
    [scale addSegment:segment];
    
    TKGaugeNeedle* needle = [TKGaugeNeedle new];
    needle.width = 3;
    needle.topWidth = 3;
    needle.length = 0.6;
    needle.shadowOffset = CGSizeMake(1, 1);
    needle.shadowOpacity = 0.8;
    needle.shadowRadius = 1.5;
    [scale addIndicator:needle];
}

#pragma mark - Touch event

- (void)segmentTouched:(UISegmentedControl*)source
{
    CGFloat value = [_segments[source.selectedSegmentIndex] integerValue];
    
    TKGaugeNeedle *needle = (TKGaugeNeedle*)[[_radialGauge scaleAtIndex:0] indicatorAtIndex:0];
    [needle setValueAnimated:value
                withDuration:0.5
         mediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut];
    
    needle = (TKGaugeNeedle*)[[_linearGauge scaleAtIndex:0] indicatorAtIndex:0];
    [needle setValueAnimated:(value/180)*7.
                withDuration:0.5
         mediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut];
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    CGSize size = self.view.bounds.size;
    CGFloat offset = 20;
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        CGFloat width = (size.width - offset*2.)/2.;
        _segmentedControl.frame = CGRectMake((size.width - 200)/2.,
                                             size.height - _segmentedControl.frame.size.height - offset,
                                             200, _segmentedControl.frame.size.height);
        _linearGauge.frame = CGRectMake(offset + offset/2. + width, (_segmentedControl.frame.origin.y - offset*2 - bounds.origin.y)/2., width, _linearGauge.frame.size.height);
        _radialGauge.frame = CGRectMake(offset, bounds.origin.y + 20, width, _segmentedControl.frame.origin.y - bounds.origin.y - offset*2);
        _label.frame = CGRectMake(CGRectGetMaxX(_segmentedControl.frame) + 5, CGRectGetMinY(_segmentedControl.frame) - 7, 100, 44);
    }
    else {
        _segmentedControl.frame = CGRectMake((size.width - 200)/2.,
                                             size.height - _segmentedControl.frame.size.height - offset,
                                             200, _segmentedControl.frame.size.height);
        _linearGauge.frame = CGRectMake(offset, _segmentedControl.frame.origin.y - _linearGauge.frame.size.height - offset*2, size.width - offset*2, _linearGauge.frame.size.height);
        _radialGauge.frame = CGRectMake(offset, bounds.origin.y + 20, size.width - offset*2, _linearGauge.frame.origin.y - bounds.origin.y - offset*2);
        _label.frame = CGRectMake(CGRectGetMaxX(_segmentedControl.frame) + 5, CGRectGetMinY(_segmentedControl.frame) - 7, 100, 44);
    }
}

@end
