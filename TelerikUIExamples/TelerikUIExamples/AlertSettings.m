//
//  AlertSettings.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "AlertSettings.h"

@implementation AlertSettings

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = @"Alert";
        _message = @"Hello world";
        _allowParallax = NO;
        _backgroundStyle = TKAlertBackgroundStyleDim;
        _actionsLayout = TKAlertActionsLayoutHorizontal;
        _dismissMode = TKAlertDismissModeNone;
        _dismissDirection = TKAlertSwipeDismissDirectionHorizontal;
        _animationDuration = 0.3;
        _backgroundDim = 0.3;
    }
    return self;
}

@end
