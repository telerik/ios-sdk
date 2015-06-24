//
//  CustomView.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation

class AlertCustomView: ExampleViewController, TKAlertDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        UIButton.circleButtonInView(self.view, title: "Show Alert", target: self, action: "show:")
    }
    
    func show(sender: AnyObject) {
        
        let alert = TKAlert()
        
        alert.style.headerHeight = 0
        alert.tintColor = UIColor(red: 0.5, green: 0.7, blue: 0.2, alpha: 1)
        alert.customFrame = CGRectMake((self.view.frame.size.width - 300)/2, 100, 300, 250)
        alert.style.centerFrame = true
        
        let view = AlertCustomContentView(frame: CGRectMake(0, 0, 300, 210))
        alert.contentView.addSubview(view)
        
        alert.addActionWithTitle("Done") { (TKAlert, TKAlertAction) -> Bool in
            return true
        }
        
        alert.show(true)
    }
}

