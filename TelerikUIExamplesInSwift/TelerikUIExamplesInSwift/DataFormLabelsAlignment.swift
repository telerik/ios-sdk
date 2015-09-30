//
//  DataFormLabelsAlignment.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class DataFormLabelsAlignment: ExampleViewController, TKDataFormDelegate {
    let info = EmployeeInfo()
    let dataSource = TKDataFormEntityDataSource()
    let dataForm = TKDataForm()
    var alignmentMode: String = ""
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.addOption("Top Alignment") { self.prepareTopAlignment() }
        self.addOption("Left Alignment") { self.prepareLeftAlignment() }
        self.addOption("Top Inline Alignment") { self.prepareTopInlineAlignment() }
        self.addOption("Table View Layout") { self.prepareTableLayout() }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataForm.frame = self.view.bounds
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        dataForm.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.960, alpha: 1.0)
        dataForm.delegate = self
        self.view.addSubview(dataForm)
        
        dataSource.sourceObject = info
        
        dataSource.addGroupWithName("Personal Info", propertyNames: ["givenNames", "surname", "gender", "idNumber", "dateOfBirth"])
        dataSource.addGroupWithName("Contact Info", propertyNames: ["employeeId", "phoneNumber"])
        
        dataSource["gender"].editorClass = TKDataFormSegmentedEditor.self
        dataSource["gender"].valuesProvider = ["Male", "Female"]
        
        dataSource["idNumber"].editorClass = TKDataFormNumberEditor.self
        dataSource["employeeId"].editorClass = TKDataFormNumberEditor.self
        dataSource["phoneNumber"].editorClass = TKDataFormPhoneEditor.self
        
        alignmentMode = "Top"
        dataForm.dataSource = dataSource
    }
    
    // MARK: - TKDataFormDelegate
    
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        property.hintText = property.displayName
        if alignmentMode == "Top" {
            self.performTopAlignmentSettingsForEditor(editor, property: property)
        }
        else if alignmentMode == "TopInline" {
            self.performTopInlineAlignmentSettingsForEditor(editor, property: property)
        }
        else if alignmentMode == "Left" {
            self.performLeftAlignmentSettingsForEditor(editor, property: property)
        }
    }
    
    func dataForm(dataForm: TKDataForm, heightForHeaderInGroup groupIndex: UInt) -> CGFloat {
        return 40
    }
    
    func dataForm(dataForm: TKDataForm, heightForEditorInGroup gorupIndex: UInt, atIndex editorIndex: UInt) -> CGFloat {
        if alignmentMode == "Top" {
            if gorupIndex == 0 && editorIndex == 2 {
                return 20
            }
            
            return 65
        }
        
        if alignmentMode == "TopInline" && gorupIndex == 0 && editorIndex == 4 {
            return 75
        }
        
        return 44
    }
    
    func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
        groupView.editorsContainer.backgroundColor = UIColor.whiteColor()
        if !(alignmentMode == "Table") {
            (groupView.editorsContainer.layout as! TKStackLayout).spacing = 7
        }
    }
    
    func dataForm(dataForm: TKDataForm, didSelectEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        let borderColor = UIColor(red:0.000, green:0.478, blue:1.000, alpha:1.00)
        var layer = editor.editor.layer
        
        if editor.isKindOfClass(TKDataFormDatePickerEditor) {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            layer = dateEditor.editorValueLabel.layer
        }
        
        let currentBorderColor = UIColor(CGColor: layer.borderColor!)
        layer.borderColor = borderColor.CGColor
        let animate = CABasicAnimation(keyPath: "borderColor")
        animate.fromValue = currentBorderColor
        animate.toValue = borderColor
        animate.duration = 0.4
        layer.addAnimation(animate, forKey: "borderColor")
    }
    
    func dataForm(dataForm: TKDataForm, didDeselectEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        if editor.isKindOfClass(TKDataFormDatePickerEditor) {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            dateEditor.editorValueLabel.layer.borderColor = UIColor(red:0.784, green:0.780, blue:0.800, alpha:1.00).CGColor
        }
        editor.editor.layer.borderColor = UIColor(red:0.880, green:0.880, blue:0.880, alpha:1.00).CGColor
    }
    
    //MARK: - Events
    
    func prepareTopAlignment () {
        alignmentMode = "Top"
        dataForm.reloadData()
    }
    
    func prepareLeftAlignment () {
        alignmentMode = "Left"
        dataForm.reloadData()
    }
    
    func prepareTopInlineAlignment () {
        alignmentMode = "TopInline"
        dataForm.reloadData()
    }
    
    func prepareTableLayout () {
        alignmentMode = "Table"
        dataForm.reloadData()
    }
    
    //MARK: - Style methods
    
    func performTopAlignmentSettingsForEditor(editor: TKDataFormEditor, property: TKEntityProperty) {
        
        editor.style.separatorColor = nil
        editor.textLabel.font = UIFont.systemFontOfSize(15)
        editor.style.insets = UIEdgeInsetsMake(1, editor.style.insets.left, 5, editor.style.insets.right)
        
        if !(property.name == "gender") {
            let gridLayout = editor.gridLayout
            let editorDef = gridLayout.definitionForView(editor.editor)
            editorDef?.row = 1
            editorDef?.column = 1
            
            if property.name == "dateOfBirth" {
                let dateEditor = editor as! TKDataFormDatePickerEditor
                let labelDef = gridLayout.definitionForView(dateEditor.editorValueLabel)
                labelDef.row = 1
                labelDef.column = 1
            }
            
            let feedbackLabelDef = gridLayout.definitionForView(editor.feedbackLabel)
            feedbackLabelDef.row = 2
            feedbackLabelDef.column = 1
            feedbackLabelDef.columnSpan = 1
            
            self.setEditorStyle(editor)
        }
    }
    
    func performLeftAlignmentSettingsForEditor(editor: TKDataFormEditor, property: TKEntityProperty) {
        
        editor.style.separatorColor = nil
        editor.style.insets = UIEdgeInsetsMake(6, editor.style.insets.left, 6, editor.style.insets.right)
        
        if property.name != "gender" {
            self.setEditorStyle(editor)
        }
    }
    
    func performTopInlineAlignmentSettingsForEditor(editor: TKDataFormEditor, property: TKEntityProperty) {

        editor.style.separatorColor = nil
        editor.style.insets = UIEdgeInsetsMake(6, editor.style.insets.left, 6, editor.style.insets.right)
        
        let gridLayout = editor.gridLayout

        self.setEditorStyle(editor)
        
        if property.name == "dateOfBirth" {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            let labelDef = gridLayout.definitionForView(dateEditor.editorValueLabel)
            labelDef.row = 1
            labelDef.column = 1
            gridLayout.setHeight(44, forRow: labelDef.row.integerValue)
            
            let feedbackLabelDef = gridLayout.definitionForView(editor.feedbackLabel)
            feedbackLabelDef.row = 2
            feedbackLabelDef.column = 1
            feedbackLabelDef.columnSpan = 1
        }
        
        if editor.isKindOfClass(TKDataFormTextFieldEditor) {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            let titleDef = gridLayout.definitionForView(editor.textLabel)
            gridLayout.setWidth(0, forColumn: titleDef.column.integerValue)
        }
    }
    
    func setEditorStyle(editor: TKDataFormEditor) {
        if editor.selected {
            return;
        }
        
        var layer = editor.editor.layer
        
        if editor.isKindOfClass(TKDataFormDatePickerEditor) {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            layer = dateEditor.editorValueLabel.layer
            dateEditor.editorValueLabel.layer.borderWidth = 1.0
            dateEditor.editorValueLabel.layer.borderColor = UIColor.grayColor().CGColor
            dateEditor.showAccessoryImage = false
            dateEditor.editorValueLabel.textInsets = UIEdgeInsetsMake(0, 7, 0, 0)
        }
        else if editor.isKindOfClass(TKDataFormTextFieldEditor) {
            layer = editor.editor.layer;
            (editor.editor as! TKTextField).textInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 0)
        }
        
        layer.borderColor = UIColor(red:0.880, green:0.880, blue:0.880, alpha:1.00).CGColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
    }
}
