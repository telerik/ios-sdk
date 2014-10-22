//
//  FeedbackExampleController.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class FeedbackExampleController: ExampleViewController {
    
    let platformFeedbackSource = TKPlatformFeedbackSource(key: "58cb0070-f612-11e3-b9fc-55b0b983d3be", uid: "iosteam@telerik.com")
    
    @IBOutlet var descriptionLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showDescription()
        
        let feedbackController: TKFeedbackController = UIApplication.sharedApplication().keyWindow!.rootViewController as TKFeedbackController
        feedbackController.dataSource = platformFeedbackSource
    }
    
    @IBAction func sendFeedback(sender : AnyObject) {
        let feedbackController = self.view.window?.rootViewController as TKFeedbackController
        feedbackController.showFeedback()
    }
    
    func showDescription() {
        if UIDevice.currentDevice().userInterfaceIdiom != .Phone {
            return
        }
        
        let bounds = UIScreen.mainScreen().bounds
        if (bounds.size.height <= 480) {
            descriptionLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 12)
            return
        }
        descriptionLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
    }
}
