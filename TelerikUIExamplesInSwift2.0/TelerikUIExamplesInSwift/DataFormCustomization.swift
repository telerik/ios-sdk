//
//  DataFormCustomization.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//


class DataFormCustomization: TKDataFormViewController {

    let dataSource = TKDataFormEntityDataSource()
    let reservationForm = ReservationForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.selectedObject = reservationForm
        self.dataForm.dataSource = dataSource
        self.dataForm.backgroundColor = UIColor(patternImage: UIImage(named: "wood-pattern")!)
        
        self.dataForm.registerEditor(CallEditor.self, forProperty: dataSource.entityModel.propertyWithName("phone"))
        self.dataForm.registerEditor(CallEditor.self, forProperty: dataSource.entityModel.propertyWithName("cancelReservation"))
        self.dataForm.registerEditor(TKDataFormOptionsEditor.self, forProperty: dataSource.entityModel.propertyWithName("section"))
        self.dataForm.registerEditor(TKDataFormOptionsEditor.self, forProperty: dataSource.entityModel.propertyWithName("table"))
        self.dataForm.registerEditor(TKDataFormSegmentedEditor.self, forProperty: dataSource.entityModel.propertyWithName("origin"))
        
        dataSource.entityModel.propertyWithName("name").image = UIImage(named: "guest-name")
        dataSource.entityModel.propertyWithName("phone").image = UIImage(named: "phone")
        dataSource.entityModel.propertyWithName("date").image = UIImage(named: "calendar")
        dataSource.entityModel.propertyWithName("time").image = UIImage(named: "time")
        dataSource.entityModel.propertyWithName("guests").image = UIImage(named: "guest-number")
        dataSource.entityModel.propertyWithName("table").image = UIImage(named: "table-number")
        
        for property in dataSource.entityModel.properties() as! [TKDataFormEntityProperty] {
            if property.name == "section" || property.name == "table" {
                property.groupKey = "TABLE DETAILS";
            }
            else if property.name == "origin" || property.name == "cancelReservation" {
                property.groupKey = "ORIGIN";
            }
            else {
                property.groupKey = "RESERVATION DETAILS";
            }
        }
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
    
    override func dataForm(dataForm: TKDataForm!, validateProperty propery: TKDataFormEntityProperty!, editor: TKDataFormEditor!) -> Bool {
        if propery.name == "name" {
            let value = propery.value() as! NSString
            if value.length == 0 {
                return false
            }
        }
        
        return true
    }
    
    override func dataForm(dataForm: TKDataForm!, didValidateProperty propery: TKDataFormEntityProperty!, editor: TKDataFormEditor!) {
        if propery.name == "name" {
            if !propery.isValid {
                propery.feedbackMessage = "Please fill in the guest name"
            }
            else {
                propery.feedbackMessage = nil
            }
        }
    }
    
    override func dataForm(dataForm: TKDataForm!, updateEditor editor: TKDataFormEditor!, forProperty property: TKDataFormEntityProperty!) {
        editor.style.textLabelOffset = UIOffsetMake(25, 0)
        editor.style.separatorLeadingSpace = 40
        editor.style.accessoryArrowStroke = TKStroke(color: UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0))
        if property.name == "name" {
            if !property.isValid {
                editor.style.feedbackLabelOffset = UIOffsetMake(25, -5)
                editor.style.editorOffset = UIOffsetMake(25, -7)
            }
            else{
                editor.style.feedbackLabelOffset = UIOffsetMake(25, 0)
                editor.style.editorOffset = UIOffsetMake(25, 0)
            }
            
            editor.feedbackLabel.font = UIFont(name: "Verdana-Italic", size: 10)
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            (editor.editor() as! UITextField).placeholder = "Name"
        }
        
        if property.name == "time" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            editor.style.textLabelOffset = UIOffsetMake(25, 0);
            (editor as! TKDataFormDatePickerEditor).dateFormatter.dateFormat = "h:mm a";
            (editor.editor() as! UIDatePicker).datePickerMode = UIDatePickerMode.Time;
        }
        
        if property.name == "date" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            editor.style.textLabelOffset = UIOffsetMake(25, 0)
        }
        
        if property.name == "guests" {
            let stepper = editor.editor() as! UIStepper
            stepper.minimumValue = 1
            stepper.tintColor = UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0)
            stepper.setIncrementImage(UIImage(named: "plus"), forState: UIControlState.Normal)
            stepper.setDecrementImage(UIImage(named: "minus"), forState: UIControlState.Normal)
        }
        
        if property.name == "section" {
            editor.textLabel.textColor = UIColor.whiteColor()
            editor.backgroundColor = UIColor.clearColor()
            (editor as! TKDataFormOptionsEditor).options = ["Section 1", "Section 2", "Section 3", "Section 4"]
            (editor as! TKDataFormOptionsEditor).selectedOptionLabel.textColor = UIColor.whiteColor()
        }
        
        if property.name == "table" {
            editor.textLabel.textColor = UIColor.whiteColor()
            editor.backgroundColor = UIColor.clearColor()
            (editor as! TKDataFormOptionsEditor).options = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
            (editor as! TKDataFormOptionsEditor).selectedOptionLabel.textColor = UIColor.whiteColor()
        }
        if property.name == "origin" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            editor.style.editorOffset = UIOffsetMake(25, 0)
            (editor as! TKDataFormSegmentedEditor).segments = ["phone", "in-person", "online", "other"]
            let segmentedControl = editor.editor() as! UISegmentedControl
            segmentedControl.tintColor = UIColor(red:0.780, green:0.2, blue:0.223, alpha:1.0)
        }
        
        if property.name == "cancelReservation" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            editor.style.editorOffset = UIOffsetMake(25,0)
            (editor as! CallEditor).actionButton.setTitle(property.displayName, forState: UIControlState.Normal)
            (editor as! CallEditor).actionButton.addTarget(self, action: "cancelReservation", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    override func dataForm(dataForm: TKDataForm!, viewForHeaderInSection section: Int) -> UIView! {
        let header = TKDataFormHeaderView()
        header.titleLabel.textColor = UIColor.grayColor()
        header.insets = UIEdgeInsetsMake(0, 40, 0, 0)
        header.separatorColor = TKSolidFill(color: UIColor.clearColor())
        if section == 0 {
            header.titleLabel.text = "RESERVATION DETAILS"
        }
        else if section == 1 {
            header.titleLabel.text = "TABLE DETAILS"
        }
        else{
            header.titleLabel.text = "ORIGIN"
        }
        
        return header
    }
    
    override func dataForm(dataForm: TKDataForm!, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}


