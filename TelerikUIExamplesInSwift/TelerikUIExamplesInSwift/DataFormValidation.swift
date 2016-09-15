//
//  DataFormValidation.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DataFormValidation: TKDataFormViewController {

    let registrationInfo = RegistrationInfo()
    let dataSource = TKDataFormEntityDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.sourceObject = registrationInfo

        self.dataForm.dataSource = dataSource
        // >> dataform-validation-swift
        self.dataForm.validationMode = TKDataFormValidationMode.Immediate
        // << dataform-validation-swift
        self.dataForm.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.960, alpha: 1.0)
        
        dataSource["email"].hintText = "E-mail (Required)"
        dataSource["email"].editorClass = TKDataFormEmailEditor.self
        dataSource["name"].hintText = "Name (Optional)"
        dataSource["password"].hintText = "Password"
        dataSource["password"].editorClass = TKDataFormPasswordEditor.self

        let property = dataSource["repeatPassword"]
        property.hintText = "Confirm Password"
        property.errorMessage = "Incorrect password!"
        property.editorClass = TKDataFormPasswordEditor.self

        let nonEmptyValidator = TKDataFormNonEmptyValidator()
        nonEmptyValidator.errorMessage = "Confirm password should not be empty!"
        dataSource["repeatPassword"].validators = [nonEmptyValidator]
        dataSource["email"].validators = [TKDataFormEmailValidator()]
        
        // >> dataform-password-swift
        let passwordValidator = TKDataFormMinimumLengthValidator(minimumLength: 6)
        passwordValidator.errorMessage = "Password must be at least 6 characters!";
        dataSource["password"].validators = [passwordValidator]
        // << dataform-password-swift

        dataSource["gender"].valuesProvider = [ "Male", "Female" ]
        dataSource["country"].valuesProvider = [ "Bulgaria", "France", "Germany", "Italy", "United Kingdom" ];
        dataSource["country"].editorClass = TKDataFormPickerViewEditor.self

        dataSource.addGroupWithName("Account", propertyNames: [ "email", "password", "repeatPassword", "rememberMe" ])
        dataSource.addGroupWithName("Details", propertyNames: [ "name", "dateOfBirth", "gender", "country" ])
       
        dataForm.reloadData()
    }
    
    //MARK:- TKDataFormDelegate
    
    // >> dataform-validate-swift
    override func dataForm(dataForm: TKDataForm, validateProperty property: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
    // << dataform-validate-swift
        if property.name == "repeatPassword" && property.valueCandidate != nil &&
            property.valueCandidate as! String != dataSource["password"].valueCandidate as! String && property.valueCandidate as! String != "" {
            property.errorMessage = "Passwords do not match!"
            return false
        }
        return property.isValid
    // >> dataform-validate-swift
    }
    // << dataform-validate-swift
    
    override func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {

        if ["email", "password", "repeatPassword", "name"].contains(property.name) {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            let textLabelDef = editor.gridLayout.definitionForView(editor.textLabel)
            editor.gridLayout.setWidth(0, forColumn: textLabelDef.column.integerValue)
        }
        
        if !property.isValid {
            editor.style.fill = TKSolidFill(color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.3))
        }
        else {
            editor.style.fill = TKSolidFill(color: UIColor.clearColor())
        }
    }
}
