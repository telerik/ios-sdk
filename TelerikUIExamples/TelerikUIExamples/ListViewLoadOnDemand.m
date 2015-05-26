//
//  ListViewLoadOnDemand.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewLoadOnDemand.h"
#import "CustomCardListViewCell.h"
#import "LoremIpsumGenerator.h"

@interface ListViewLoadOnDemand () <TKListViewDataSource, TKListViewDelegate>
@end

@implementation ListViewLoadOnDemand
{
    TKDataSource *_names;
    TKDataSource *_photos;
    LoremIpsumGenerator *_loremIpsum;
    long _lastRetrievedDataIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lastRetrievedDataIndex = 15;
    _loremIpsum = [LoremIpsumGenerator new];
    _photos = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"photos"];
    _names = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"names"];
    
    TKListView *listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    listView.backgroundColor = [UIColor colorWithRed:0. green:1. blue:0. alpha:0.5];
    listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    listView.delegate = self;
    listView.dataSource = self;
    listView.cellBufferSize = 5;
    listView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:listView];
    [listView registerClass:[CustomCardListViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)listView.layout;
    layout.itemSize = CGSizeMake(100, 120);
    layout.itemSpacing = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TKListViewDataSource

- (NSInteger)listView:(TKListView *)listView numberOfItemsInSection:(NSInteger)section
{
    return _lastRetrievedDataIndex;
}

- (TKListViewCell*)listView:(TKListView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TKListViewCell *cell = [listView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    cell.imageView.image = [UIImage imageNamed:_photos.items[indexPath.row]];
    cell.textLabel.text = _names.items[indexPath.row];
    cell.detailTextLabel.text = [_loremIpsum randomString:10 + (arc4random()%16) forIndexPath:indexPath];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    ((TKView*)cell.backgroundView).stroke = nil;
    return cell;
}

#pragma mark - TKListViewDelegate

- (BOOL)listView:(TKListView *)listView shouldLoadMoreDataAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        _lastRetrievedDataIndex = MIN(_names.items.count, _lastRetrievedDataIndex + 10);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            //Notifying the ListView that we have fresh data so it can hide the activity indicator and be ready for next load-on-demand request.
            [listView didLoadDataOnDemand];
        });
    });
    
    return YES;
}

@end
