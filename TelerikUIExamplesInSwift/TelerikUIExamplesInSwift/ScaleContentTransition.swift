//
//  ScaleContentTransition.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class ScaleContentTransition: TKSideDrawerTransition {

    var isAnimating = false;
    
    override func show() {
        if !self.sideDrawer.isVisible {
            self.sideDrawer.frame = CGRectMake(0, 0, self.sideDrawer.width, self.sideDrawer.superview!.frame.size.height)
        }
        
        self.transitionBegan(true)
        UIView.animateWithDuration(0.36,
            animations: {
                self.sideDrawer.hostview.transform = CGAffineTransformMakeScale(0.85, 0.85)
                self.sideDrawer.hostview.frame = CGRectMake(self.sideDrawer.width, self.sideDrawer.hostview.frame.origin.y, self.sideDrawer.hostview.frame.size.width, self.sideDrawer.hostview.frame.size.height)
            },
            completion: {
                (bool finished) -> Void in
                self.transitionEnded(true)
        })
    }
    
    override func dismiss() {
        self.transitionBegan(false)
        UIView.animateWithDuration(0.36,
            animations: {
                self.sideDrawer.hostview.transform = CGAffineTransformIdentity
                self.sideDrawer.hostview.frame = CGRectMake(0, 0, self.sideDrawer.hostview.frame.size.width, self.sideDrawer.hostview.frame.size.height)
            },
            completion: {
                (bool finished) -> Void in
                self.transitionEnded(false)
        })
    }
    
    override func handleGesture(gestureRecognizer: UIGestureRecognizer!) {
        
        if self.isAnimating {
            return;
        }
        
        if !self.sideDrawer.isVisible {
            self.sideDrawer.hidden = false;
        }
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began && !self.sideDrawer.isVisible {
            self.sideDrawer.frame = CGRectMake(0, 0, self.sideDrawer.width, self.sideDrawer.superview!.frame.size.height)
        }
        
        if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            self.handlePan(gestureRecognizer as UIPanGestureRecognizer)
            (gestureRecognizer as UIPanGestureRecognizer).setTranslation(CGPointZero, inView: self.sideDrawer.superview)
        }
        
        if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if self.sideDrawer.hostview.frame.origin.x > self.sideDrawer.width / 2.0 {
                self.show()
            }
            else {
                self.dismiss()
            }
            
        }
    }
    
    func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        let hostFrame = self.sideDrawer.hostview.frame
        let bounds = self.sideDrawer.superview!.bounds
        let translation = gestureRecognizer.translationInView(self.sideDrawer.superview!)
        let originX = hostFrame.origin.x + translation.x
        
        let scaleFactor = self.calculateScaleFactor()
        self.sideDrawer.hostview.transform = CGAffineTransformMakeScale(1 - scaleFactor, 1 - scaleFactor)
        
        let didPanToInitialFrame = (translation.x < 0 && originX < bounds.origin.x)
        if didPanToInitialFrame {
            self.sideDrawer.hostview.frame = bounds
            return
        }
        
        let didPanToFinalFrame = (translation.x > 0 && originX > self.sideDrawer.width)
        if didPanToFinalFrame {
            self.sideDrawer.hostview.frame = CGRectMake(self.sideDrawer.width, hostFrame.origin.y, hostFrame.size.width, hostFrame.size.height)
            return
        }
        
        self.sideDrawer.hostview.center = CGPointMake(self.sideDrawer.hostview.center.x + translation.x, self.sideDrawer.hostview.center.y)
    }
    
    func calculateScaleFactor() -> CGFloat {
        let offset = self.sideDrawer.superview!.bounds.size.width - (self.sideDrawer.superview!.bounds.size.width - self.sideDrawer.hostview.frame.origin.x)
        let spp = (1.0 - 0.85) / self.sideDrawer.width
        return offset * spp
    }
    
    override func transitionBegan(showing: Bool) {
        self.isAnimating = true;
        if showing {
            self.sideDrawer.hidden = false
            self.sideDrawer.superview!.bringSubviewToFront(self.sideDrawer.hostview)
            self.sideDrawer.hostview.userInteractionEnabled = false
        }
    }
    
    override func transitionEnded(showing: Bool) {
        self.isAnimating = false;
        if !showing {
            self.sideDrawer.hidden =  true
            self.sideDrawer.superview!.bringSubviewToFront(self.sideDrawer.hostview)
            self.sideDrawer.hostview.userInteractionEnabled = true
        }
    }
}
