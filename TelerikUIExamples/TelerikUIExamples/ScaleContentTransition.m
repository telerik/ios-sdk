//
//  ScaleContentTransition.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "ScaleContentTransition.h"

@implementation ScaleContentTransition
{
    BOOL _isAnimating;
}

- (void)show
{
    if (!self.sideDrawer.isVisible) {
        self.sideDrawer.frame = CGRectMake(0, 0, self.sideDrawer.width, self.sideDrawer.superview.frame.size.height);
    }
    
    [self transitionBegan:YES];
    [UIView animateWithDuration:0.36
                     animations:^{
                         self.sideDrawer.hostview.transform = CGAffineTransformMakeScale(0.85, 0.85);
                         self.sideDrawer.hostview.frame = CGRectMake(self.sideDrawer.width, 44, self.sideDrawer.hostview.frame.size.width, self.sideDrawer.hostview.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [self transitionEnded:YES];
                     }];
}

- (void)dismiss
{
    [self transitionBegan:NO];
    [UIView animateWithDuration:0.36
                     animations:^{
                         self.sideDrawer.hostview.transform = CGAffineTransformIdentity;
                         self.sideDrawer.hostview.frame = CGRectMake(0, 0, self.sideDrawer.hostview.frame.size.width, self.sideDrawer.hostview.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [self transitionEnded:NO];
                     }];
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (_isAnimating) {
        return;
    }
    
    if (!self.sideDrawer.isVisible) {
        self.sideDrawer.frame = CGRectMake(0, 0, self.sideDrawer.width, self.sideDrawer.superview.frame.size.height);
        [self.sideDrawer.superview bringSubviewToFront:self.sideDrawer.hostview];
        self.sideDrawer.hidden = NO;
    }

    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [self handlePan:(UIPanGestureRecognizer *)gestureRecognizer];
        [(UIPanGestureRecognizer *)gestureRecognizer setTranslation:CGPointZero inView:self.sideDrawer.superview];
    }
 
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.sideDrawer.hostview.frame.origin.x > self.sideDrawer.width / 2.) {
            [self show];
        }
        else {
            [self dismiss];
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    CGRect hostFrame = self.sideDrawer.hostview.frame;
    CGRect bounds = self.sideDrawer.superview.bounds;
    CGPoint translation = [gesture translationInView:[self.sideDrawer superview]];
    CGFloat originX = hostFrame.origin.x + translation.x;
    
    CGFloat scaleFactor = [self calculateScaleFactor];
    self.sideDrawer.hostview.transform = CGAffineTransformMakeScale(1 - scaleFactor, 1 - scaleFactor);
    
    BOOL didPanToInitialFrame = (translation.x < 0 && originX <= bounds.origin.x);
    if (didPanToInitialFrame) {
        self.sideDrawer.hostview.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
        return;
    }
    
    BOOL didPanToFinalFrame = (translation.x > 0 && originX >= self.sideDrawer.width);
    if (didPanToFinalFrame) {
        self.sideDrawer.hostview.frame = CGRectMake(self.sideDrawer.width, 44, self.sideDrawer.hostview.frame.size.width, self.sideDrawer.hostview.frame.size.height);
        return;
    }
    
    self.sideDrawer.hostview.center = CGPointMake(self.sideDrawer.hostview.center.x + translation.x, self.sideDrawer.hostview.center.y);
}

- (CGFloat)calculateScaleFactor
{
    CGFloat offset = self.sideDrawer.superview.bounds.size.width - (self.sideDrawer.superview.bounds.size.width - self.sideDrawer.hostview.frame.origin.x);
    CGFloat spp = (1.0 - 0.85) / self.sideDrawer.width;
    return offset * spp;
}

- (void)transitionBegan:(BOOL)showing
{
    _isAnimating = YES;
    if (showing) {
        self.sideDrawer.hidden = NO;
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
    }
}

@end
