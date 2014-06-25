//
//  OptionInfo.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "OptionInfo.h"

@implementation OptionInfo

- (id)initWithText:(NSString*)text selector:(SEL)selector
{
    return [self initWithText:text selector:selector tag:nil];
}

- (id)initWithText:(NSString *)text selector:(SEL)selector tag:(id)tag
{
    self = [super init];
    if (self) {
        _tag = tag;
        _optionText = text;
        _selector = selector;
    }
    return self;
}

@end
