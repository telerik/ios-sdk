//
//  DataSourceDescriptorsAPI.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>

#import "DataSourceDescriptorsAPI.h"
#import "DSItem.h"

@interface DataSourceDescriptorsAPI ()

@property (nonatomic, strong) TKDataSource *dataSource;

@end

@implementation DataSourceDescriptorsAPI

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Descriptors API";

    self.dataSource = [TKDataSource new];
    
    [self.dataSource addFilterDescriptor:[[TKDataSourceFilterDescriptor alloc] initWithQuery:@"NOT (name like 'John')"]];
    [self.dataSource addSortDescriptor:[[TKDataSourceSortDescriptor alloc] initWithProperty:@"name" ascending:YES]];
    [self.dataSource addGroupDescriptor:[[TKDataSourceGroupDescriptor alloc] initWithProperty:@"group"]];
    
    NSMutableArray *items = [NSMutableArray new];
    [items addObject:[[DSItem alloc] initWithName:@"John" value:22.0 group:@"one"]];
    [items addObject:[[DSItem alloc] initWithName:@"Peter" value:15.0 group:@"one"]];
    [items addObject:[[DSItem alloc] initWithName:@"Abby" value:47.0 group:@"one"]];
    [items addObject:[[DSItem alloc] initWithName:@"Robert" value:45.0 group:@"two"]];
    [items addObject:[[DSItem alloc] initWithName:@"Alan" value:17.0 group:@"two"]];
    [items addObject:[[DSItem alloc] initWithName:@"Saly" value:33.0 group:@"two"]];
    
    self.dataSource.displayKey = @"name";
    self.dataSource.valueKey = @"value";
    self.dataSource.itemSource = items;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self.dataSource;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
