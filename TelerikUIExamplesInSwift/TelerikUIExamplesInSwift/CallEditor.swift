//
//  CallEditor.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class CallEditor: TKDataFormPhoneEditor {

    let actionButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        actionButton.setTitle("Call", forState: UIControlState.Normal)
        actionButton.setTitleColor(UIColor(red: 0.780, green: 0.2, blue: 0.233, alpha: 1.0), forState: UIControlState.Normal)
        self.addSubview(actionButton)
        self.gridLayout.addArrangedView(actionButton)
        let btnDef = self.gridLayout.definitionForView(actionButton)
        btnDef.row = 0
        btnDef.column = 3
        self.gridLayout.setWidth(actionButton.sizeThatFits(CGSizeZero).width, forColumn: 3)
    }

    override init(property: TKEntityProperty) {
        super.init(property: property)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
}