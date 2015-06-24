//
//  EmailValidator.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "EmailValidator.h"

@implementation EmailValidator
{
    BOOL _emptyField;
    BOOL _incorrectFormat;
}

- (BOOL)validateProperty:(TKDataFormEntityProperty *)property
{
    _emptyField = NO;
    _incorrectFormat = NO;
    NSString *email = property.value;
    if (!email || email.length == 0) {
        _emptyField = YES;
        return NO;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    _incorrectFormat = ![emailPredicate evaluateWithObject:email];
    if (_incorrectFormat) {
        return NO;
    }
    
    return YES;
}

- (NSString *)validationMessage
{
    if (_emptyField) {
        return @"Email is required!";
    }
    
    if (_incorrectFormat) {
        return @"Incorrect email!";
    }
    
    return nil;
}

@end
