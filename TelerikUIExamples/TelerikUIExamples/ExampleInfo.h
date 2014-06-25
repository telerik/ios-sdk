//
//  ExampleInfo.h
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExampleInfo : NSObject

@property (nonatomic, strong) NSArray *examples;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) Class exampleClass;

- (id)initWithExamples:(NSArray*)examples withTitle:(NSString*)title;

- (id)initWithClass:(Class)exampleClass withTitle:(NSString*)title;

- (UIViewController*)createController;

@end
