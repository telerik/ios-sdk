//
//  ListViewReorder.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "ListViewReorder.h"
#import <TelerikUI/TelerikUI.h>

@interface ListViewReorder ()

@end

@implementation ListViewReorder
{
    TKListView *_listView;
    TKDataSource *_dataSource;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Enable reorder mode" selector:@selector(enableReorderSelected)];
        [self addOption:@"Disable reorder mode" selector:@selector(disableReorderSelected)];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataSource = [TKDataSource new];
    _dataSource.allowItemsReorder = YES;
    [_dataSource loadDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"names"];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        _listView = [[TKListView alloc] initWithFrame:self.exampleBounds];
    }
    else {
        _listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    }
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.dataSource = _dataSource;
    _listView.delegate = _dataSource;
   _listView.allowsCellReorder = YES;
    [self.view addSubview:_listView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enableReorderSelected
{
    _listView.allowsCellReorder = YES;
}

- (void)disableReorderSelected
{
    _listView.allowsCellReorder = NO;
}

@end
