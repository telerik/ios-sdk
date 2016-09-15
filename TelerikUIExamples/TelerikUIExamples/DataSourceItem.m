//
//  DataSourceItem.m
//  TelerikUIExamples
//
//  Created by Sophia Lazarova on 5/31/16.
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "DataSourceItem.h"

@implementation DataSourceItem

- (instancetype)initWithName:(NSString*)name value:(CGFloat)value
{
    self = [self init];
    if (self) {
        self.name = name;
        self.value = value;
    }
    return self;
}

- (instancetype)initWithName:(NSString*)name value:(CGFloat)value group:(NSString*)group
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
