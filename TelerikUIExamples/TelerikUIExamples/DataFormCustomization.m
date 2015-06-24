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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [TKDataFormEntityDataSource new];
    _dataSource.selectedObject = [ReservationForm new];
    
    self.dataForm.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood-pattern"]];
    self.dataForm.dataSource = _dataSource;
    
    [self.dataForm registerEditor:[CallEditor class] forProperty:[_dataSource.entityModel propertyWithName:@"phone"]];
    [self.dataForm registerEditor:[CallEditor class] forProperty:[_dataSource.entityModel propertyWithName:@"cancelReservation"]];
    [self.dataForm registerEditor:[TKDataFormOptionsEditor class] forProperty:[_dataSource.entityModel propertyWithName:@"section"]];
    [self.dataForm registerEditor:[TKDataFormOptionsEditor class] forProperty:[_dataSource.entityModel propertyWithName:@"table"]];
    [self.dataForm registerEditor:[TKDataFormSegmentedEditor class] forProperty:[_dataSource.entityModel propertyWithName:@"origin"]];
    
    [_dataSource.entityModel propertyWithName:@"name"].image = [UIImage imageNamed:@"guest-name"];
    [_dataSource.entityModel propertyWithName:@"phone"].image = [UIImage imageNamed:@"phone"];
    [_dataSource.entityModel propertyWithName:@"date"].image = [UIImage imageNamed:@"calendar"];
    [_dataSource.entityModel propertyWithName:@"time"].image = [UIImage imageNamed:@"time"];
    [_dataSource.entityModel propertyWithName:@"guests"].image = [UIImage imageNamed:@"guest-number"];
    [_dataSource.entityModel propertyWithName:@"table"].image = [UIImage imageNamed:@"table-number"];
    
    [_dataSource.entityModel.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TKDataFormEntityProperty *property = (TKDataFormEntityProperty*)obj;
        if ([property.name isEqualToString:@"section"] || [property.name isEqualToString:@"table"]) {
            property.groupKey = @"TABLE DETAILS";
        }
        else if ([property.name isEqualToString:@"origin"] || [property.name isEqualToString:@"cancelReservation"]) {
            property.groupKey = @"ORIGIN";
        }
        else {
            property.groupKey = @"RESERVATION DETAILS";
        }
    }];
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

- (BOOL)dataForm:(TKDataForm *)dataForm validateProperty:(TKDataFormEntityProperty *)propery editor:(TKDataFormEditor *)editor
{
    if ([propery.name isEqualToString:@"name"]) {
        NSString *value = propery.value;
        if (value.length == 0) {
            return NO;
        }
    }
    return YES;
}

- (void)dataForm:(TKDataForm *)dataForm didValidateProperty:(TKDataFormEntityProperty *)propery editor:(TKDataFormEditor *)editor
{
    if ([propery.name isEqualToString:@"name"]) {
        if (!propery.isValid) {
            propery.feedbackMessage = @"Please fill in the guest name";
        }
        else {
            propery.feedbackMessage = nil;
        }
    }
}

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKDataFormEntityProperty *)property
{
    editor.style.textLabelOffset = UIOffsetMake(25, 0);
    editor.style.separatorLeadingSpace = 40;
    editor.style.accessoryArrowStroke = [TKStroke strokeWithColor:[UIColor colorWithRed:0.780 green:0.2 blue:0.223 alpha:1.0]];
    if ([property.name isEqualToString:@"name"]) {
        if (!property.isValid) {
            editor.style.feedbackLabelOffset = UIOffsetMake(25, -5);
            editor.style.editorOffset = UIOffsetMake(25, -7);
        }
        else {
            editor.style.feedbackLabelOffset = UIOffsetMake(25, 0);
            editor.style.editorOffset = UIOffsetMake(25, 0);
        }
        
        editor.feedbackLabel.font = [UIFont fontWithName:@"Verdana-Italic" size:10];
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        ((UITextField *)editor.editor).placeholder = @"Name";
    }
    
    if ([property.name isEqualToString:@"time"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        editor.style.textLabelOffset = UIOffsetMake(25, 0);
        ((TKDataFormDatePickerEditor *)editor).dateFormatter.dateFormat = @"h:mm a";
        ((UIDatePicker *)editor.editor).datePickerMode = UIDatePickerModeTime;
    }
    
    if ([property.name isEqualToString:@"date"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        editor.style.textLabelOffset = UIOffsetMake(25, 0);
    }
    
    if ([property.name isEqualToString:@"guests"]) {
        UIStepper *stepper = ((UIStepper *)editor.editor);
        stepper.minimumValue = 1;
        stepper.tintColor = [UIColor colorWithRed:0.780 green:0.2 blue:0.223 alpha:1.0];
        [stepper setIncrementImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [stepper setDecrementImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    }
    
    if ([property.name isEqualToString:@"section"]) {
        editor.textLabel.textColor = [UIColor whiteColor];
        editor.backgroundColor = [UIColor clearColor];
        ((TKDataFormOptionsEditor *)editor).options = @[@"Section 1", @"Section 2", @"Section 3", @"Section 4"];
        ((TKDataFormOptionsEditor *)editor).selectedOptionLabel.textColor = [UIColor whiteColor];
    }
    
    if ([property.name isEqualToString:@"table"]) {
        editor.textLabel.textColor = [UIColor whiteColor];
        editor.backgroundColor = [UIColor clearColor];
        ((TKDataFormOptionsEditor *)editor).options = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15"];
        ((TKDataFormOptionsEditor *)editor).selectedOptionLabel.textColor = [UIColor whiteColor];
    }
    
    if ([property.name isEqualToString:@"origin"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        editor.style.editorOffset = UIOffsetMake(25, 0);
        ((TKDataFormSegmentedEditor *)editor).segments = @[@"phone", @"in-person", @"online", @"other"];
        UISegmentedControl *segmentedControl = (UISegmentedControl *)editor.editor;
        segmentedControl.tintColor = [UIColor colorWithRed:0.780 green:0.2 blue:0.223 alpha:1.0];
    }
    
    if ([property.name isEqualToString:@"cancelReservation"]) {
        editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayModeHidden;
        editor.style.editorOffset = UIOffsetMake(25, 0);
        [((CallEditor *)editor).actionButton setTitle:property.displayName forState:UIControlStateNormal];
        [((CallEditor *)editor).actionButton addTarget:self action:@selector(cancelReservation) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIView *)dataForm:(TKDataForm *)dataForm viewForHeaderInSection:(NSInteger)section
{
    TKDataFormHeaderView *header = [[TKDataFormHeaderView alloc] init];
    header.titleLabel.textColor = [UIColor grayColor];
    header.insets = UIEdgeInsetsMake(0, 40, 0, 0);
    header.separatorColor = [TKSolidFill solidFillWithColor:[UIColor clearColor]];
    if (section == 0) {
        header.titleLabel.text = @"RESERVATION DETAILS";
    }
    else if (section == 1) {
        header.titleLabel.text = @"TABLE DETAILS";
        header.backgroundColor = [UIColor clearColor];
    }
    else {
        header.titleLabel.text = @"ORIGIN";
    }
    
    return header;
}

- (CGFloat)dataForm:(TKDataForm *)dataForm heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

@end
