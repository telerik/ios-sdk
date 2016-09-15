//
//  AlertCustomView.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "UIButton_Circle.h"
#import "AlertCustomView.h"
#import "AlertCustomContentView.h"

@interface AlertCustomView ()
@end

@implementation AlertCustomView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIButton circleButtonInView:self.view title:@"Show Alert" target:self action:@selector(show:)];
}

-(void)show:(id)sender
{
    // >> alert-custom-content
    TKAlert *alert = [TKAlert new];
    alert.style.headerHeight = 0;
    alert.tintColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.2 alpha:1];
    alert.customFrame = CGRectMake(0, 0, 300, 250);
    AlertCustomContentView *view = [[AlertCustomContentView alloc] initWithFrame:CGRectMake(0, 0, 300, 210)];
    [alert.contentView addSubview:view];
    // << alert-custom-content
    
    alert.allowParallaxEffect = YES;
    alert.style.centerFrame = YES;
    
    // >> alert-animation
    alert.style.showAnimation = TKAlertAnimationScale;
    alert.style.dismissAnimation = TKAlertAnimationScale;
    // << alert-animation
    
    // >> alert-tint-dim
    alert.style.backgroundDimAlpha = 0.5;
    alert.style.backgroundTintColor = [UIColor lightGrayColor];
    // << alert-tint-dim
    
    // >> alert-anim-duration
    alert.animationDuration = 0.5;
    // << alert-anim-duration

    [alert addActionWithTitle:@"Done" handler:^BOOL(TKAlert *alert, TKAlertAction *action) {
        return YES;
    }];

    [alert show:YES];
}

@end
