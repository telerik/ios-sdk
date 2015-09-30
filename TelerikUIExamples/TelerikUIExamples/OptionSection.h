//
//  OptionSection.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OptionSection : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign) NSInteger selectedOption;

- (instancetype __nonnull)initWithTitle:(NSString*)title;

@end
