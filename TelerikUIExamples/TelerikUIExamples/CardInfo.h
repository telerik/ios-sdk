//
//  CardInfo.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardInfo : NSObject

@property (nonatomic) BOOL edit;

@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSString *cardNumber;

@property (nonatomic, strong) NSString *zipCode;

@property (nonatomic, strong) NSDate *expirationDate;

@end
