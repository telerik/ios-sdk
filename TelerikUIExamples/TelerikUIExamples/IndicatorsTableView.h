//
//  IndicatorsTableViewViewController.h
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndicatorsViewController;

@interface IndicatorsTableView : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IndicatorsViewController *example;

@property (nonatomic, strong) UITableView *table;

@end
