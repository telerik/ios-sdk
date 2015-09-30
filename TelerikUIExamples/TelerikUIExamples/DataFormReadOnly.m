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
    CardInfo *_cardInfo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _cardInfo = [CardInfo new];
    
    _dataSource = [[TKDataFormEntityDataSource alloc] initWithObject:_cardInfo];

    _dataSource[@"edit"].displayName = @"Allow Edit";
    _dataSource[@"firstName"].hintText = @"First Name (Must match card)";
    _dataSource[@"lastName"].hintText = @"Last Name (Must match card)";
    _dataSource[@"cardNumber"].hintText = @"Card number";
    _dataSource[@"cardNumber"].editorClass = [TKDataFormNumberEditor class];
    
    [_dataSource addGroupWithName:@" " propertyNames:@[ @"edit" ]];
    [_dataSource addGroupWithName:@" " propertyNames:@[ @"firstName", @"lastName", @"cardNumber", @"zipCode", @"expirationDate" ]];

    [_dataSource.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TKEntityProperty *property = (TKEntityProperty*)obj;
        property.readOnly = ![property.name isEqualToString:@"edit"];
    }];

    TKDataForm *form = [[TKDataForm alloc] initWithFrame:self.view.bounds];
    form.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    form.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.960 alpha:1.0];
    form.delegate = self;
    form.dataSource = _dataSource;
    form.groupSpacing = 20;
    [self.view addSubview:form];
}

#pragma mark TKDataFormDelegate

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKEntityProperty *)property
{
    if ([@[@"firstName", @"lastName", @"cardNumber"] containsObject:property.name]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        TKGridLayoutCellDefinition *titleDef = [editor.gridLayout definitionForView:editor.textLabel];
        [editor.gridLayout setWidth:0 forColumn:[titleDef.column integerValue]];
    }
}

- (void)dataForm:(TKDataForm *)dataForm didEditProperty:(TKEntityProperty *)property
{
    if ([property.name isEqualToString:@"edit"]) {
        BOOL isReadOnly = ![property.valueCandidate boolValue];
        [_dataSource.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TKEntityProperty *p = (TKEntityProperty*)obj;
            if (![p.name isEqualToString:@"edit"]) {
                p.readOnly = isReadOnly;
            }
        }];

        [dataForm update];
    }
}

- (void)dataForm:(TKDataForm *)dataForm updateGroupView:(TKEntityPropertyGroupView *)groupView forGroupAtIndex:(NSUInteger)groupIndex
{
    groupView.titleView.hidden = YES;
}

@end
