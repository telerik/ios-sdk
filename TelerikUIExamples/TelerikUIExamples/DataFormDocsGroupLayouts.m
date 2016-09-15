//
//  DataFormDocsGroupLayouts.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "DataFormDocsGroupLayouts.h"
#import "PersonalInfo.h"

@implementation DataFormDocsGroupLayouts
{
    TKDataFormEntityDataSource *_dataSource;
    PersonalInfo *_personalInfo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _personalInfo = [PersonalInfo new];
    self.dataForm.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.dataForm.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.960 alpha:1.0];
    
    _dataSource = [[TKDataFormEntityDataSource alloc] initWithObject:_personalInfo];
    
    _dataSource[@"password"].hintText = @"Ask every time";
    _dataSource[@"password"].editorClass = [TKDataFormPasswordEditor class];
    
    _dataSource[@"protocol"].valuesProvider = @[@"L2TP", @"PPTP", @"IPSec"];
    _dataSource[@"encryptionLevel"].valuesProvider = @[@"FIPS Compliant", @"High", @"Client Compatible", @"Low"];
    
    [_dataSource addGroupWithName:@"  " propertyNames:@[ @"protocol" ]];
    [_dataSource addGroupWithName:@" " propertyNames:@[ @"details", @"server", @"account", @"secure", @"password", @"encryptionLevel", @"sendAllTraffic" ]];
    
    self.dataForm.dataSource = _dataSource;
    self.dataForm.commitMode = TKDataFormCommitModeOnLostFocus;
    self.dataForm.groupSpacing = 20;
}

#pragma mark TKDataFormDelegate

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKEntityProperty *)property
{
    TKGridLayoutCellDefinition *feedbackDef = [editor.gridLayout definitionForView:editor.feedbackLabel];
    [editor.gridLayout setHeight:0 forRow:[feedbackDef.row integerValue]];
    
    if ([property.name isEqualToString:@"protocol"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        TKGridLayoutCellDefinition *textLabelDef = [editor.gridLayout definitionForView:editor.textLabel];
        [editor.gridLayout setWidth:0 forColumn:[textLabelDef.column integerValue]];
    }
}

- (void)dataForm:(TKDataForm *)dataForm updateGroupView:(TKEntityPropertyGroupView *)groupView forGroupAtIndex:(NSUInteger)groupIndex
{
    groupView.titleView.hidden = YES;
    
    // >> dataform-groups-layout
    groupView.collapsible = YES;
    if (groupIndex == 0) {
        TKGridLayout *grid = [[TKGridLayout alloc] init];
        groupView.editorsContainer.layout = grid;
        NSInteger row = 0;
        NSInteger col = 0;
        for (UIView *editor in groupView.editorsContainer.items) {
            TKGridLayoutCellDefinition *editorDefinition = [grid definitionForView:editor];
            editorDefinition.row = @(row);
            editorDefinition.column = @(col);
            col++;
            if (col == 2) {
                row++;
                col = 0;
            }
        }
    }
    // << dataform-groups-layout
}
@end
