//
//  Indicators.h
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "ExampleViewController.h"

@interface IndicatorsViewController : ExampleViewController <UIPopoverControllerDelegate>

@property (nonatomic, strong) NSMutableArray *trendlines;

@property (nonatomic, strong) NSMutableArray *indicators;

@property (nonatomic) NSInteger selectedTrendline;

@property (nonatomic) NSInteger selectedIndicator;

@end
