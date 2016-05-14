//
//  DataFormValidation.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DataFormValidation.h"
#import <TelerikUI/TelerikUI.h>
#import "RegistrationInfo.h"

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
    _dataSource[@"password"].hintText = @"Password";
    _dataSource[@"password"].editorClass = [TKDataFormPasswordEditor class];
    
    TKEntityProperty *property = _dataSource[@"repeatPassword"];
    property.hintText = @"Confirm password";
    property.errorMessage =  @"The password does not match!";
    property.editorClass = [TKDataFormPasswordEditor class];

    
    TKDataFormEmailValidator *emailValidator = [[TKDataFormEmailValidator alloc] init];
    _dataSource[@"email"].validators = @[emailValidator];
    
    TKDataFormMinimumLengthValidator *passwordValidator = [[TKDataFormMinimumLengthValidator alloc] initWithMinimumLength:6];
    passwordValidator.errorMessage = @"Password must be at least 6 characters!";
    _dataSource[@"password"].validators = @[passwordValidator];
    
    TKDataFormNonEmptyValidator *nonEmptyValidator = [[TKDataFormNonEmptyValidator alloc] init];
    nonEmptyValidator.errorMessage = @"Confirm password should not be empty!";
    _dataSource[@"repeatPassword"].validators = @[nonEmptyValidator];

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
    if ([property.name isEqualToString:@"repeatPassword"]  && property.valueCandidate &&
        ![property.valueCandidate isEqualToString:_dataSource[@"password"].valueCandidate] && ![property.valueCandidate isEqualToString:@""]) {
        property.errorMessage = @"Passwords do not match!";
        return NO;
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
