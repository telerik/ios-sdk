//
//  ReadOnly.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class DataFormReadOnly: ExampleViewController, TKDataFormDelegate {

    let dataSource = TKDataFormEntityDataSource()
    let cardInfo = CardInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.selectedObject = cardInfo
        dataSource.entityModel.propertyWithName("edit").groupKey = " "
        dataSource.entityModel.propertyWithName("edit").displayName = "Allow Edit"
        
        let dataForm = TKDataForm(frame: self.view.bounds)
        dataForm.dataSource = dataSource
        dataForm.delegate = self
        dataForm.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(dataForm)
        
        dataForm.registerEditor(TKDataFormSwitchEditor.self, forProperty: dataSource.entityModel.propertyWithName("edit"))
        
        for editor in dataSource.entityModel.properties() as! [TKDataFormEntityProperty] {
            if (editor.name != "edit") {
                editor.readonly = true
            }
        }
    }
    
    //MARK:- TKDataFormDelegate
    
    func dataForm(dataForm: TKDataForm!, updateEditor editor: TKDataFormEditor!, forProperty property: TKDataFormEntityProperty!) {
        if property.name == "firstName" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            (editor.editor() as! UITextField).placeholder = "First Name (Must match card)"
        }
        else if property.name == "lastName" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            (editor.editor() as! UITextField).placeholder = "Last Name (Must match card)"
        }
        else if property.name == "cardNumber" {
            let textField = editor.editor() as! UITextField
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "Card Number"
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
        }
    }
    
    func dataForm(dataForm: TKDataForm!, didEditProperty property: TKDataFormEntityProperty!) {
        if property.name == "edit" {
            let isReadOnly = !property.value().boolValue
            for p in dataSource.entityModel.properties() as! [TKDataFormEntityProperty] {
                if p.name != "edit" {
                    p.readonly = isReadOnly
                }
            }
            dataForm.updateEditors()
        }
    }
}
