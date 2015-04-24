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
                         self.sideDrawer.center = CGPointMake(_sideDrawerIndentityCenter.x, _sideDrawerIndentityCenter.y + self.sideDrawer.bounds.size.height);
                         self.sideDrawer.hostview.center = CGPointMake(_hostviewIdentityCenter.x + self.sideDrawer.width, _hostviewIdentityCenter.y);
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
                         self.sideDrawer.center = _sideDrawerIndentityCenter;
                         self.sideDrawer.hostview.center = _hostviewIdentityCenter;
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
