//
//  ReservationForm.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReservationForm : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSDate *time;

@property (nonatomic) NSInteger guests;

@property (nonatomic) NSInteger section;

@property (nonatomic) NSInteger table;

@property (nonatomic) NSInteger origin;

@end
