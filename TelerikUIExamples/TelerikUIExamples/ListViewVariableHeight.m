//
//  ListViewVariableHeight.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewVariableHeight.h"
#import "ListViewDynamicHeightCell.h"
#import "LoremIpsumGenerator.h"

@interface ListViewVariableHeight ()

@end

@implementation ListViewVariableHeight
{
    NSMutableArray *_items;
    TKDataSource *_dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LoremIpsumGenerator *loremGenerator = [LoremIpsumGenerator new];
    _items = [NSMutableArray new];
    for (int i = 0; i<20; i++) {
        [_items addObject:[loremGenerator generateString:2 + arc4random()%30]];
    }

    _dataSource = [[TKDataSource alloc] initWithArray:_items];
    _dataSource.settings.listView.defaultCellClass = [ListViewDynamicHeightCell class];
    [_dataSource.settings.listView initCell:^(TKListView * _Nonnull listView, NSIndexPath * _Nonnull indexPath, TKListViewCell * _Nonnull cell, id  _Nonnull item) {
        ListViewDynamicHeightCell *myCell = (ListViewDynamicHeightCell*)cell;
        myCell.label.text = item;
        [myCell.label setNeedsLayout];
    }];
    
    TKListView *listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    listView.dataSource = _dataSource;
    [self.view addSubview:listView];
    
    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)listView.layout;
    layout.dynamicItemSize = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
