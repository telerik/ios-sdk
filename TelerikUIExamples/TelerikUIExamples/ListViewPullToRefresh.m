//
//  ListViewPullToRefresh.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewPullToRefresh.h"

@interface ListViewPullToRefresh () <TKListViewDataSource, TKListViewDelegate>

@end

@implementation ListViewPullToRefresh
{
    TKDataSource *_dataSource;
    NSMutableArray *_data;
    int _newItemsCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [TKDataSource new];
    [_dataSource loadDataFromJSONResource:@"ListViewSampleData" ofType:@"json" rootItemKeyPath:@"teams"];
    _dataSource.groupItemSourceKey = @"items";
    [_dataSource filterWithQuery:@"key like 'Marketing'"];
    [_dataSource groupWithKey:@"key"];

    _newItemsCount = 0;
    _data = [NSMutableArray new];
    [self updateData:3];
    
    TKListView *listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    [listView registerClass:[TKListViewCell class] forCellWithReuseIdentifier:@"cell"];
    listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    listView.dataSource = self;
    listView.delegate = self;
    listView.allowsPullToRefresh = YES;
    listView.pullToRefreshTreshold = 70;
    listView.pullToRefreshView.backgroundColor = [UIColor blueColor];
    listView.pullToRefreshView.activityIndicator.color = [UIColor whiteColor];
    [self.view addSubview:listView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)updateData:(NSInteger)count
{
    TKDataSourceGroup *group = (TKDataSourceGroup*)_dataSource.items[0];
    long startIndex = _data.count;
    int i = 0; for (; i < count; i++) {
        if (i + startIndex >= group.items.count) {
            return i;
        }
        int points = arc4random() % 100;
        [_data insertObject:[NSString stringWithFormat:@"%@: %d points", group.items[i + startIndex], points] atIndex:0];
    }
    return i;
}

- (BOOL)isUpdated:(NSIndexPath*)indexPath
{
    return indexPath.row < _newItemsCount;
}

#pragma mark - TKListViewDataSource

- (NSInteger)listView:(TKListView *)listView numberOfItemsInSection:(NSInteger)section
{
    return _data.count;
}

- (TKListViewCell*)listView:(TKListView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TKListViewCell *cell = [listView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    BOOL isUpdated = [self isUpdated:indexPath];
    cell.textLabel.text = _data[indexPath.row];
    cell.backgroundView.backgroundColor = isUpdated ? [UIColor colorWithRed:1. green:1. blue:0. alpha:0.4] : [UIColor whiteColor];
    cell.backgroundView.alpha = isUpdated ? 0 : 1;
    if (isUpdated) {
        [UIView animateWithDuration:.5 animations:^{
            cell.backgroundView.alpha = 1;
        }];
    }
    return cell;
}

#pragma mark - TKListViewDelegate

- (void)listView:(TKListView *)listView didPullWithOffset:(CGFloat)offset
{
    listView.pullToRefreshView.alpha = MIN(offset/listView.pullToRefreshTreshold, 1.0);
}

- (BOOL)listViewShouldRefreshOnPull:(TKListView *)listView
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        _newItemsCount = [self updateData:1 + (arc4random() % 3)];
        
        //waiting a few seconds to simulate data over the wire
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            //Notifying the ListView that we have fresh data so it can hide the activity indicator and be ready for next load-on demand request.
            [listView didRefreshOnPull];
            
            if (_newItemsCount < 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pull to refresh"
                                                                message:@"No more data available!"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Close"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        });

    });
    
    return YES;
}

@end
