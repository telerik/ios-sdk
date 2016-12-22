//
//  DataFormEditorsAutoComplete.m
//  TelerikUIExamples
//
//  Created by Vladimir Amiorkov on 12/22/16.
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "DataFormEditorsAutoComplete.h"
#import "PersonalInfo.h"
#import "Booking.h"

@implementation DataFormEditorsAutoComplete
{
    TKDataFormEntityDataSource *_dataSource;
    Booking *_booking;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _booking = [Booking new];
    _booking.from = @[@"Goroka, GKA", @"Madang, MAG"];
    _booking.to = @"Nadzab, LAE";
    self.dataForm.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.dataForm.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.960 alpha:1.0];
    
    _dataSource = [[TKDataFormEntityDataSource alloc] initWithObject:_booking];
    
    _dataSource[@"from"].hintText = @"Fly from where";
    _dataSource[@"from"].editorClass = [TKDataFormAutoCompleteInlineEditor class];
    _dataSource[@"from"].autoCompleteDisplayMode = TKAutoCompleteDisplayModeTokens;
    _dataSource[@"from"].valuesProvider =  @[@"Goroka, GKA", @"Madang, MAG", @"Mount Hagen, HGU", @"Nadzab, LAE"];

    _dataSource[@"to"].editorClass = [TKDataFormAutoCompleteInlineEditor class];
    _dataSource[@"to"].valuesProvider =  @[@"Goroka, GKA", @"Madang, MAG", @"Mount Hagen, HGU", @"Nadzab, LAE"];
    
    self.dataForm.dataSource = _dataSource;
    self.dataForm.commitMode = TKDataFormCommitModeOnLostFocus;
}
@end
