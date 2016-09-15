//
//  DataSourceGettingStarted.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DataSourceGettingStarted.h"
#import <TelerikUI/TelerikUI.h>

// >> datasource-gettingstarted-full
@interface DataSourceGettingStarted ()

@property (nonatomic, strong) TKDataSource *dataSource;

@end

@implementation DataSourceGettingStarted

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Getting started";
    
    // >> datasource-getting-started
    self.dataSource = [[TKDataSource alloc] initWithArray:@[ @10, @5, @12, @7, @44 ]];
    // << datasource-getting-started
    
    // >> datasource-data-shaping
    // filter all values less or equal to 5
    [self.dataSource filter:^BOOL(id item) { return [item integerValue] > 5; }];
    
    // sort ascending
    [self.dataSource sort:^NSComparisonResult(id obj1, id obj2) {
        NSInteger a = [obj1 integerValue];
        NSInteger b = [obj2 integerValue];
        if (a<b) { return NSOrderedDescending; }
        else if (a>b) { return NSOrderedAscending; }
        return NSOrderedSame;
    }];
    
    // group odd/even values
    [self.dataSource group:^id(id item) { return @([item integerValue] % 2 == 0); }];
    
    // multiply every value * 10
    [self.dataSource map:^id(id item) { return @([item integerValue] * 10); }];
    
    // find the max value
    NSNumber *maxValue = [self.dataSource reduce:@(0) with:^id(id item, id value) {
        if ([item integerValue] > [value integerValue]) {
            return item;
        }
        return value;
    }];
    // << datasource-data-shaping
    
    NSLog(@"the max value is: %@", maxValue);
    
    // >> datasource-print
    // output everything to the console
    [self.dataSource enumerate:^(id item) {
        if ([item isKindOfClass:[TKDataSourceGroup class]]) {
            TKDataSourceGroup *group = item;
            NSLog(@"group: %@", group.key);
        }
        else {
            NSLog(@"%d", (int)[item integerValue]);
        }
    }];
    // << datasource-print
    
    // >> datasource-tableview
    // bind with a table view
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self.dataSource;
    [self.view addSubview:tableView];
    // << datasource-tableview
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
// << datasource-gettingstarted-full
