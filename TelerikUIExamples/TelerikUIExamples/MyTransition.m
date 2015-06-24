//
//  MyTransition.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "MyTransition.h"

@implementation MyTransition
{
    BOOL _isAnimating;
    CGPoint _sideDrawerIndentityCenter;
    CGPoint _hostviewIdentityCenter;
}

- (void)show
{
    if (!self.sideDrawer.isVisible) {
        self.sideDrawer.frame = CGRectMake(0, -self.sideDrawer.superview.bounds.size.height, self.sideDrawer.width, self.sideDrawer.superview.bounds.size.height);
        self.sideDrawer.hidden = NO;
        _sideDrawerIndentityCenter = self.sideDrawer.center;
        _hostviewIdentityCenter = self.sideDrawer.hostview.center;
    }
    
    [self transitionBegan:YES];
    [UIView animateWithDuration:self.sideDrawer.transitionDuration
                     animations:^{
                         self.sideDrawer.center = CGPointMake(self.sideDrawer.width / 2.0, CGRectGetMidY(self.sideDrawer.superview.bounds));
                         self.sideDrawer.hostview.center = CGPointMake(self.sideDrawer.hostview.center.x + self.sideDrawer.width, self.sideDrawer.hostview.center.y);
                     }
                     completion:^(BOOL finished){
                         [self transitionEnded:YES];
                     }];
}

- (void)dismiss
{
    [self transitionBegan:NO];
    [UIView animateWithDuration:self.sideDrawer.transitionDuration
                     animations:^{
                         self.sideDrawer.center = CGPointMake(self.sideDrawer.width / 2.0, -self.sideDrawer.frame.size.height / 2.0);
                         self.sideDrawer.hostview.center = CGPointMake(CGRectGetMidX(self.sideDrawer.hostview.superview.bounds),
                                                                       CGRectGetMidY(self.sideDrawer.hostview.superview.bounds));
                     }
                     completion:^(BOOL finished){
                         [self transitionEnded:NO];
                     }];
}

- (void)transitionBegan:(BOOL)showing
{
    _isAnimating = YES;
    if (showing) {
        self.sideDrawer.hostview.userInteractionEnabled = NO;
        [self.sideDrawer.superview bringSubviewToFront:self.sideDrawer.hostview];
    }
}

- (void)transitionEnded:(BOOL)showing
{
    _isAnimating = NO;
    if (!showing) {
        self.sideDrawer.hidden = YES;
        self.sideDrawer.hostview.userInteractionEnabled = YES;
        if ([self.sideDrawer.delegate respondsToSelector:@selector(didDismissSideDrawer:)]) {
            [self.sideDrawer.delegate didDismissSideDrawer:self.sideDrawer];
        }
    }
    else {
        if ([self.sideDrawer.delegate respondsToSelector:@selector(didShowSideDrawer:)]) {
            [self.sideDrawer.delegate didShowSideDrawer:self.sideDrawer];
        }
    }
}

@end
