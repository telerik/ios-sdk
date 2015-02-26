//
//  DSItem.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DSItem.h"

@implementation DSItem

- (id)initWithName:(NSString*)name value:(CGFloat)value group:(NSString *)group
{
    self = [self init];
    if (self) {
        self.name = name;
        self.value = value;
        self.group = group;
    }
    return self;
}

@end
