//
//  AlertViewGettingStarted.swift
//  TelerikUIExamplesInSwift
//
//  Created by Sophia Lazarova on 6/11/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation

class AlertViewGettingStarted: ExampleViewController {

    var _alert: TKAlert?
    var _textLabel: UILabel?

    override func viewDidLoad() {
    
        self.view.backgroundColor = UIColor.whiteColor()
        self._alert = TKAlert()
        self._alert!.title = "Title"
        self._alert!.message = "This is the message of our getting started example"
        //(title: "Title", message: , delegate: self, cancelActionTitle: "Cancel", otherActionTitles: "Accept")
        self._alert!.style.cornerRadius = 10
//        self._alert!.actionAtIndex(1).handler = //= (TKAlert alert, TKAlertAction action); -> Bool { self._textLabel!.text = "Accepted"; return true }
//        self._alert!.actionAtIndex(0).handler = { (TKAlert alert, TKAlertAction action) -> self._textLabel!.text = "Canceled"}
        self._alert!.animationDuration = 0.4
        self._textLabel = UILabel(frame: CGRectMake(120, 100, 100, 20))
        self._textLabel!.textColor = UIColor.blackColor()
        self.view.addSubview(self._textLabel!)
        
        let button: UIButton = UIButton(type:UIButtonType.System)
        button.addTarget(self, action: "show:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("Show Alert", forState: UIControlState.Normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 0.2, alpha: 0.7)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "GillSans", size: 18)
        button.frame = CGRectMake((self.view.frame.size.width - 160)/2, 450.0, 160.0, 80.0)
        button.layer.cornerRadius = 80
        button.clipsToBounds = true
        self.view.addSubview(button)
    }
    
    func show(sender: AnyObject) {
        self._alert?.show(true)
    }
}
