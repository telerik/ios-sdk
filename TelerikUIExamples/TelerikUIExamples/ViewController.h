//
//  ViewController.h
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExampleInfo;

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

- (instancetype __nonnull)initWithExample:(ExampleInfo*)example;

@end
