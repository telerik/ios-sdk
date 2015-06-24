//
//  DataFormReadOnly.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DataFormReadOnly.h"
#import <TelerikUI/TelerikUI.h>
#import "CardInfo.h"

@interface DataFormReadOnly() <TKDataFormDelegate>

@end

@implementation DataFormReadOnly
{
    TKDataFormEntityDataSource *_dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataSource = [TKDataFormEntityDataSource new];
    _dataSource.selectedObject = [CardInfo new];
    [_dataSource.entityModel propertyWithName:@"edit"].groupKey = @" ";
    [_dataSource.entityModel propertyWithName:@"edit"].displayName = @"Allow Edit";
    
    TKDataForm *form = [[TKDataForm alloc] initWithFrame:self.view.bounds];
    form.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    form.delegate = self;
    form.dataSource = _dataSource;
    [self.view addSubview:form];
    
    [_dataSource.entityModel.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TKDataFormEntityProperty *property = (TKDataFormEntityProperty*)obj;
        property.readonly = ![property.name isEqualToString:@"edit"];
    }];
}

#pragma mark TKDataFormDelegate

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKDataFormEntityProperty *)property
{
    if ([property.name isEqualToString:@"firstName"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        ((UITextField *)editor.editor).placeholder = @"First Name (Must match card)";
    }
    else if ([property.name isEqualToString:@"lastName"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        ((UITextField *)editor.editor).placeholder = @"Last Name (Must match card)";
    }
    else if ([property.name isEqualToString:@"cardNumber"]) {
        UITextField *textField = ((UITextField *)editor.editor);
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = @"Card number";
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
    }
}

- (void)dataForm:(TKDataForm *)dataForm didEditProperty:(TKDataFormEntityProperty *)property
{
    if ([property.name isEqualToString:@"edit"]) {
        BOOL isReadOnly = ![property.value boolValue];
        [_dataSource.entityModel.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TKDataFormEntityProperty *p = (TKDataFormEntityProperty*)obj;
            if (![p.name isEqualToString:@"edit"]) {
                p.readonly = isReadOnly;
            }
        }];
        [dataForm updateEditors];
    }
}

@end
