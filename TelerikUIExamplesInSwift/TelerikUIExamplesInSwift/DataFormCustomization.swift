//
//  DataFormCustomization.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DataFormCustomization: TKDataFormViewController {

    let dataSource = TKDataFormEntityDataSource()
    let reservationForm = ReservationForm()
    let btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        dataSource.sourceObject = reservationForm
    
        let name = dataSource["name"]
        name.hintText = "Name"
        name.errorMessage = "Please fill in the guest name"
        name.image = UIImage(named: "guest-name")
        
        let phone = dataSource["phone"]
        phone.hintText = "Phone"
        phone.image = UIImage(named: "phone")
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "h:mm a";
        dataSource["time"].formatter = formatter
        
        dataSource["date"].image = UIImage(named: "calendar")
        dataSource["time"].image = UIImage(named: "time")
        dataSource["guests"].image = UIImage(named: "guest-number")
        dataSource["table"].image = UIImage(named: "table-number")
        
        dataSource["time"].editorClass = TKDataFormTimePickerEditor.self
        dataSource["phone"].editorClass = CallEditor.self
        dataSource["origin"].editorClass = TKDataFormSegmentedEditor.self
        
        dataSource["guests"].valuesProvider = TKRange(minimum: 1, andMaximum: 10)
        dataSource["section"].valuesProvider = [ "Section 1", "Section 2", "Section 3", "Section 4" ]
        dataSource["table"].valuesProvider = [Int](1...15)
        dataSource["origin"].valuesProvider = [ "phone", "in-person", "online", "other" ]

        for  i in 0 ..< dataSource.properties.count {
            let property: TKEntityProperty = dataSource.properties[i] as! TKEntityProperty
            if property.name == "section" || property.name == "table" {
                property.groupName = "TABLE DETAILS";
            }
            else if property.name == "origin" || property.name == "cancelReservation" {
                property.groupName = "ORIGIN";
            }
            else {
                property.groupName = "RESERVATION DETAILS";
            }
        }
        
        self.dataForm.dataSource = dataSource
        self.dataForm.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 66)
        self.dataForm.backgroundColor = UIColor(patternImage: UIImage(named: "wood-pattern")!)
        self.dataForm.tintColor = UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0)
        
        btn.frame = CGRect(x: 0, y: self.dataForm.frame.size.height, width: self.view.bounds.size.width, height: 66)
        btn.setTitle("Cancel reservation", forState: .Normal)
        btn.setTitleColor(UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0), forState: .Normal)
        btn.addTarget(self, action: "cancelReservation", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        btn.frame = CGRect(x: 0, y: self.dataForm.frame.size.height, width: self.view.bounds.size.width, height: 66)
    }
    
    func cancelReservation() {
        let alert = TKAlert()
        
        alert.style.cornerRadius = 3;
        alert.title = "Cancel Reservation";
        alert.message = "Reservation Canceled!";
        
        alert.addActionWithTitle("OK") { (TKAlert alert, TKAlertAction action) -> Bool in
            return true
        }
        
        alert.show(true)
    }
    
    //MARK:- TKDataFormDelegate
    
    override func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        if propery.name == "name" {
            return (propery.valueCandidate as! NSString).length > 0
        }
        return true
    }
    
    override func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {

        editor.style.textLabelOffset = UIOffsetMake(10, 0)
        editor.style.separatorLeadingSpace = 40
        editor.style.accessoryArrowStroke = TKStroke(color: UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0))
        
        if ["origin", "date", "time", "name", "phone"].contains(property.name) {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            let titleDef = editor.gridLayout.definitionForView(editor.textLabel)
            editor.gridLayout.setWidth(0, forColumn: titleDef.column.integerValue)
            editor.style.editorOffset = UIOffsetMake(10, 0)
        }
        
        if property.name == "origin" {
            editor.style.editorOffset = UIOffsetMake(0, 0)
            editor.style.separatorColor = nil
        }
        
        if property.name == "name" {
            editor.style.feedbackLabelOffset = UIOffsetMake(10, 0)
            editor.feedbackLabel.font = UIFont(name: "Verdana-Italic", size: 10)
        }
        
        if property.name == "guests" {
            let labelDef = editor.gridLayout.definitionForView((editor as! TKDataFormStepperEditor).valueLabel)
            labelDef.contentOffset = UIOffsetMake(-25, 0)
        }
        
        if property.name == "section" {
            let img = UIImage(named: "guest-name")
            editor.style.textLabelOffset = UIOffsetMake((img?.size.width)! + 10, 0)
        }
        
        if property.name == "table" || property.name == "section" {
            editor.textLabel.textColor = UIColor.whiteColor()
            editor.backgroundColor = UIColor.clearColor()
            (editor as! TKDataFormOptionsEditor).selectedOptionLabel.textColor = UIColor.whiteColor()
            editor.style.editorOffset = UIOffsetMake(-10, 0)
            (editor as! TKDataFormOptionsEditor).selectedOptionLabel.textAlignment = .Right
        }
    }
    
    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
        groupView.titleView.titleLabel.textColor = UIColor.lightGrayColor()
        groupView.titleView.titleLabel.font = UIFont.systemFontOfSize(13)
        groupView.titleView.style.insets = UIEdgeInsetsMake(0, 10, 0, 0)
        if groupIndex == 1 {
            groupView.editorsContainer.backgroundColor = UIColor.clearColor()
        }
    }
}
