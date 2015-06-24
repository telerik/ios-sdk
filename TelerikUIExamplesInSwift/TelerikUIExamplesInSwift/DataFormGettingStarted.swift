//
//  DataFormGettingStarted.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DataFormGettingStarted: TKDataFormViewController {

    let dataSource = TKDataFormEntityDataSource()
    let personalInfo = PersonalInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.selectedObject = personalInfo
        dataSource.entityModel.propertyWithName("infoProtocol").groupKey = " "
        
        self.dataForm.dataSource = dataSource
        self.dataForm.commitMode = TKDataFormCommitMode.OnLostFocus
        
        self.dataForm.registerEditor(TKDataFormSegmentedEditor.self, forProperty: dataSource.entityModel.propertyWithName("infoProtocol"));
        self.dataForm.registerEditor(TKDataFormOptionsEditor.self, forProperty: dataSource.entityModel.propertyWithName("encryptionLevel"));
        self.dataForm.registerEditor(TKDataFormSwitchEditor.self, forProperty: dataSource.entityModel.propertyWithName("secure"))
        self.dataForm.registerEditor(TKDataFormSwitchEditor.self, forProperty: dataSource.entityModel.propertyWithName("sendAllTraffic"))
    }
    
    //MARK: - TKDataFormDelegate
    
    override func dataForm(dataForm: TKDataForm!, updateEditor editor: TKDataFormEditor!, forProperty property: TKDataFormEntityProperty!) {
        if property.name == "infoProtocol" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            (editor as! TKDataFormSegmentedEditor).segments = ["L2TP", "PPTP", "IPSec"];
            editor.style.separatorLeadingSpace = 0;
        }
        
        if property.name == "encryptionLevel" {
            (editor as! TKDataFormOptionsEditor).options = ["FIPS Compliant", "High", "Client Compatable", "Low"];
        }
        
        if editor.isKindOfClass(TKDataFormTextFieldEditor.self) {
            (editor.editor() as! UITextField).placeholder = "Required";
        }
        
        if property.name == "password" {
            (editor.editor() as! UITextField).placeholder = "Ask every time";
            (editor.editor() as! UITextField).secureTextEntry = true;
        }
        
        if property.name == "sendAllTraffic" {
            editor.style.separatorLeadingSpace = 0;
        }
    }
}
