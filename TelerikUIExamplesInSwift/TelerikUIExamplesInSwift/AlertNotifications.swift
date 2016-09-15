//
//  AlertNotificationsViewController.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class AlertNotifications: TKExamplesExampleViewController, TKListViewDelegate  {

    let listView = TKListView()
    let dataSource = TKDataSource(array: ["Error", "Warning", "Positive", "Info"])
    let titles = ["Oh no!", "Warning!", "Well done!", "Info."]
    let messages = ["Change this and try again!", "Be careful next time", "You successfully read this message", "This is TKAlert dialog"]
    let colors = [UIColor(red: 1, green: 0, blue: 0.282, alpha: 1),
                  UIColor(red:1, green:0.733, blue:0, alpha:1),
                  UIColor(red:0.478, green:0.988, blue:0.157, alpha:1),
                  UIColor(red:0.231, green:0.678, blue:1, alpha:1)]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        listView.frame = self.view.bounds
        listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        listView.dataSource = dataSource
        listView.delegate = self
        self.view.addSubview(listView)
    }

    func listView(listView: TKListView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let alert = TKAlert()

        alert.customFrame = CGRectMake(0, 0, self.view.frame.size.width, 160)
        alert.style.contentSeparatorWidth = 0
        alert.style.titleColor = UIColor.whiteColor()
        alert.style.messageColor = UIColor.whiteColor()
        alert.style.cornerRadius = 0
        alert.style.showAnimation = TKAlertAnimation.SlideFromTop
        alert.style.dismissAnimation = TKAlertAnimation.SlideFromTop
        
        // >> alert-bg-swift
        alert.style.backgroundStyle = TKAlertBackgroundStyle.None
        // << alert-bg-swift
        
        // >> alert-layout-swift
        alert.actionsLayout = TKAlertActionsLayout.Vertical
        // << alert-layout-swift
        
        alert.alertView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        // >> alert-dismiss-swift
        alert.dismissMode = TKAlertDismissMode.Tap
        // << alert-dismiss-swift
        
        alert.title = titles[indexPath.row]
        alert.message = messages[indexPath.row]
        alert.contentView.fill = TKSolidFill(color: colors[indexPath.row])
        alert.headerView.fill = TKSolidFill(color: colors[indexPath.row])
        
        if (indexPath.row > 0) {
            alert.dismissTimeout = 3.2
        } else {
            alert.dismissTimeout = 0
        }
        
        alert.show(true)
    }
}
