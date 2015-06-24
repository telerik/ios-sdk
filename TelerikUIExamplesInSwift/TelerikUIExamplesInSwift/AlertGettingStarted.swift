//
//  AlertGettingStarted.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class AlertGettingStarted: ExampleViewController {

    let textLabel = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 44);
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleBottomMargin
        textLabel.text = "Please, answer the question?"
        self.view.addSubview(textLabel);
        
        UIButton.circleButtonInView(self.view, title: "Answer me", target: self, action: "show:")
    }
    
    func show(sender: AnyObject) {

        let alert = TKAlert()
        
        alert.title = "Chicken or the egg?"
        alert.message = "Which came first, the chicken or the egg?"
        alert.style.maxWidth = 210
        alert.dismissMode = TKAlertDismissMode.Swipe

        alert.addActionWithTitle("Egg") { (TKAlert, TKAlertAction) -> Bool in
            self.textLabel.text = "It was the egg"
            return true
        }
        
        alert.addActionWithTitle("Chicken") { (TKAlert, TKAlertAction) -> Bool in
            self.textLabel.text = "It was the chiken"
            return true
        }
        alert.show(true)
    }
    
}
