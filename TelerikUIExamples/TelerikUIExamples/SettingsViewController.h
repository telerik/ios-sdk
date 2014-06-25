//
//  SettingsViewController.h
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExampleViewController;

@interface SettingsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

- (id)initWithOptions:(NSArray*)options;

@property (nonatomic, weak) ExampleViewController *example;

@property (nonatomic, assign) NSInteger selectedOption;

@property (nonatomic, strong) NSArray *options;

@property (nonatomic, strong) UITableView *table;

//- (void)initialSelection;

@end
