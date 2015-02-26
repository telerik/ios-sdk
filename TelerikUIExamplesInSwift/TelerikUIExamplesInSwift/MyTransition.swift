//
//  MyTransition.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class MyTransition: TKSideDrawerTransition {
    
    
    override func show() {
        if !self.sideDrawer.isVisible {
            self.sideDrawer.frame = CGRectMake(0, -self.sideDrawer.superview!.frame.size.height, self.sideDrawer.width, self.sideDrawer.superview!.frame.size.height)
        }
        
        self.transitionBegan(true)
        UIView.animateWithDuration(0.36, animations: {
            self.sideDrawer.hostview.frame = CGRectMake(self.sideDrawer.width, 0, self.sideDrawer.superview!.frame.size.width, self.sideDrawer.frame.size.height)
            }, completion: { (bool finished) -> Void in
                UIView.animateWithDuration(0.36, animations: {
                    self.sideDrawer.frame = CGRectMake(0, 0, self.sideDrawer.width, self.sideDrawer.frame.size.height)
                    }, completion: { (bool finished) -> Void in
                        self.transitionEnded(true)
                })
        })
    }
    
    override func dismiss() {
        self.transitionBegan(false)
        UIView.animateWithDuration(0.36, animations: {
            self.sideDrawer.frame = CGRectMake(0, -self.sideDrawer.frame.size.height, self.sideDrawer.width, self.sideDrawer.frame.size.height)
            }, completion: { (bool finished) -> Void in
                UIView.animateWithDuration(0.36, animations: {
                    self.sideDrawer.hostview.frame = CGRectMake(0, 0, self.sideDrawer.superview!.frame.size.width, self.sideDrawer.superview!.frame.size.height)
                    }, completion: { (bool finished) -> Void in
                        self.transitionEnded(false)
                })
        })
    }
    
    override func transitionBegan(showing: Bool) {
        if showing {
            self.sideDrawer.hidden = false
            self.sideDrawer.hostview.userInteractionEnabled = false
        }
    }
    
    override func transitionEnded(showing: Bool) {
        if !showing {
            self.sideDrawer.hidden = true
            self.sideDrawer.hostview.userInteractionEnabled = true
        }
    }
}
