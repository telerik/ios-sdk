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
    TKListView *_listView;
    TKDataSource *_names;
    TKDataSource *_photos;
    LoremIpsumGenerator *_loremIpsum;
    long _lastRetrievedDataIndex;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Manual" selector:@selector(loadOnDemandManual) inSection:@"Load on demand mode"];
        [self addOption:@"Automatic" selector:@selector(loadOnDemandAuto) inSection:@"Load on demand mode"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lastRetrievedDataIndex = 15;
    _loremIpsum = [LoremIpsumGenerator new];
    _photos = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"photos"];
    _names = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"names"];
    
    _listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    _listView.backgroundColor = [UIColor colorWithRed:0. green:1. blue:0. alpha:0.5];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.delegate = self;
    _listView.dataSource = self;
    
    // >> listview-buffer
    _listView.loadOnDemandBufferSize = 5;
    // << listview-buffer
    
    // >> listview-load-on-demand
    _listView.loadOnDemandMode = TKListViewLoadOnDemandModeManual;
    // << listview-load-on-demand
    
    _listView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:_listView];
    [_listView registerClass:[CustomCardListViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)_listView.layout;
    layout.itemSize = CGSizeMake(100, 120);
    layout.itemSpacing = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadOnDemandManual
{
    _listView.loadOnDemandMode = TKListViewLoadOnDemandModeManual;
    _lastRetrievedDataIndex = 15;
    [_listView reloadData];
    _listView.contentOffset = CGPointZero;
}

- (void)loadOnDemandAuto
{
    _listView.loadOnDemandMode = TKListViewLoadOnDemandModeAuto;
    _lastRetrievedDataIndex = 15;
    [_listView reloadData];
    _listView.contentOffset = CGPointZero;
}

#pragma mark - TKListViewDataSource

- (NSInteger)listView:(TKListView *)listView numberOfItemsInSection:(NSInteger)section
{
    return _lastRetrievedDataIndex;
}

// >> listview-load-on-demand-deque
- (TKListViewCell*)listView:(TKListView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TKListViewCell *cell = [listView dequeueLoadOnDemandCellForIndexPath:indexPath];
    if (cell == nil) {
        cell = [listView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:_photos.items[indexPath.row]];
        cell.textLabel.text = _names.items[indexPath.row];
        cell.detailTextLabel.text = [_loremIpsum randomString:10 + (arc4random()%16) forIndexPath:indexPath];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
    cell.backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    ((TKView*)cell.backgroundView).stroke = nil;

    return cell;
}
// << listview-load-on-demand-deque

#pragma mark - TKListViewDelegate

// >> listview-should-load
- (BOOL)listView:(TKListView *)listView shouldLoadMoreDataAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        _lastRetrievedDataIndex = MIN(_names.items.count, _lastRetrievedDataIndex + 10);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            //Notifying the ListView that we have fresh data so it can hide the activity indicator and be ready for next load-on-demand request.
            
            if (_lastRetrievedDataIndex == _names.items.count) {
                listView.loadOnDemandMode = TKListViewLoadOnDemandModeNone;
            }
            
            [listView didLoadDataOnDemand];
        });
    });
    
    return YES;
}
// << listview-should-load

@end
