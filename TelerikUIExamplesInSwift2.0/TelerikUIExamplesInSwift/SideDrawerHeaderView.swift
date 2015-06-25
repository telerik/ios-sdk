//
//  SideDrawerHeaderView.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class SideDrawerHeaderView: UIView {
    
    let sideDrawerHeader = TKSideDrawerHeader(title: "Navigation Menu")
    
    convenience init (addButton: Bool, target: AnyObject?,selector: Selector?) {
        self.init()
        sideDrawerHeader.contentInsets = UIEdgeInsetsMake(-15, 0, 0, 0)
        if addButton {
            let button = UIButton(type:UIButtonType.System)
            button.setImage(UIImage(named: "menu"), forState: UIControlState.Normal)
            button.addTarget(target, action: selector!, forControlEvents: UIControlEvents.TouchUpInside)
            sideDrawerHeader.actionButton = button
            sideDrawerHeader.contentInsets = UIEdgeInsetsMake(-15, -20, 0, 0)
            sideDrawerHeader.buttonPosition = TKSideDrawerHeaderButtonPosition.Left
        }
        
        self.addSubview(sideDrawerHeader)
    }
    
    override func layoutSubviews() {
        sideDrawerHeader.frame = self.bounds
    }
}
