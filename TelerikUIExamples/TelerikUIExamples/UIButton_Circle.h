//
//  UIButton_Circle.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButton_Circle)

+ (UIButton*)circleButtonInView:(UIView *)view title:(NSString*)title target:(id)target action:(SEL)action;

@end

@implementation UIButton (UIButton_Circle)

+ (UIButton*)circleButtonInView:(UIView *)view title:(NSString*)title target:(id)target action:(SEL)action;
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor colorWithRed:0.5 green:0.7 blue:0.2 alpha:0.7]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"GillSans" size:14];
    button.layer.cornerRadius = 40;
    button.clipsToBounds = YES;
    button.frame = CGRectMake((CGRectGetWidth(view.frame)-80)/2., CGRectGetHeight(view.frame)-180, 80, 80);
    button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [view addSubview:button];
    
    return button;
}

@end

