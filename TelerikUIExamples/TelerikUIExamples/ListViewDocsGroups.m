//
//  ListViewDocsGroups.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ListViewDocsGroups.h"
#import <TelerikUI/TelerikUI.h>
#import "DataSourceItem.h"

// >> listview-groups
@implementation ListViewDocsGroups
{
    TKDataSource *dataSource;
    NSMutableArray *_items;
    NSArray *_groups;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _groups= @[@[@"John",@"Abby"],@[@"Smith",@"Peter",@"Paula"]];
    
    _items = [NSMutableArray new];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"John" value:50 group:@"A"]];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"Abby" value:33 group:@"A"]];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"Smith" value:42 group:@"B"]];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"Peter" value:28 group:@"B"]];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"Paula" value:25 group:@"B"]];
    
    dataSource = [TKDataSource new];
    dataSource.itemSource = _items;
    dataSource.groupItemSourceKey = @"name";
    [dataSource groupWithKey:@"group"];
    
    TKListView *_listView = [[TKListView alloc] initWithFrame: CGRectMake(20, 20, self.view.bounds.size.width-40,self.view.bounds.size.height-40)];

    _listView.dataSource = dataSource;
    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)_listView.layout;
    layout.headerReferenceSize = CGSizeMake(200, 22);
    
    [self.view addSubview:_listView];
}

@end
// << listview-groups
