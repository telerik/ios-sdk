//
//  OptionInfo.h
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OptionInfo : NSObject

- (instancetype __nonnull)initWithText:(NSString*)text selector:(SEL)selector;

- (instancetype __nonnull)initWithText:(NSString *)text selector:(SEL)selector tag:(id)tag;

@property (nonatomic, copy) NSString *optionText;

@property (nonatomic, assign) SEL selector;

@property (nonatomic) id tag;

@end
