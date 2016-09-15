//
//  DataSourceDocsQueries.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "DataSourceDocsQueries.h"
#import "DSItem.h"
#import <TelerikUI/TelerikUI.h>

// >> datasource-predicate-style
@implementation DataSourceDocsQueries
{
    TKDataSource *dataSource;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    // >> datasource-displaykey
    NSMutableArray *items = [NSMutableArray new];
    [items addObject:[[DSItem alloc] initWithName:@"John" value:50 group:@"A"]];
    [items addObject:[[DSItem alloc] initWithName:@"Abby" value:33 group:@"A"]];
    [items addObject:[[DSItem alloc] initWithName:@"Smith" value:42 group:@"B"]];
    [items addObject:[[DSItem alloc] initWithName:@"Peter" value:28 group:@"B"]];
    [items addObject:[[DSItem alloc] initWithName:@"Paula" value:25 group:@"B"]];
    
    dataSource = [TKDataSource new];
    dataSource.itemSource = items;
    dataSource.displayKey = @"name";
    // << datasource-displaykey
    [dataSource filterWithQuery:@"value > 30"];
    [dataSource sortWithKey:@"value" ascending:true];
    [dataSource groupWithKey:@"group"];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = dataSource;
    [self.view addSubview:tableView];
}

@end
// << datasource-predicate-style
