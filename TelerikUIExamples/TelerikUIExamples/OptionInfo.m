//
//  OptionInfo.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "OptionInfo.h"

@implementation OptionInfo

- (instancetype)initWithText:(NSString*)text selector:(SEL)selector
{
    return [self initWithText:text selector:selector tag:nil];
}

- (instancetype)initWithText:(NSString *)text selector:(SEL)selector tag:(id)tag
{
    self = [self init];
    if (self) {
        _tag = tag;
        _optionText = text;
        _selector = selector;
    }
    return self;
}

@end
