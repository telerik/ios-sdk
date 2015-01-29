//
//  InterfaceController.swift
//  AppleWatchWithTelerikChart WatchKit Extension
//
//  Created by Nikolay Diyanov on 1/28/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import WatchKit
import Foundation
import WatchCoreDataProxy


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var chartImageView: WKInterfaceImage!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.sample"
        
        let image = WatchCoreDataProxy.sharedInstance.receiveImage()
        let title = WatchCoreDataProxy.sharedInstance.receiveString()
        
        chartImageView.setImage(image)
        titleLabel.setText(title)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
