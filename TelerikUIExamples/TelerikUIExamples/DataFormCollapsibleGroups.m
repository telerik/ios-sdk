//
//  DataFormCollapsableGroups.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "DataFormCollapsibleGroups.h"
#import <TelerikUI/TelerikUI.h>
#import "EmployeeInfo.h"

@interface DataFormCollapsibleGroups () <TKDataFormDelegate>

@end

@implementation DataFormCollapsibleGroups
{
    TKDataForm *_dataForm;
    TKDataFormEntityDataSource *_dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataForm = [[TKDataForm alloc] initWithFrame:self.view.bounds];
    _dataForm.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _dataForm.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.960 alpha:1.0];
    _dataForm.delegate = self;
    [self.view addSubview:_dataForm];
    
    EmployeeInfo *info = [[EmployeeInfo alloc] init];
    _dataSource = [[TKDataFormEntityDataSource alloc] initWithObject:info];
    
    [_dataSource addGroupWithName:@"Personal Info" propertyNames:@[@"givenNames", @"surname", @"gender", @"idNumber", @"dateOfBirth"]];
    [_dataSource addGroupWithName:@"Contact Info" propertyNames:@[@"employeeId", @"phoneNumber"]];
    
    _dataSource[@"gender"].editorClass = [TKDataFormSegmentedEditor class];
    _dataSource[@"gender"].valuesProvider = @[@"Male", @"Female"];
    
    _dataSource[@"idNumber"].editorClass = [TKDataFormNumberEditor class];
    _dataSource[@"employeeId"].editorClass = [TKDataFormNumberEditor class];
    
    _dataForm.dataSource = _dataSource;
}

#pragma mark TKDataFormDelegate

- (void)dataForm:(TKDataForm *)dataForm updateGroupView:(TKEntityPropertyGroupView *)groupView forGroupAtIndex:(NSUInteger)groupIndex
{
    groupView.collapsible = YES;
    groupView.titleView.style.separatorColor = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:0.784 green:0.780 blue:0.8 alpha:1.0]];
}

- (CGFloat)dataForm:(TKDataForm *)dataForm heightForHeaderInGroup:(NSUInteger)groupIndex
{
    return 44;
}

@end
