//
//  AlertViewCustomize.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "UIButton_Circle.h"
#import "AlertCustomize.h"

@interface AlertCustomize () <TKAlertDelegate>
@end

@implementation AlertCustomize

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [UIButton circleButtonInView:self.view title:@"Show Alert" target:self action:@selector(show:)];
}

-(void)show:(id)sender
{
    TKAlert *alert = [TKAlert new];
    
    alert.delegate = self;
    alert.style.cornerRadius = 3;
    alert.title = @"Warning";
    alert.message = @"Are you ready for TKAlert?";
    alert.style.buttonSpacing = 10;
    alert.style.titleSeparatorWidth = -0.5;
    alert.style.contentSeparatorWidth = 0;
    alert.style.buttonsInset = UIEdgeInsetsMake(5, 5, 5, 5);
    alert.style.contentSeparatorWidth = 0;
    alert.style.messageColor = [UIColor colorWithRed:0.349f green:0.349f blue:0.349f alpha:1.00f];
    alert.alertView.layer.shadowOpacity = 0.6;
    alert.alertView.layer.shadowRadius = 3;
    alert.alertView.layer.shadowOffset = CGSizeMake(0, 0);
    alert.alertView.layer.masksToBounds = NO;
    alert.buttonsView.backgroundColor = [UIColor whiteColor];
    alert.style.backgroundColor = [UIColor whiteColor];
    alert.style.showAnimation = TKAlertAnimationSlideFromTop;
    // >> alert-parallax
    alert.allowParallaxEffect = YES;
    // << alert-parallax
    TKAlertAction *action = [alert addActionWithTitle:@"Yes" handler:^BOOL(TKAlert *alert, TKAlertAction* action) {
        return YES;
    }];
    action.backgroundColor = [UIColor colorWithRed:0.882f green:0.882f blue:0.882f alpha:1.00f];
    action.titleColor = [UIColor colorWithRed:0.302f green:0.302f blue:0.302f alpha:1.00f];
    action.cornerRadius = 3;
  
    action = [alert addActionWithTitle:@"No" handler:^BOOL(TKAlert *alert, TKAlertAction* action) {
        return YES;
    }];
    action.backgroundColor = [UIColor colorWithRed:0.961f green:0.369f blue:0.306f alpha:1.00f];
    action.titleColor = [UIColor whiteColor];
    action.cornerRadius = 3;
    
    [alert show:YES];
}

- (void)alertDidShow:(TKAlert *)alert
{
    TKView *view = [[TKView alloc] initWithFrame:CGRectMake(20, -30, 60, 60)];
    view.shape = [TKPredefinedShape shapeWithType:TKShapeTypeCircle andSize:CGSizeZero];
    view.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:0.961f green:0.369f blue:0.306f alpha:1.00f]];
    view.stroke = [TKStroke strokeWithColor:[UIColor whiteColor] width:3.0];
    view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [alert.alertView addSubview:view];
    

    [UIView animateWithDuration:0.7
                          delay:0.0
         usingSpringWithDamping:0.3
          initialSpringVelocity:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                     }];
}

@end
