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
    TKAlert *alert = [TKAlert new];
    
    alert.style.headerHeight = 0;
    alert.tintColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.2 alpha:1];
    alert.customFrame = CGRectMake(0, 0, 300, 250);
    alert.allowParallaxEffect = YES;
    alert.style.centerFrame = YES;
    
    AlertCustomContentView *view = [[AlertCustomContentView alloc] initWithFrame:CGRectMake(0, 0, 300, 210)];
    [alert.contentView addSubview:view];

    [alert addActionWithTitle:@"Done" handler:^BOOL(TKAlert *alert, TKAlertAction *action) {
        return YES;
    }];

    [alert show:YES];
}

@end
