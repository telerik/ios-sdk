//
//  ListViewGroups.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewGroups.h"

@interface ListViewGroups ()

@end

@implementation ListViewGroups
{
    TKDataSource *_dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [TKDataSource new];
    [_dataSource loadDataFromJSONResource:@"ListViewSampleData" ofType:@"json" rootItemKeyPath:@"teams"];
    _dataSource.groupItemSourceKey = @"items";
    [_dataSource groupWithKey:@"key"];
    
    TKListView *listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    listView.dataSource = _dataSource;
    listView.selectionBehavior = TKListViewSelectionBehaviorPress;
    [self.view addSubview:listView];
    
    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)listView.layout;
    layout.itemSize = CGSizeMake(300, 44);
    layout.itemSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(100, 44);
    layout.footerReferenceSize = CGSizeMake(100, 44);
        
    [_dataSource.settings.listView initCell:^(TKListView *listView, NSIndexPath *indexPath, TKListViewCell *cell, id item) {
        TKDataSourceGroup *group = _dataSource.items[indexPath.section];
        cell.textLabel.text = group.items[indexPath.row];
    }];
    
    [_dataSource.settings.listView initHeader:^(TKListView *listView, NSIndexPath *indexPath, TKListViewHeaderCell *headerCell, TKDataSourceGroup *group) {
        headerCell.textLabel.text = [NSString stringWithFormat:@"%@", group.key];
        headerCell.textLabel.textAlignment = NSTextAlignmentCenter;
    }];
    
    [_dataSource.settings.listView initFooter:^(TKListView *listView, NSIndexPath *indexPath, TKListViewFooterCell *footerCell, TKDataSourceGroup *group) {
        footerCell.textLabel.text = [NSString stringWithFormat:@"Members count: %d", (int)group.items.count];
        footerCell.textLabel.textAlignment = NSTextAlignmentLeft;
        footerCell.textLabel.frame = CGRectMake(5, 10, 200, 22);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
