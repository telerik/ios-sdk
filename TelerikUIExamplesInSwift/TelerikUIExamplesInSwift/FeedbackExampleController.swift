//
//  FeedbackExampleController.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class FeedbackExampleController: ExampleViewController {
    
    @IBOutlet var descriptionLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            let bounds = UIScreen.mainScreen().bounds
            if (bounds.size.height <= 480) {
                descriptionLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 12)
            }
            else {
                descriptionLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
            }
        }

        TKFeedback.setDataSource(TKPlatformFeedbackSource(key: "58cb0070-f612-11e3-b9fc-55b0b983d3be", uid: "iosteam@telerik.com"))
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        TKFeedback.showFeedback()
    }
    
    @IBAction func sendFeedback(sender : AnyObject) {
        
        TKFeedback.showFeedback()
    }
}
