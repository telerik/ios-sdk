//
//  RegisterationInfo.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterationInfo : NSObject

@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *repeatPassword;

@property (nonatomic) BOOL rememberMe;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSDate *dateOfBirth;

@property (nonatomic) NSInteger gender;

@property (nonatomic) NSInteger country;

@end
