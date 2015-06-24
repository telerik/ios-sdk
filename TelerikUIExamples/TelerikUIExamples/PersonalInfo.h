//
//  PersonalInfo.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalInfo : NSObject

@property (nonatomic) NSInteger protocol;

@property (nonatomic, strong) NSString *details;

@property (nonatomic, strong) NSString *server;

@property (nonatomic, strong) NSString *account;

@property (nonatomic) BOOL secure;

@property (nonatomic, strong) NSString *password;

@property (nonatomic) NSInteger encryptionLevel;

@property (nonatomic) BOOL sendAllTraffic;

@end
