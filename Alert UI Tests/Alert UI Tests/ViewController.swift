//
//  ViewController.swift
//  Alert UI Tests
//
//  Created by Miroslava Ivanova on 8/18/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: UIButtonType.Custom)
        button.addTarget(self, action: "show:", forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 0.2, alpha: 0.7)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setTitle("Answer me", forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont(name: "GillSans", size: 14)
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 80)/2.0 , CGRectGetHeight(self.view.frame)-180, 80, 80)
        self.view.addSubview(button)
        
        textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 44)
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.text = "Please, answer the question"
        self.view.addSubview(textLabel)
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

