//
//  DataFormLabelAlignment.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "DataFormLabelAlignment.h"
#import <TelerikUI/TelerikUI.h>
#import "EmployeeInfo.h"

@interface DataFormLabelAlignment () <TKDataFormDelegate>

@end

@implementation DataFormLabelAlignment
{
    EmployeeInfo *_info;
    TKDataForm *_dataForm;
    TKDataFormEntityDataSource *_dataSource;
    NSString *_alignmentMode;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Top Alignment" selector:@selector(prepareTopAlignment)];
        [self addOption:@"Left Alignment" selector:@selector(prepareLeftAlignment)];
        [self addOption:@"Top Inline Alignment" selector:@selector(prepareTopInlineAlignment)];
        [self addOption:@"Table View Layout" selector:@selector(prepareTableLayout)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataForm = [[TKDataForm alloc] initWithFrame:self.view.bounds];
    _dataForm.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _dataForm.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.960 alpha:1.0];
    _dataForm.delegate = self;
    [self.view addSubview:_dataForm];
    
    _info = [[EmployeeInfo alloc] init];
    _dataSource = [[TKDataFormEntityDataSource alloc] initWithObject:_info];
    
    [_dataSource addGroupWithName:@"Personal Info" propertyNames:@[@"givenNames", @"surname", @"gender", @"idNumber", @"dateOfBirth"]];
    [_dataSource addGroupWithName:@"Contact Info" propertyNames:@[@"employeeId", @"phoneNumber"]];
    
    _dataSource[@"gender"].editorClass = [TKDataFormSegmentedEditor class];
    _dataSource[@"gender"].valuesProvider = @[@"Male", @"Female"];
    
    _dataSource[@"idNumber"].editorClass = [TKDataFormNumberEditor class];
    _dataSource[@"employeeId"].editorClass = [TKDataFormNumberEditor class];
    _dataSource[@"phoneNumber"].editorClass = [TKDataFormPhoneEditor class];
    
    _alignmentMode = @"Top";
    _dataForm.dataSource = _dataSource;
}

#pragma mark TKDataFormDelegate

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKEntityProperty *)property
{
    property.hintText = property.displayName;
    if ([_alignmentMode isEqualToString:@"Top"]) {
        [self performTopAlignmentSettingsForEditor:editor property:property];
    }
    else if ([_alignmentMode isEqualToString:@"TopInline"]) {
        [self performTopInlineAlignmentSettingsForEditor:editor property:property];
    }
    else if ([_alignmentMode isEqualToString:@"Left"]) {
        [self performLeftAlignmentSettingsForEditor:editor property:property];
    }
}

- (CGFloat)dataForm:(TKDataForm *)dataForm heightForHeaderInGroup:(NSUInteger)groupIndex
{
    return 40;
}

- (CGFloat)dataForm:(TKDataForm *)dataForm heightForEditorInGroup:(NSUInteger)gorupIndex atIndex:(NSUInteger)editorIndex
{
    if ([_alignmentMode isEqualToString:@"Top"]) {
        if (gorupIndex == 0 && editorIndex == 2) {
            return 20;
        }
        
        return 65;
    }
    
    if ([_alignmentMode isEqualToString:@"TopInline"] && gorupIndex == 0 && editorIndex == 4) {
        return 75;
    }
    
    return 44;
}

- (void)dataForm:(TKDataForm *)dataForm updateGroupView:(TKEntityPropertyGroupView *)groupView forGroupAtIndex:(NSUInteger)groupIndex
{
    groupView.editorsContainer.backgroundColor = [UIColor whiteColor];
    if (![_alignmentMode isEqualToString:@"Table"]) {
        ((TKStackLayout *)groupView.editorsContainer.layout).spacing = 7;
    }
}


- (void)dataForm:(TKDataForm *)dataForm didSelectEditor:(TKDataFormEditor *)editor forProperty:(TKEntityProperty *)property
{
    UIColor *borderColor = [UIColor colorWithRed:0.000f green:0.478f blue:1.000f alpha:1.00f];
    CALayer *layer = editor.editor.layer;

    if ([editor isKindOfClass:[TKDataFormDatePickerEditor class]]) {
        TKDataFormDatePickerEditor *dateEditor = (TKDataFormDatePickerEditor *)editor;
        layer = dateEditor.editorValueLabel.layer;
    }

    UIColor *currentBorderColor = [UIColor colorWithCGColor:layer.borderColor];
    layer.borderColor = borderColor.CGColor;
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    animate.fromValue = currentBorderColor;
    animate.toValue = borderColor;
    animate.duration = 0.4;
    [layer addAnimation:animate forKey:@"borderColor"];
}

- (void)dataForm:(TKDataForm *)dataForm didDeselectEditor:(TKDataFormEditor *)editor forProperty:(TKEntityProperty *)property
{
    if ([editor isKindOfClass:[TKDataFormDatePickerEditor class]]) {
        TKDataFormDatePickerEditor *dateEditor = (TKDataFormDatePickerEditor *)editor;
        dateEditor.editorValueLabel.layer.borderColor = [UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f].CGColor;
    }
    editor.editor.layer.borderColor = [UIColor colorWithRed:0.880f green:0.880f blue:0.880f alpha:1.00f].CGColor;
}

#pragma mark - Events

- (void)prepareTopAlignment
{
    _alignmentMode = @"Top";
    [_dataForm reloadData];
}

- (void)prepareLeftAlignment
{
    _alignmentMode = @"Left";
    [_dataForm reloadData];
}

- (void)prepareTopInlineAlignment
{
    _alignmentMode = @"TopInline";
    [_dataForm reloadData];
}

- (void)prepareTableLayout
{
    _alignmentMode = @"Table";
    [_dataForm reloadData];
}

#pragma mark - Style methods

- (void)performTopAlignmentSettingsForEditor:(TKDataFormEditor *)editor property:(TKEntityProperty *)property
{
    editor.style.separatorColor = nil;
    editor.textLabel.font = [UIFont systemFontOfSize:15];
    editor.style.insets = UIEdgeInsetsMake(1, editor.style.insets.left, 5, editor.style.insets.right);

    if (![property.name isEqualToString:@"gender"]) {
        TKGridLayout *gridLayout = editor.gridLayout;
        TKGridLayoutCellDefinition *editorDef = [gridLayout definitionForView:editor.editor];
        editorDef.row = @1;
        editorDef.column = @1;
        
        if ([property.name isEqualToString:@"dateOfBirth"]) {
            TKDataFormDatePickerEditor *dateEditor = ((TKDataFormDatePickerEditor *)editor);
            TKGridLayoutCellDefinition *labelDef = [gridLayout definitionForView:dateEditor.editorValueLabel];
            labelDef.row = @1;
            labelDef.column = @1;
        }

        TKGridLayoutCellDefinition *feedbackLabelDef = [gridLayout definitionForView:editor.feedbackLabel];
        feedbackLabelDef.row = @2;
        feedbackLabelDef.column = @1;
        feedbackLabelDef.columnSpan = 1;

        [self setEditorStyle:editor];
    }
}

- (void)performLeftAlignmentSettingsForEditor:(TKDataFormEditor *)editor property:(TKEntityProperty *)property
{
    editor.style.separatorColor = nil;
    editor.style.insets = UIEdgeInsetsMake(6, editor.style.insets.left, 6, editor.style.insets.right);
    if (![property.name isEqualToString:@"gender"]) {
        [self setEditorStyle:editor];
    }
}

- (void)performTopInlineAlignmentSettingsForEditor:(TKDataFormEditor *)editor property:(TKEntityProperty *)property
{
    editor.style.separatorColor = nil;
    editor.style.insets = UIEdgeInsetsMake(6, editor.style.insets.left, 6, editor.style.insets.right);
    TKGridLayout *gridLayout = editor.gridLayout;

    [self setEditorStyle:editor];

    if ([property.name isEqualToString:@"dateOfBirth"]) {
        TKDataFormDatePickerEditor *dateEditor = ((TKDataFormDatePickerEditor *)editor);
        TKGridLayoutCellDefinition *labelDef = [gridLayout definitionForView:dateEditor.editorValueLabel];
        labelDef.row = @1;
        labelDef.column = @1;
        [gridLayout setHeight:30 forRow:[labelDef.row integerValue]];
        
        TKGridLayoutCellDefinition *feedbackLabelDef = [gridLayout definitionForView:dateEditor.feedbackLabel];
        feedbackLabelDef.row = @2;
        feedbackLabelDef.column = @1;
        feedbackLabelDef.columnSpan = 1;
    }
    
    if ([editor isKindOfClass:TKDataFormTextFieldEditor.class]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        TKGridLayoutCellDefinition *titleDef = [gridLayout definitionForView:editor.textLabel];
        [gridLayout setWidth:0 forColumn:[titleDef.column integerValue]];
    }
}

- (void)setEditorStyle:(TKDataFormEditor*)editor
{
    if (editor.selected) {
        return;
    }
    
    CALayer *layer = nil;
    
    if ([editor isKindOfClass:[TKDataFormDatePickerEditor class]]) {
        TKDataFormDatePickerEditor *dateEditor = (TKDataFormDatePickerEditor *)editor;
        layer = dateEditor.editorValueLabel.layer;
        dateEditor.editorValueLabel.textInsets = UIEdgeInsetsMake(0, 7, 0, 0);
        dateEditor.showAccessoryImage = NO;
        dateEditor.accessoryImageView.image = nil;
    }
    else if ([editor isKindOfClass:[TKDataFormTextFieldEditor class]]) {
        layer = editor.editor.layer;
        ((TKTextField *)editor.editor).textInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    }
    
    layer.borderColor = [UIColor colorWithRed:0.880f green:0.880f blue:0.880f alpha:1.00f].CGColor;
    layer.borderWidth = 1.0;
    layer.cornerRadius = 4;
}

@end
