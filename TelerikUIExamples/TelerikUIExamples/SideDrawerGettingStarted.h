//
//  SideDrawerGettingStarted.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TKExamplesKit.h>
#import <TelerikUI/TelerikUI.h>

@interface SideDrawerGettingStarted : TKExamplesExampleViewController <TKSideDrawerDelegate>

@property (nonatomic,strong) TKSideDrawerView *sideDrawerView;

@property (nonatomic, strong) UINavigationItem *navItem;

- (void)showSideDrawer;

- (void)dismissSideDrawer;

@end
