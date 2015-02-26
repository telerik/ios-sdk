//
//  DataSourceGettingStarted.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DataSourceGettingStarted.h"
#import <TelerikUI/TelerikUI.h>

@interface DataSourceGettingStarted ()

@property (nonatomic, strong) TKDataSource *dataSource;

@end

@implementation DataSourceGettingStarted

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Getting started";
    
    TKDataSource *dataSource = [[TKDataSource alloc] initWithArray:@[ @10, @5, @12, @7, @44 ]];
    
    // filter all values less or equal to 5
    [dataSource filter:^BOOL(id item) { return [item integerValue] > 5; }];
    
    // sort ascending
    [dataSource sort:^NSComparisonResult(id obj1, id obj2) {
        NSInteger a = [obj1 integerValue];
        NSInteger b = [obj2 integerValue];
        if (a<b) { return NSOrderedDescending; }
        else if (a>b) { return NSOrderedAscending; }
        return NSOrderedSame;
    }];
    
    // group odd/even values
    [dataSource group:^id(id item) { return @([item integerValue] % 2 == 0); }];
    
    // multiply every value * 10
    [dataSource map:^id(id item) { return @([item integerValue] * 10); }];
    
    // find the max value
    NSNumber *maxValue = [dataSource reduce:@(0) with:^id(id item, id value) {
        if ([item integerValue] > [value integerValue]) {
            return item;
        }
        return value;
    }];
    NSLog(@"the max value is: %@", maxValue);
    
    // output everything to the console
    [dataSource enumerate:^(id item) {
        if ([item isKindOfClass:[TKDataSourceGroup class]]) {
            TKDataSourceGroup *group = item;
            NSLog(@"group: %@", group.key);
        }
        else {
            NSLog(@"%d", (int)[item integerValue]);
        }
    }];
    
    // bind with a table view
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = dataSource;
    [self.view addSubview:tableView];
    
    self.dataSource = dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
