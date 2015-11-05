//
//  AlertCustomize.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class AlertCustomize: ExampleViewController, TKAlertDelegate {

    override func viewDidLoad() {

        super.viewDidLoad()
        
        UIButton.circleButtonInView(self.view, title: "Show Alert", target: self, action: "show:")
    }
    
    func show(sender: AnyObject) {
        
        let alert = TKAlert()

        alert.delegate = self
        alert.style.cornerRadius = 3
        alert.title = "Warning"
        alert.message = "Do you really like TKAlertView?"
        alert.style.buttonSpacing = 10
        alert.style.buttonsInset = UIEdgeInsetsMake(5, 5, 5, 5)
        alert.style.contentSeparatorWidth = 0
        alert.style.messageColor = UIColor(red:0.349, green:0.349, blue:0.349, alpha:1.00)
        alert.style.titleSeparatorWidth = -0.5
        alert.style.contentSeparatorWidth = 0
        alert.alertView.layer.shadowOpacity = 0.6
        alert.alertView.layer.shadowRadius = 3
        alert.alertView.layer.shadowOffset = CGSizeMake(0, 0)
        alert.alertView.layer.masksToBounds = false
        alert.style.backgroundColor = UIColor.whiteColor()
        alert.buttonsView.backgroundColor = UIColor.whiteColor()
        alert.style.showAnimation = TKAlertAnimation.SlideFromTop
        
        var action = alert.addActionWithTitle("Yes") { (TKAlert, TKAlertAction) -> Bool in
            return true
        }
        
        action.backgroundColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1.00)
        action.titleColor = UIColor(red: 0.302, green: 0.302, blue: 0.302, alpha: 1.00)
        action.cornerRadius = 3
        
        action = alert.addActionWithTitle("No") { (TKAlert, TKAlertAction) -> Bool in
            return true
        }
        action.backgroundColor = UIColor(red: 0.961, green: 0.369, blue: 0.306, alpha: 1.00)
        action.titleColor = UIColor.whiteColor()
        action.cornerRadius = 3
        
        alert.show(true)
    }
    
    //MARK: - TKAlertDelegate
    
    func alertDidShow(alert: TKAlert) {
        
        let view = TKView(frame: CGRectMake(20, -30, 60, 60))
        view.shape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeZero)
        view.fill = TKSolidFill(color: UIColor(red: 0.961, green: 0.369, blue: 0.306, alpha: 1.00))
        view.stroke = TKStroke(color: UIColor.whiteColor(), width: 3.0)
        view.transform = CGAffineTransformMakeScale(0.1, 0.1)
        alert.alertView.addSubview(view)

        UIView.animateWithDuration(0.7,
            delay: 0.0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0.3,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: { () -> Void in
                view.transform = CGAffineTransformIdentity
            }) { (Bool) -> Void in }
    }
}
