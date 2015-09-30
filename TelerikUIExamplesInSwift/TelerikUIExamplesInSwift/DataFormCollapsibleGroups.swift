//
//  DataFormCollapsableGroups.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class DataFormCollapsibleGroups: UIViewController, TKDataFormDelegate {
    let dataSource = TKDataFormEntityDataSource()
    let dataForm = TKDataForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataForm.frame = self.view.bounds
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        dataForm.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.960, alpha: 1.0)
        dataForm.delegate = self
        self.view.addSubview(dataForm)
        
        let info = EmployeeInfo()
        dataSource.sourceObject = info
        
        dataSource.addGroupWithName("Personal Info", propertyNames: ["givenNames", "surname", "gender", "idNumber", "dateOfBirth"])
        dataSource.addGroupWithName("Contact Info", propertyNames: ["employeeId", "phoneNumber"])
        
        dataSource["gender"].editorClass = TKDataFormSegmentedEditor.self
        dataSource["gender"].valuesProvider = ["Male", "Female"]
        
        dataSource["idNumber"].editorClass = TKDataFormNumberEditor.self
        dataSource["employeeId"].editorClass = TKDataFormNumberEditor.self
        dataSource["phoneNumber"].editorClass = TKDataFormPhoneEditor.self
        dataForm.dataSource = dataSource
    }
    
    func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
        groupView.collapsible = true
        groupView.titleView.style.separatorColor = TKSolidFill(color: UIColor(red: 0.784, green: 0.780, blue: 0.8, alpha: 1.0))
    }
    
    func dataForm(dataForm: TKDataForm, heightForHeaderInGroup groupIndex: UInt) -> CGFloat {
        return 44
    }
}
