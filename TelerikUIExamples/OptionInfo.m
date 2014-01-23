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
    self = [self init];
    if (self) {
        self.optionText = text;
        self.selector = selector;
    }
    return self;
}

@end
