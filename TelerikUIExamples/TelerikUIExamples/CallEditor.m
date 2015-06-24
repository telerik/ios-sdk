//
//  CallEditor.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "CallEditor.h"

@implementation CallEditor
{
    UITextField *_textField;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _actionButton = [[UIButton alloc] init];
        [_actionButton setTitle:@"Call" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor colorWithRed:0.780 green:0.2 blue:0.223 alpha:1.0] forState:UIControlStateNormal];
        [self addSubview:_actionButton];
        
        _textField = [[UITextField alloc] init];
        _textField.keyboardType = UIKeyboardTypePhonePad;
        _textField.delegate = self;
        [self addSubview:_textField];
    }
    return self;
}

- (void)setProperty:(TKDataFormEntityProperty *)property
{
    [super setProperty:property];
    _textField.placeholder = property.displayName;
}

- (UIView *)editor
{
    return _textField;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectZero;
    CGRect bounds = CGRectMake(self.bounds.origin.x + self.style.insets.left, self.bounds.origin.y + self.style.insets.top,
                               self.bounds.size.width - (self.style.insets.right + self.style.insets.left), self.bounds.size.height - (self.style.insets.top + self.style.insets.bottom));
    CGSize buttonSize = [_actionButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : _actionButton.titleLabel.font, NSBackgroundColorAttributeName : _actionButton.titleLabel.textColor}];
    _actionButton.frame = CGRectMake(bounds.origin.x + bounds.size.width + self.style.editorOffset.horizontal - buttonSize.width,
                                   CGRectGetMidY(bounds) - buttonSize.height / 2.0 + self.style.editorOffset.vertical, buttonSize.width, buttonSize.height);
    
    _textField.frame = CGRectMake(bounds.origin.x + self.style.textLabelOffset.horizontal, CGRectGetMidY(bounds) - bounds.size.height / 2.0,
                            _actionButton.frame.origin.x - (bounds.origin.x + self.style.textLabelOffset.horizontal), bounds.size.height);
    if (self.style.textLabelDisplayMode == TKDataFormEditorTextLabelDisplayModeHidden) {
        _textField.frame = CGRectZero;
        _actionButton.frame = CGRectMake(bounds.origin.x + self.style.editorOffset.horizontal,
                                         CGRectGetMidY(bounds) - buttonSize.height / 2.0 + self.style.editorOffset.vertical, buttonSize.width, buttonSize.height);
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self changeEditorOnFocus];
    return YES;
}

@end
