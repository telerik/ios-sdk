//
//  ExampleInfo.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "ExampleInfo.h"
#import "ViewController.h"

@implementation ExampleInfo

- (id)initWithExamples:(NSArray*)examples withTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        _examples = examples;
        _title = title;
    }
    return self;
}

- (id)initWithClass:(Class)exampleClass withTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        _exampleClass = exampleClass;
        _title = title;
    }
    return self;
}

- (UIViewController *)createController
{
    UIViewController *controller = _examples ? [[ViewController alloc] initWithExample:self] : [[_exampleClass alloc] init];
    controller.title = self.title;
    return controller;
}

@end
