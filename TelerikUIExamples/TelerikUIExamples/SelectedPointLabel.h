//
//  SelectedPointLabel.h
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <TelerikUI/TelerikUI.h>

@interface SelectedPointLabel : CALayer

@property (nonatomic, strong) TKChartPointLabelStyle *labelStyle;

@property (nonatomic, copy) NSString *text;

@property (nonatomic) BOOL isOutsideBounds;

@end
