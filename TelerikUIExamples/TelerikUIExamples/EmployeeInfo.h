//
//  EmployeeInfo.h
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmployeeInfo : NSObject

@property (nonatomic, strong) NSString *givenNames;

@property (nonatomic, strong) NSString *surname;

@property (nonatomic) NSInteger gender;

@property (nonatomic, strong) NSString *idNumber;

@property (nonatomic, strong) NSString *employeeId;

@property (nonatomic, strong) NSDate *dateOfBirth;

@property (nonatomic, strong) NSString *phoneNumber;

@end
