//
//  AlertSettings.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TelerikUI/TelerikUI.h>

@interface AlertSettings : NSObject

@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) NSString* message;

@property (nonatomic) BOOL allowParallax;

@property (nonatomic) TKAlertBackgroundStyle backgroundStyle;

@property (nonatomic) TKAlertActionsLayout actionsLayout;

@property (nonatomic) TKAlertDismissMode dismissMode;

@property (nonatomic) TKAlertSwipeDismissDirection dismissDirection;

@property (nonatomic) double animationDuration;

@property (nonatomic) double backgroundDim;

@end
