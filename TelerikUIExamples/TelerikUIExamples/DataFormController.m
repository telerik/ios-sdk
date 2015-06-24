//
//  DataFormController.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DataFormController.h"
#import "PersonalInfo.h"
@implementation DataFormController
{
    TKDataFormEntityDataSource *_dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [TKDataFormEntityDataSource new];
    _dataSource.selectedObject = [PersonalInfo new];
    
    self.dataForm.dataSource = _dataSource;
    self.dataForm.commitMode = TKDataFormCommitModeOnLostFocus;
    
    [self.dataForm registerEditor:[TKDataFormSegmentedEditor class] forProperty:[_dataSource.entityModel propertyWithName:@"protocol"]];
    [self.dataForm registerEditor:[TKDataFormOptionsEditor class] forProperty:[_dataSource.entityModel propertyWithName:@"encryptionLevel"]];
    
    TKDataFormEntityProperty *property = [_dataSource.entityModel propertyWithName:@"protocol"];
    property.groupKey = @" ";
}

#pragma mark TKDataFormDelegate

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKDataFormEntityProperty *)property
{
    if ([property.name isEqualToString:@"protocol"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        ((TKDataFormSegmentedEditor *)editor).segments = @[@"L2TP", @"PPTP", @"IPSec"];
        editor.style.separatorLeadingSpace = 0;
    }
    
    if ([property.name isEqualToString:@"encryptionLevel"]) {
        ((TKDataFormOptionsEditor *)editor).options = @[@"FIPS Compliant", @"High", @"Client Compatible", @"Low"];
    }
    
    if ([editor isKindOfClass:TKDataFormTextFieldEditor.class]) {
        ((UITextField *)editor.editor).placeholder = @"Required";
    }
    
    if ([property.name isEqualToString:@"password"]) {
        ((UITextField *)editor.editor).placeholder = @"Ask every time";
        ((UITextField *)editor.editor).secureTextEntry = YES;
    }
    
    if ([property.name isEqualToString:@"sendAllTraffic"]) {
        editor.style.separatorLeadingSpace = 0;
    }
}

@end
