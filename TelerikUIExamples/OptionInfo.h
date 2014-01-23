//
//  OptionInfo.h
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OptionInfo : NSObject

- (id)initWithText:(NSString*)text selector:(SEL)selector;

@property (nonatomic, strong) NSString *optionText;
@property (nonatomic, assign) SEL selector;

@end
