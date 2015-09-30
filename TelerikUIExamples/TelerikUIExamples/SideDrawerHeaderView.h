//
//  SideDrawerHeaderView.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKSideDrawer;

@interface SideDrawerHeaderView : UIView

- (instancetype __nonnull)initWithButton:(BOOL)addButton target:(id)target selector:(SEL)selector;

@end
