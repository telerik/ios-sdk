//
//  UIButton_Circle.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

extension UIButton {

    class func circleButtonInView(view: UIView, title: NSString, target: AnyObject, action: Selector) -> UIButton {
        let button : UIButton = UIButton(type:UIButtonType.Custom)

        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 0.2, alpha: 0.7)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setTitle(title as String, forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont(name: "GillSans", size: 14)
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.frame = CGRectMake((CGRectGetWidth(view.frame) - 80)/2.0 , CGRectGetHeight(view.frame)-180, 80, 80)
        
        button.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleTopMargin.rawValue | UIViewAutoresizing.FlexibleLeftMargin.rawValue | UIViewAutoresizing.FlexibleRightMargin.rawValue)
        
        view.addSubview(button)
        
        return button
    }
}
