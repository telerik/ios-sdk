//
//  OptionSection.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "OptionSection.h"

@implementation OptionSection

- (instancetype)initWithTitle:(NSString*)title
{
    self = [self init];
    if (self) {
        self.title = title;
        self.items = [NSMutableArray new];
    }
    return self;
}

@end
