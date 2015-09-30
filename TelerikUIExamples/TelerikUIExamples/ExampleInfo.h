//
//  ExampleInfo.h
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExampleInfo : NSObject

@property (nonatomic, strong) NSArray *examples;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) Class exampleClass;

- (instancetype __nonnull)initWithExamples:(NSArray*)examples withTitle:(NSString*)title;

- (instancetype __nonnull)initWithClass:(Class)exampleClass withTitle:(NSString*)title;

- (UIViewController*)createController;

@end
