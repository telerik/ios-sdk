//
//  AlertViewSettings.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class AlertSettings: TKExamplesExampleViewController, TKAlertDelegate, TKDataFormDelegate {
    
    let settings: AlertSettingsInfo = AlertSettingsInfo()
    let dataForm: TKDataForm = TKDataForm()
    let dataSource: TKDataFormEntityDataSource = TKDataFormEntityDataSource()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Show Alert", action: show)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            dataForm.frame = self.view.bounds
            self.view.backgroundColor = UIColor(red:0.937, green:0.937, blue:0.957, alpha:1.00)
        }
        else {
            dataForm.frame = self.view.bounds
        }
        
        dataSource.sourceObject = self.settings
        
        dataSource["dismissDirection"].editorClass = TKDataFormSegmentedEditor.self
        dataSource["dismissDirection"].valuesProvider = ["Horizontal", "Vertical"]
        dataSource["dismissMode"].editorClass = TKDataFormSegmentedEditor.self
        dataSource["dismissMode"].valuesProvider = ["None", "Tap", "Swipe"]
        dataSource["actionsLayout"].editorClass = TKDataFormSegmentedEditor.self
        dataSource["actionsLayout"].valuesProvider =  ["Horizontal", "Vertical"]
        dataSource["backgroundStyle"].editorClass = TKDataFormSegmentedEditor.self
        dataSource["backgroundStyle"].valuesProvider = ["Blur", "Dim"]
        
        dataForm.delegate = self
        dataForm.commitMode = TKDataFormCommitMode.Manual
        dataForm.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(dataForm)
        

        dataForm.dataSource = dataSource;
    }
    
    func show()
    {
        dataForm.commit()
        let alert : TKAlert = TKAlert()
        alert.title = settings.title
        alert.message = settings.message
        alert.allowParallaxEffect = settings.allowParallax
        alert.style.backgroundStyle = settings.backgroundStyle
        alert.actionsLayout = settings.actionsLayout
        alert.dismissMode = settings.dismissMode
        alert.swipeDismissDirection = settings.dismissDirection
        alert.animationDuration = settings.animationDuration
        alert.style.backgroundDimAlpha = settings.backgroundDim

        alert.addActionWithTitle("Shake") { (TKAlert, TKAlertAction) -> Bool in
            alert.shake()
            return false
        }
        
        alert.addActionWithTitle("Touch") { (TKAlert, TKAlertAction) -> Bool in
            
            return false
        }
        
        alert.addActionWithTitle("Close") { (TKAlert, TKAlertAction) -> Bool in
            NSLog("closed")
            return true
        }
        
        alert.show(true);
    }
}
