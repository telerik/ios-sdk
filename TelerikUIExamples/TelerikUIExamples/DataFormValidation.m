//
//  DataFormValidation.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DataFormValidation.h"
#import <TelerikUI/TelerikUI.h>
#import "RegisterationInfo.h"
#import "EmailValidator.h"
#import "PasswordValidator.h"

@interface DataFormValidation() <TKDataFormDelegate>
@end

@implementation DataFormValidation
{
    TKDataFormEntityDataSource *_dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [TKDataFormEntityDataSource new];
    _dataSource.selectedObject = [RegisterationInfo new];
    
    self.dataForm.validationMode = TKDataFormValidationModeImmediate;
    self.dataForm.dataSource = _dataSource;
    
    [self.dataForm registerEditor:[TKDataFormOptionsEditor class] forProperty:[_dataSource.entityModel propertyWithName:@"gender"]];
    [self.dataForm registerEditor:[TKDataFormPickerViewEditor class] forProperty:[_dataSource.entityModel propertyWithName:@"country"]];
    
    TKDataFormEntityProperty *emailProperty = [_dataSource.entityModel propertyWithName:@"email"];
    emailProperty.validators = @[[EmailValidator new]];
    emailProperty.groupKey = @"Account";
    
    TKDataFormEntityProperty *password = [_dataSource.entityModel propertyWithName:@"password"];
    password.validators = @[[PasswordValidator new]];
    password.groupKey = @"Account";
    
    [_dataSource.entityModel propertyWithName:@"repeatPassword"].groupKey = @"Account";
    [_dataSource.entityModel propertyWithName:@"rememberMe"].groupKey = @"Account";
    
    [_dataSource.entityModel propertyWithName:@"name"].groupKey = @"Details";
    [_dataSource.entityModel propertyWithName:@"dateOfBirth"].groupKey = @"Details";
    [_dataSource.entityModel propertyWithName:@"gender"].groupKey = @"Details";
    [_dataSource.entityModel propertyWithName:@"country"].groupKey = @"Details";
}

#pragma mark TKDataFormDelegate

- (BOOL)dataForm:(TKDataForm *)dataForm validateProperty:(TKDataFormEntityProperty *)propery editor:(TKDataFormEditor *)editor
{
    if ([propery.name isEqualToString:@"repeatPassword"]) {
        NSString *repeatedPassword = propery.value;
        TKDataFormEntityProperty *passwordProperty = [_dataSource.entityModel propertyWithName:@"password"];
        NSString *password = passwordProperty.value;
        if (![repeatedPassword isEqualToString:password]) {
            return NO;
        }
        return YES;
    }
    return propery.isValid;
}

- (void)dataForm:(TKDataForm *)dataForm didValidateProperty:(TKDataFormEntityProperty *)propery editor:(TKDataFormEditor *)editor
{
    if ([propery.name isEqualToString:@"repeatPassword"]) {
        if (propery.isValid) {
            propery.feedbackMessage = nil;
        }
        else {
            propery.feedbackMessage = @"Incorrect password!";
        }
    }
}

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKDataFormEntityProperty *)property
{
    if ([property.name isEqualToString:@"gender"]) {
        ((TKDataFormOptionsEditor *)editor).options = @[@"Male", @"Female"];
    }
    else if ([property.name isEqualToString:@"email"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        ((UITextField *)editor.editor).keyboardType = UIKeyboardTypeEmailAddress;
        ((UITextField *)editor.editor).placeholder = @"E-mail (Required)";
    }
    else if ([property.name isEqualToString:@"password"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        ((UITextField *)editor.editor).secureTextEntry = YES;
        ((UITextField *)editor.editor).placeholder = @"Password (Minimum 6 characters)";
    }
    else if ([property.name isEqualToString:@"repeatPassword"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        ((UITextField *)editor.editor).secureTextEntry = YES;
        ((UITextField *)editor.editor).placeholder = @"Confirm password";
    }
    else if ([property.name isEqualToString:@"name"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        ((UITextField *)editor.editor).placeholder = @"Name (Optional)";
    }
    else if ([property.name isEqualToString:@"country"]) {
        ((TKDataFormPickerViewEditor *)editor).options = @[@"Bulgaria", @"United Kingdom", @"Germany", @"France", @"Italy", @"Belgium", @"Norway", @"Sweden", @"Russia", @"Turkey"];
        editor.style.separatorLeadingSpace = 0;
    }
    else if ([property.name isEqualToString:@"rememberMe"]) {
        editor.style.separatorLeadingSpace = 0;
    }
    
    if (!property.isValid) {
        editor.style.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.3]];
    }
    else {
        editor.style.fill = [TKSolidFill solidFillWithColor:[UIColor clearColor]];
    }
}

@end
