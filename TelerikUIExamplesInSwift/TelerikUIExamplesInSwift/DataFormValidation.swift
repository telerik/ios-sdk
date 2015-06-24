//
//  DataFormValidation.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class DataFormValidation: TKDataFormViewController {

    let registrationInfo = RegistrationInfo()
    let dataSource = TKDataFormEntityDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.selectedObject = registrationInfo
        self.dataForm.dataSource = dataSource
        self.dataForm.validationMode = TKDataFormValidationMode.Immediate
        
        self.dataForm.registerEditor(TKDataFormOptionsEditor.self, forProperty: dataSource.entityModel.propertyWithName("gender"))
        self.dataForm.registerEditor(TKDataFormPickerViewEditor.self, forProperty: dataSource.entityModel.propertyWithName("country"))
        self.dataForm.registerEditor(TKDataFormSwitchEditor.self, forProperty: dataSource.entityModel.propertyWithName("rememberMe"))

        let emailProperty = dataSource.entityModel.propertyWithName("email")
        emailProperty.validators = [EmailValidator()]
        emailProperty.groupKey = "Account"
        
        let passwordProperty = dataSource.entityModel.propertyWithName("password")
        passwordProperty.validators = [PasswordValidator()]
        passwordProperty.groupKey = "Account"
        
        dataSource.entityModel.propertyWithName("repeatPassword").groupKey = "Account";
        dataSource.entityModel.propertyWithName("rememberMe").groupKey = "Account";
        
        dataSource.entityModel.propertyWithName("name").groupKey = "Details";
        dataSource.entityModel.propertyWithName("dateOfBirth").groupKey = "Details";
        dataSource.entityModel.propertyWithName("gender").groupKey = "Details";
        dataSource.entityModel.propertyWithName("country").groupKey = "Details";
    }
    
    //MARK:- TKDataFormDelegate
    
    override func dataForm(dataForm: TKDataForm!, validateProperty propery: TKDataFormEntityProperty!, editor: TKDataFormEditor!) -> Bool {
        if propery.name == "repeatPassword" {
            let repeatPassword = propery.value() as! String
            let passwordProperty = self.dataSource.entityModel.propertyWithName("password")
            let password = passwordProperty.value() as! String
            if repeatPassword != password {
                return false
            }
            return true
        }
        return propery.isValid
    }
    
    override func dataForm(dataForm: TKDataForm!, didValidateProperty propery: TKDataFormEntityProperty!, editor: TKDataFormEditor!) {
        if propery.name == "repeatPassword" {
            if propery.isValid == true {
                propery.feedbackMessage = nil
            }
            else {
                propery.feedbackMessage = "Incorrect password!"
            }
        }
    }
    
    override func dataForm(dataForm: TKDataForm!, updateEditor editor: TKDataFormEditor!, forProperty property: TKDataFormEntityProperty!) {
        if property.name == "gender" {
            (editor as! TKDataFormOptionsEditor).options = ["Male", "Female"]
        }
        else if property.name == "email" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            (editor.editor() as! UITextField).keyboardType = UIKeyboardType.EmailAddress
            (editor.editor() as! UITextField).placeholder = "E-mail (Required)"
        }
        else if property.name == "password" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            (editor.editor() as! UITextField).secureTextEntry = true
            (editor.editor() as! UITextField).placeholder = "Password (Minimum 6 characters)"
        }
        else if property.name == "repeatPassword" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            (editor.editor() as! UITextField).secureTextEntry = true
            (editor.editor() as! UITextField).placeholder = "Confirm Password"
        }
        else if property.name == "name" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            (editor.editor() as! UITextField).placeholder = "Name (Optional)"
        }
        else if property.name == "country" {
            (editor as! TKDataFormPickerViewEditor).options = ["Bulgaria", "United Kingdom", "Germany", "France", "Italy", "Belgium", "Norway", "Sweden", "Russia", "Turkey"];
            editor.style.separatorLeadingSpace = 0;
        }
        else if property.name == "rememberMe" {
            editor.style.separatorLeadingSpace = 0
        }
        
        if !property.isValid {
            editor.style.fill = TKSolidFill(color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.3))
        }
        else {
            editor.style.fill = TKSolidFill(color: UIColor.clearColor())
        }
    }
}
