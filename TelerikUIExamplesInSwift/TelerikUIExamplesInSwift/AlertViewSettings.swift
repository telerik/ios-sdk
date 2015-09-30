//
//  AlertViewSettings.swift
//  TelerikUIExamplesInSwift
//
//  Created by Sophia Lazarova on 6/11/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation

class AlertViewSettings: ExampleViewController, TKDataFormDelegate {
    var _alert: TKAlert?
    var _dataForm: TKDataForm?
    var _settings: AlertSettings?
    
    override func viewDidLoad() {
        
        _settings = AlertSettings()
        _dataForm = TKDataForm(frame: self.view.bounds)
        self.view.addSubview(self._dataForm!)
        _dataForm?.delegate = self
        
        let dataSource =  _dataForm?.dataSource as! TKDataFormDefaultDataSource
        dataSource.selectedObject = _settings
        
        
//        TKDataFormDefaultDataSource* dataSource = ((TKDataFormDefaultDataSource*)_dataForm.dataSource);
//        dataSource.selectedObject = _settings;

        let layoutProperty = dataSource.entityModel.propertyWithName("buttonsLayout")
        let backgroundProperty = dataSource.entityModel.propertyWithName("backgroundStyle")

        _dataForm?.registerEditor(TKDataFormSegmentedEditor.self, forProperty: layoutProperty)
        _dataForm?.registerEditor(TKDataFormSegmentedEditor.self, forProperty: backgroundProperty)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        _alert = TKAlert()
        
        _alert?.style.backgroundDimAlpha = 0.5
        _alert?.style.appearAnimation = TKAlertAnimation.Scale
        _alert?.customFrame = CGRectMake(100, 100, 150, 200)
        
        let attributedMessage = NSMutableAttributedString(string: "TKAlert settings")
        attributedMessage.addAttribute(NSFontAttributeName, value: UIFont(name: "GillSans", size: 14)!, range: NSMakeRange(0, 16))
        
        _alert?.attributedMessage = attributedMessage
        let attributedTitle = NSMutableAttributedString(string: "Title")
        attributedTitle.addAttribute(NSFontAttributeName, value: UIFont(name: "GillSans", size: 14)!, range: NSMakeRange(0, 5))
        _alert?.attributedTitle = attributedTitle
        _alert?.addAction(TKAlertAction(title: "One", handler: { (TKAlert alert, TKAlertAction action) -> Bool in
            return true
        }))
        _alert?.addAction(TKAlertAction(title: "Two", handler: { (TKAlert alert, TKAlertAction action) -> Bool in
            return true
        }))
        let button = UIButton(type: UIButtonType.System)
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
    
    func show(sender: AnyObject)
    {
        _alert?.style.backgroundStyle = _settings!.backgroundStyle!
        _alert?.title = _settings!.title! as String
        _alert?.actionsLayout = _settings!.actionsLayout!
        _alert?.message = _settings!.message! as String
        _alert?.show(true)
    }
    
    func dataForm(dataForm: TKDataForm!, updateEditor editor: TKDataFormEditor!, forProperty property: TKDataFormEntityProperty!) {
        if(property.name == "buttonsLayout") {
            let segmentedEditor = editor as! TKDataFormSegmentedEditor
            let segmentedControl = segmentedEditor.editor() as! UISegmentedControl
            
            segmentedControl.insertSegmentWithTitle("Horizontal", atIndex: 0, animated: false)
            segmentedControl.insertSegmentWithTitle("Vertical", atIndex: 1, animated: false)
        }
        
        if(property.name == "backgroundStyle"){
            let segmentedEditor = editor as! TKDataFormSegmentedEditor
            let segmentedControl = segmentedEditor.editor() as! UISegmentedControl
            
            segmentedControl.insertSegmentWithTitle("Blur", atIndex: 0, animated: false)
            segmentedControl.insertSegmentWithTitle("Dim", atIndex: 1, animated: false)
        }
    }
}
