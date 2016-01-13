//
//  DataFormValidation.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DataFormValidation.h"
#import <TelerikUI/TelerikUI.h>
#import "RegistrationInfo.h"
#import "EmailValidator.h"
#import "PasswordValidator.h"

@interface DataFormValidation()
@end

@implementation DataFormValidation
{
    TKDataFormEntityDataSource *_dataSource;
    RegistrationInfo *_registrationInfo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _registrationInfo = [RegistrationInfo new];
    
    _dataSource = [[TKDataFormEntityDataSource alloc] initWithObject:_registrationInfo];
    
    _dataSource[@"email"].hintText = @"E-mail (Required)";
    _dataSource[@"email"].editorClass = [TKDataFormEmailEditor class];
    _dataSource[@"name"].hintText = @"Name (Optional)";
    _dataSource[@"password"].hintText = @"Password (Minimum 6 characters)";
    _dataSource[@"password"].editorClass = [TKDataFormPasswordEditor class];
    
    TKEntityProperty *property = _dataSource[@"repeatPassword"];
    property.hintText = @"Confirm password";
    property.errorMessage =  @"The password does not match!";
    property.editorClass = [TKDataFormPasswordEditor class];

    _dataSource[@"email"].validators = @[ [EmailValidator new] ];
    _dataSource[@"password"].validators = @[ [PasswordValidator new] ];

    _dataSource[@"gender"].valuesProvider = @[ @"Male", @"Female" ];
    _dataSource[@"country"].valuesProvider = @[ @"Bulgaria", @"France", @"Germany", @"Italy", @"United Kingdom" ];
    _dataSource[@"country"].editorClass = [TKDataFormPickerViewEditor class];
    
    [_dataSource addGroupWithName:@"Account" propertyNames:@[ @"email", @"password", @"repeatPassword", @"rememberMe" ]];
    [_dataSource addGroupWithName:@"Details" propertyNames:@[ @"name", @"dateOfBirth", @"gender", @"country" ]];

    self.dataForm.dataSource = _dataSource;
    self.dataForm.validationMode = TKDataFormValidationModeOnLostFocus;
    self.dataForm.commitMode = TKDataFormCommitModeImmediate;
    self.dataForm.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.960 alpha:1.0];
}

#pragma mark TKDataFormDelegate

- (BOOL)dataForm:(TKDataForm *)dataForm validateProperty:(TKEntityProperty *)property editor:(TKDataFormEditor *)editor
{
    if ([property.name isEqualToString:@"repeatPassword"]) {
        return property.isValid && [property.valueCandidate isEqualToString:_dataSource[@"password"].valueCandidate];
    }
    return property.isValid;
}

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKEntityProperty *)property
{
    if ([@[@"email", @"password", @"repeatPassword", @"name"] containsObject:property.name]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        TKGridLayoutCellDefinition *titleDef = [editor.gridLayout definitionForView:editor.textLabel];
        [editor.gridLayout setWidth:0 forColumn:[titleDef.column integerValue]];
    }
    
    if (!property.isValid) {
        editor.style.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.3]];
    }
    else {
        editor.style.fill = [TKSolidFill solidFillWithColor:[UIColor clearColor]];
    }
}

@end
