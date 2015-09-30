//
//  AlertViewSettings.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class AlertSettings: ExampleViewController, TKAlertDelegate, TKDataFormDelegate {
    
    let settings: Settings = Settings()
    let dataForm: TKDataForm = TKDataForm()
    let dataSource: TKDataFormEntityDataSource = TKDataFormEntityDataSource()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Show Alert") { self.show() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            dataForm.frame = self.exampleBounds
            self.view.backgroundColor = UIColor(red:0.937, green:0.937, blue:0.957, alpha:1.00)
        }
        else {
            dataForm.frame = self.view.bounds
        }
        dataForm.delegate = self
        dataForm.commitMode = TKDataFormCommitMode.Manual
        dataForm.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(dataForm)
        
        dataSource.sourceObject = self.settings

        dataForm.registerEditor(TKDataFormSegmentedEditor.self, forProperty: "dismissDirection")
        dataForm.registerEditor(TKDataFormSegmentedEditor.self, forProperty: "dismissMode")
        dataForm.registerEditor(TKDataFormSegmentedEditor.self, forProperty: "actionsLayout")
        dataForm.registerEditor(TKDataFormSegmentedEditor.self, forProperty: "backgroundStyle")
        dataForm.registerEditor(TKDataFormSwitchEditor.self, forProperty: "allowParallax")
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
    
    //MARK: - TKDataFormDelegate
 
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        if(property.name == "actionsLayout") {
            let segmentedEditor = editor as! TKDataFormSegmentedEditor
            segmentedEditor.options = ["Horizontal", "Vertical"]
        }
        
        if(property.name == "backgroundStyle") {
            let segmentedEditor = editor as! TKDataFormSegmentedEditor
            segmentedEditor.options = ["Blur", "Dim"];
        }
        
        if(property.name == "dismissMode") {
            let segmentedEditor = editor as! TKDataFormSegmentedEditor
            segmentedEditor.options = ["None", "Tap", "Swipe"];
        }

        if(property.name == "dismissDirection"){

            let segmentedEditor = editor as! TKDataFormSegmentedEditor
            segmentedEditor.options = ["Horizontal", "Vertical"];
        }
    }
}
