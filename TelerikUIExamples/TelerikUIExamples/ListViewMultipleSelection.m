//
//  ListViewMultipleSelection.m
//  TelerikUIExamples
//
//  Created by Pavel Pavlov on 2/11/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewMultipleSelection.h"

@interface ListViewMultipleSelection () <TKListViewDelegate>
@end

@implementation ListViewMultipleSelection
{
    UILabel *_label;
    TKListView *_listView;
    TKDataSource *_dataSource;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Selection on press" selector:@selector(selectionOnPressSelected)];
        [self addOption:@"Selection on hold" selector:@selector(selectionOnHoldSelected)];
        [self addOption:@"No selection" selector:@selector(noSelectionSelected)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [TKDataSource new];
    [_dataSource loadDataFromJSONResource:@"ListViewSampleData" ofType:@"json" rootItemKeyPath:@"players"];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    _listView = [[TKListView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-55)];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.delegate = self;
    _listView.dataSource = _dataSource;
    _listView.selectionBehavior = TKListViewSelectionBehaviorPress;
    _listView.allowsMultipleSelection = YES;
    [self.view addSubview:_listView];
    [_listView registerClass:[TKListViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    TKListViewColumnsLayout *layout = (TKListViewColumnsLayout*)_listView.layout;
    layout.cellAlignment = TKListViewCellAlignmentStretch;
    layout.minimumLineSpacing = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectionOnPressSelected
{
    _listView.selectionBehavior = TKListViewSelectionBehaviorPress;
}

- (void)selectionOnHoldSelected
{
    _listView.selectionBehavior = TKListViewSelectionBehaviorLongPress;
}

- (void)noSelectionSelected
{
    _listView.selectionBehavior = TKListViewSelectionBehaviorNone;
}

#pragma mark - TKListViewDelegate
 
- (void)listView:(TKListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _label.text = [NSString stringWithFormat:@"Selected: %@", _dataSource.items[indexPath.row]];
}

- (void)listView:(TKListView *)listView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did deselect item at row %ld",(long)indexPath.row);
}

@end

