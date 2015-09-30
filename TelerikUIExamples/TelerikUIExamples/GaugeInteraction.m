//
//  GaugeInteraction.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "GaugeInteraction.h"
#import <TelerikUI/TelerikUI.h>

@interface GaugeInteraction () <TKGaugeDelegate>

@property (nonatomic, strong) TKRadialGauge *radialGauge;
@property (nonatomic, strong) TKLinearGauge *linearGauge;

@end

@implementation GaugeInteraction

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addRadialGauge];
    [self addLinearGauge];
}

- (void)addRadialGauge
{
    self.radialGauge = [[TKRadialGauge alloc] initWithFrame:CGRectZero];
    self.radialGauge.delegate = self;
    self.radialGauge.labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30];
    self.radialGauge.labelTitle.text = @"28˚C";
    self.radialGauge.labelSubtitle.text = @"temperature";
    self.radialGauge.labelSubtitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [self.view addSubview:self.radialGauge];
    
    TKGaugeRadialScale* scale = [[TKGaugeRadialScale alloc] initWithMinimum:@10 maximum:@40];
    scale.ticks.hidden = YES;
    scale.radius = 0.8;
    scale.stroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:0.7 alpha:1.] width:3];
    scale.labels.position = TKGaugeLabelsPositionOuter;
    scale.labels.offset = 0.1;
    [_radialGauge addScale:scale];
    
    TKGaugeSegment *segment = [[TKGaugeSegment alloc] initWithMinimum:@10 maximum:@28];
    segment.allowTouch = YES;
    segment.location = .85;
    segment.width = 0.08;
    segment.shadowColor = [UIColor blackColor].CGColor;
    segment.shadowOffset = CGSizeMake(5, 5);
    segment.shadowOpacity = 0.8;
    segment.shadowRadius = 5;
    [scale addSegment:segment];
}

- (void)addLinearGauge
{
    self.linearGauge = [[TKLinearGauge alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    self.linearGauge.labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    self.linearGauge.labelTitle.text = @"85 %";
    self.linearGauge.labelSubtitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    self.linearGauge.labelSubtitle.text = @"humidity";
    self.linearGauge.delegate = self;
    [self.view addSubview:self.linearGauge];
    
    TKGaugeLinearScale* scale = [[TKGaugeLinearScale alloc] initWithMinimum:@0 maximum:@100];
    scale.ticks.hidden = YES;
    scale.stroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:0.7 alpha:1.] width:3];
    scale.labels.position = TKGaugeLabelsPositionOuter;
    scale.labels.offset = 0.2;
    scale.offset = 0.2;
    [_linearGauge addScale:scale];
    
    TKGaugeSegment *segment = [[TKGaugeSegment alloc] initWithMinimum:@0 maximum:@85];
    segment.allowTouch = YES;
    segment.location = 0.13;
    segment.shadowColor = [UIColor blackColor].CGColor;
    segment.shadowOffset = CGSizeMake(5, 5);
    segment.shadowOpacity = 0.8;
    segment.shadowRadius = 5;
    segment.width = 0.1;
    segment.width2 = 0.1;
    [scale addSegment:segment];
}

#pragma mark - TKGaugeDelegate

- (void)gauge:(TKGauge *)gauge valueChanged:(CGFloat)value forScale:(TKGaugeScale *)scale
{
    if (gauge == self.radialGauge) {
        self.radialGauge.labelTitle.text = [NSString stringWithFormat:@"%d˚C", (int)value];
    }
    else {
        self.linearGauge.labelTitle.text = [NSString stringWithFormat:@"%d %%", (int)value];
    }
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.exampleBounds;
    CGSize size = self.view.bounds.size;
    CGFloat offset = 20;
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        CGFloat width = (size.width - offset*2.)/2.;
        _linearGauge.frame = CGRectMake(offset + offset/2. + width, (size.height - offset*3 - bounds.origin.y)/2., width, _linearGauge.frame.size.height);
        _radialGauge.frame = CGRectMake(offset, bounds.origin.y + 20, width, size.height - bounds.origin.y - offset*3);
    }
    else {
        _linearGauge.frame = CGRectMake(offset, size.height - _linearGauge.frame.size.height - offset*2, size.width - offset*2, _linearGauge.frame.size.height);
        _radialGauge.frame = CGRectMake(offset, bounds.origin.y + 20, size.width - offset*2, _linearGauge.frame.origin.y - bounds.origin.y - offset*2);
    }
}

@end
