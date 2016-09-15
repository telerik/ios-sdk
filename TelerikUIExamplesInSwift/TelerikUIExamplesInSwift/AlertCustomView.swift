//
//  CustomView.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation

class AlertCustomView: TKExamplesExampleViewController, TKAlertDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UIButton.circleButtonInView(self.view, title: "Show Alert", target: self, action: #selector(AlertCustomView.show(_:)))
    }
    
    func show(sender: AnyObject) {
        // >> alert-custom-content-swift
        let alert = TKAlert()
        alert.style.headerHeight = 0
        alert.tintColor = UIColor(red: 0.5, green: 0.7, blue: 0.2, alpha: 1)
        alert.customFrame = CGRectMake((self.view.frame.size.width - 300)/2, 100, 300, 250)
        let view = AlertCustomContentView(frame: CGRectMake(0, 0, 300, 210))
        alert.contentView.addSubview(view)
        // << alert-custom-content-swift
        
        alert.style.centerFrame = true
        
        // >> alert-animation-swift
        alert.style.showAnimation = TKAlertAnimation.Scale;
        alert.style.dismissAnimation = TKAlertAnimation.Scale;
        // << alert-animation-swift

        // >> alert-tint-dim-swift
        alert.style.backgroundDimAlpha = 0.5;
        alert.style.backgroundTintColor = UIColor.lightGrayColor()
        // << alert-tint-dim-swift
        
        // >> alert-anim-duration-swift
        alert.animationDuration = 0.5;
        // << alert-anim-duration-swift
        
        alert.addActionWithTitle("Done") { (TKAlert, TKAlertAction) -> Bool in
            return true
        }
        
        alert.show(true)
    }
}

