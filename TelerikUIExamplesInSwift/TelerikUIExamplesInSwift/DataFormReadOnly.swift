//
//  ReadOnly.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DataFormReadOnly: ExampleViewController, TKDataFormDelegate {

    let dataSource = TKDataFormEntityDataSource()
    let cardInfo = CardInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.sourceObject = cardInfo
        
        dataSource["edit"].displayName = "Allow Edit"
        dataSource["firstName"].hintText = "First Name (Must match card)"
        dataSource["lastName"].hintText = "Last Name (Must match card)"
        dataSource["cardNumber"].hintText = "Card Number"
        dataSource["cardNumber"].editorClass = TKDataFormNumberEditor.self
        
        dataSource.addGroupWithName(" ", propertyNames: [ "edit" ])
        dataSource.addGroupWithName(" ", propertyNames: [ "firstName", "lastName", "cardNumber", "zipCode", "expirationDate" ])
        
        for property in dataSource.properties {
            (property as! TKEntityProperty).readOnly = property.name != "edit"
        }
        
        let dataForm = TKDataForm(frame: self.view.bounds)
        dataForm.delegate = self
        dataForm.dataSource = dataSource
        dataForm.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.960, alpha: 1.0)
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        dataForm.groupSpacing = 20
        self.view.addSubview(dataForm)
    }
    
    //MARK:- TKDataFormDelegate
    
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        if ["firstName", "lastName", "cardNumber"].contains(property.name) {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            let textLabelDef = editor.gridLayout.definitionForView(editor.textLabel)
            editor.gridLayout.setWidth(0, forColumn: textLabelDef.column.integerValue)
        }
    }
    
    func dataForm(dataForm: TKDataForm, didEditProperty property: TKEntityProperty) {
        if property.name == "edit" {
            let isReadOnly = !property.valueCandidate.boolValue
            for i in 0 ..< dataSource.properties.count {
                let property = dataSource.properties[i] as! TKEntityProperty
                if !(property.name == "edit") {
                    property.readOnly = isReadOnly
                }
            }
            dataForm.update()
        }
    }
    
    func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
        groupView.titleView.hidden = true
    }
}
