//
//  ListViewReorder.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "ListViewReorder.h"
#import <TelerikUI/TelerikUI.h>

@interface ListViewReorder () <TKListViewDelegate>

@end

@implementation ListViewReorder
{
    TKListView *_listView;
    TKDataSource *_dataSource;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Reorder with handle" selector:@selector(reorderWithHandleSelected)];
        [self addOption:@"Reorder with long press" selector:@selector(reorderWithLongPressSelected)];
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
    _listView.delegate = self;
   _listView.allowsCellReorder = YES;
    [self.view addSubview:_listView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reorderWithHandleSelected
{
    _listView.allowsCellReorder = YES;
    _listView.reorderMode = TKListViewReorderModeWithHandle;
}

- (void)reorderWithLongPressSelected
{
    _listView.allowsCellReorder = YES;
    _listView.reorderMode = TKListViewReorderModeWithLongPress;
}

- (void)disableReorderSelected
{
    _listView.allowsCellReorder = NO;
}

#pragma mark - TKListViewDelegate

- (void)listView:(TKListView *)listView willReorderItemAtIndexPath:(NSIndexPath *)indexPath
{
    TKListViewCell *cell = [listView cellForItemAtIndexPath:indexPath];
    cell.backgroundView.backgroundColor = [UIColor yellowColor];
}

- (void)listView:(TKListView *)listView didReorderItemFromIndexPath:(NSIndexPath *)originalIndexPath toIndexPath:(NSIndexPath *)targetIndexPath
{
    TKListViewCell *cell = [listView cellForItemAtIndexPath:originalIndexPath];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    [_dataSource listView:listView didReorderItemFromIndexPath:originalIndexPath toIndexPath:targetIndexPath];
}

@end
