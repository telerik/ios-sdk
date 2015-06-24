//
//  PasswordValidator.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "PasswordValidator.h"

@implementation PasswordValidator
{
    BOOL _shortPassword;
}

- (BOOL)validateProperty:(TKDataFormEntityProperty *)property
{
    _shortPassword = NO;
    NSString *password = property.value;
    if (password.length < 6) {
        _shortPassword = YES;
        return NO;
    }
    
    return YES;
}

- (NSString *)validationMessage
{
    if (_shortPassword) {
        return @"Password must be at least 6 charactes!";
    }
    return nil;
}

@end
