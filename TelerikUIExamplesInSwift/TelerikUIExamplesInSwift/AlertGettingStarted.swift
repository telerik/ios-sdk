//
//  AlertGettingStarted.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class AlertGettingStarted: TKExamplesExampleViewController {

    let textLabel = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 44);
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleBottomMargin.rawValue)
        textLabel.text = "Please, answer the question?"
        self.view.addSubview(textLabel);
        
        UIButton.circleButtonInView(self.view, title: "Answer me", target: self, action: #selector(AlertGettingStarted.show(_:)))
    }
    
    func show(sender: AnyObject) {
// >> getting-started-alert-swift
        let alert = TKAlert()
        alert.title = "Chicken or the egg?"
        alert.message = "Which came first, the chicken or the egg?"
// << getting-started-alert-swift
        
        alert.style.maxWidth = 210
        alert.dismissMode = TKAlertDismissMode.Swipe
        
// >> getting-started-alert-action-swift
        alert.addActionWithTitle("Egg") { (TKAlert, TKAlertAction) -> Bool in
            self.textLabel.text = "It was the egg"
            return true
        }

        alert.addActionWithTitle("Chicken") { (TKAlert, TKAlertAction) -> Bool in
            self.textLabel.text = "It was the chiken"
            return true
        }
// << getting-started-alert-action-swift
        
// >> getting-started-alert-show-swift
        alert.show(true)
// << getting-started-alert-show-swift
    }
    
}
