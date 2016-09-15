//
//  AlertGettingStarted.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "AlertGettingStarted.h"
#import "UIButton_Circle.h"

@interface AlertGettingStarted ()
@end

@implementation AlertGettingStarted
{
    UILabel* _textLabel;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 44)];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    _textLabel.text = @"Please, answer the question!";
    [self.view addSubview:_textLabel];

    [UIButton circleButtonInView:self.view title:@"Answer me" target:self action:@selector(show:)];
}

-(void)show:(id)sender
{
// >> getting-started-alert
    TKAlert *alert = [TKAlert new];
    alert.title = @"Chicken or the egg";
    alert.message = @"Which came first, the chicken or the egg?";
// << getting-started-alert
    
    alert.style.maxWidth = 210;
    alert.dismissMode = TKAlertDismissModeSwipe;
    alert.swipeDismissDirection = TKAlertSwipeDismissDirectionVertical;
    
// >> getting-started-alert-action
    [alert addActionWithTitle:@"Egg" handler:^BOOL (TKAlert *alert, TKAlertAction* action) {
        _textLabel.text = @"It was the egg!";
        return YES;
    }];

    [alert addActionWithTitle:@"Chicken" handler:^BOOL (TKAlert *alert, TKAlertAction* action) {
        _textLabel.text = @"It was the chicken!";
        return YES;
    }];
// << getting-started-alert-action
    
// >> getting-started-alert-show
    [alert show:YES];
// << getting-started-alert-show
}


@end
