//
//  DataFormCustomization.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DataFormCustomization.h"
#import "ReservationForm.h"
#import "CallEditor.h"

@implementation DataFormCustomization
{
    TKDataFormEntityDataSource *_dataSource;
    ReservationForm *_reservationForm;
    UIButton *_btn;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _reservationForm = [ReservationForm new];
    
    _dataSource = [[TKDataFormEntityDataSource alloc] initWithObject:_reservationForm];

    TKEntityProperty *name = _dataSource[@"name"];
    name.hintText = @"Name";
    name.image = [UIImage imageNamed:@"guest-name"];
    
    TKDataFormNonEmptyValidator *nonEmptyValidator = [[TKDataFormNonEmptyValidator alloc] init];
    nonEmptyValidator.errorMessage = @"Please fill in the guest name";
    name.validators = @[nonEmptyValidator];
    
    TKEntityProperty *phone = _dataSource[@"phone"];
    phone.hintText = @"Phone";
    phone.image = [UIImage imageNamed:@"phone"];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"h:mm a";
    _dataSource[@"time"].formatter = formatter;
    
    _dataSource[@"date"].image = [UIImage imageNamed:@"calendar"];
    _dataSource[@"time"].image = [UIImage imageNamed:@"time"];
    _dataSource[@"guests"].image = [UIImage imageNamed:@"guest-number"];
    _dataSource[@"table"].image = [UIImage imageNamed:@"table-number"];
    
    _dataSource[@"time"].editorClass = [TKDataFormTimePickerEditor class];
    _dataSource[@"phone"].editorClass = [CallEditor class];
    _dataSource[@"origin"].editorClass = [TKDataFormSegmentedEditor class];
    _dataSource[@"name"].editorClass = [TKDataFormTextFieldEditor class];
    
    _dataSource[@"guests"].range = [TKRange rangeWithMinimum:@1 andMaximum:@10];
    _dataSource[@"section"].valuesProvider = @[ @"Section 1", @"Section 2", @"Section 3", @"Section 4" ];
    _dataSource[@"table"].valuesProvider = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15 ];
    _dataSource[@"origin"].valuesProvider = @[ @"phone", @"in-person", @"online", @"other" ];
    [_dataSource.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TKEntityProperty *property = (TKEntityProperty*)obj;
        if ([property.name isEqualToString:@"section"] || [property.name isEqualToString:@"table"]) {
            property.groupName = @"TABLE DETAILS";
        }
        else if ([property.name isEqualToString:@"origin"]) {
            property.groupName = @"ORIGIN";
        }
        else {
            property.groupName = @"RESERVATION DETAILS";
        }
    }];
    
    self.dataForm.dataSource = _dataSource;
    self.dataForm.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 66);
    self.dataForm.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood-pattern"]];
    self.dataForm.tintColor = [UIColor colorWithRed:0.780 green:0.2 blue:0.223 alpha:1.0];
    self.dataForm.validationMode = TKDataFormValidationModeOnLostFocus;
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.dataForm.frame.size.height, self.view.bounds.size.width, 66)];
    [_btn setTitle:@"Cancel reservation" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor colorWithRed:0.780 green:0.2 blue:0.223 alpha:1.0] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(cancelReservation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btn];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _btn.frame = CGRectMake(0, self.dataForm.frame.size.height, self.view.bounds.size.width, 66);
}

- (void)cancelReservation
{
    TKAlert *alert = [TKAlert new];
    
    alert.style.cornerRadius = 3;
    alert.title = @"Cancel Reservation";
    alert.message = @"Reservation Canceled!";

    [alert addActionWithTitle:@"OK" handler:^BOOL(TKAlert *alert, TKAlertAction *action) {
        return YES;
    }];
    
    [alert show:YES];
}

#pragma mark TKDataFormDelegate

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKEntityProperty *)property
{
    editor.style.textLabelOffset = UIOffsetMake(10, 0);
    editor.style.separatorLeadingSpace = 40;
    editor.style.accessoryArrowStroke = [TKStroke strokeWithColor:[UIColor colorWithRed:0.780 green:0.2 blue:0.223 alpha:1.0]];
    if ([@[@"origin", @"date", @"time", @"name", @"phone"] containsObject:property.name]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        TKGridLayoutCellDefinition *titleDef = [editor.gridLayout definitionForView:editor.textLabel];
        [editor.gridLayout setWidth:0 forColumn:[titleDef.column integerValue]];
        editor.style.editorOffset = UIOffsetMake(10, 0);
    }
    
    if ([property.name isEqualToString:@"origin"]) {
        editor.style.editorOffset = UIOffsetMake(0, 0);
        editor.style.separatorColor = nil;
    }
    
    if ([property.name isEqualToString:@"name"]) {
        editor.style.feedbackLabelOffset = UIOffsetMake(10, 0);
        editor.feedbackLabel.font = [UIFont fontWithName:@"Verdana-Italic" size:10];
    }
    
    if ([property.name isEqualToString:@"guests"]) {
        TKGridLayoutCellDefinition *labelDef = [editor.gridLayout definitionForView:((TKDataFormStepperEditor *)editor).valueLabel];
        labelDef.contentOffset = UIOffsetMake(-25, 0);
    }
    
    if ([property.name isEqualToString:@"section"]) {
        UIImage *img = [UIImage imageNamed:@"guest-name"];
        editor.style.textLabelOffset = UIOffsetMake(img.size.width + 10, 0);
    }
    
    if ([property.name isEqualToString:@"table"] || [property.name isEqualToString:@"section"]) {
        editor.textLabel.textColor = [UIColor whiteColor];
        editor.backgroundColor = [UIColor clearColor];
        ((TKDataFormOptionsEditor *)editor).selectedOptionLabel.textColor = [UIColor whiteColor];
        editor.style.editorOffset = UIOffsetMake(-10, 0);
        ((TKDataFormOptionsEditor *)editor).selectedOptionLabel.textAlignment = NSTextAlignmentRight;
    }
}

- (void)dataForm:(TKDataForm *)dataForm updateGroupView:(TKEntityPropertyGroupView *)groupView forGroupAtIndex:(NSUInteger)groupIndex
{
    groupView.titleView.titleLabel.textColor = [UIColor lightGrayColor];
    groupView.titleView.titleLabel.font = [UIFont systemFontOfSize:13];
    groupView.titleView.style.insets = UIEdgeInsetsMake(0, 10, 0, 0);
    if (groupIndex == 1) {
        groupView.editorsContainer.backgroundColor = [UIColor clearColor];
    }
}
@end
