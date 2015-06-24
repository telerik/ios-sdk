//
//  CallEditor.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class CallEditor: TKDataFormEditor {

    let actionButton = UIButton()
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        actionButton.setTitle("Call", forState: UIControlState.Normal)
        actionButton.setTitleColor(UIColor(red: 0.780, green: 0.2, blue: 0.233, alpha: 1.0), forState: UIControlState.Normal)
        self.addSubview(actionButton)
        textField.keyboardType = UIKeyboardType.PhonePad
        
        self.addSubview(textField)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
    
    override var property: TKDataFormEntityProperty!{
        get{
            return super.property
        }
        set{
            super.property = newValue
            textField.placeholder = self.property.displayName
        }
    }
    
    override func editor() -> UIView{
        return textField
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.textLabel.frame = CGRectZero
        
        var bounds = CGRectMake(self.bounds.origin.x + self.style.insets.left, self.bounds.origin.y + self.style.insets.top,
                                self.bounds.size.width - (self.style.insets.right + self.style.insets.left),
                                self.bounds.size.height - (self.style.insets.top + self.style.insets.bottom))
        
        var buttonSize = (actionButton.titleLabel!.text! as NSString)
            .sizeWithAttributes([NSFontAttributeName : actionButton.titleLabel!.font,
                                 NSBackgroundColorAttributeName : actionButton.titleLabel!.textColor]);

        actionButton.frame = CGRectMake(bounds.origin.x + bounds.size.width + self.style.editorOffset.horizontal - buttonSize.width,
            CGRectGetMidY(bounds) - buttonSize.height / 2.0 + self.style.editorOffset.vertical, buttonSize.width, buttonSize.height)
        
        textField.frame = CGRectMake(bounds.origin.x + self.style.textLabelOffset.horizontal, CGRectGetMidY(bounds) - bounds.size.height / 2.0,
            actionButton.frame.origin.x - (bounds.origin.x + self.style.textLabelOffset.horizontal), bounds.size.height);
       // textField.placeholder = "Phone"
        
        if self.style.textLabelDisplayMode == TKDataFormEditorTextLabelDisplayMode.Hidden {
            textField.frame = CGRectZero
            actionButton.frame = CGRectMake(bounds.origin.x + self.style.editorOffset.horizontal,
                CGRectGetMidY(bounds) - buttonSize.height / 2.0 + self.style.editorOffset.vertical, buttonSize.width, buttonSize.height)
        }
        
    }

}