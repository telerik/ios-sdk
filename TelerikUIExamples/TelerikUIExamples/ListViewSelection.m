//
//  ListViewSelection.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewSelection.h"

@interface ListViewSelection () <TKListViewDelegate>
@end

@implementation ListViewSelection
{
    UILabel *_label;
    TKListView *_listView;
    TKDataSource *_dataSource;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Selection on press" selector:@selector(selectionOnPressSelected) inSection:@"Selection type"];
        [self addOption:@"Selection on hold " selector:@selector(selectionOnHoldSelected) inSection:@"Selection type"];
        [self addOption:@"No selection" selector:@selector(noSelectionSelected) inSection:@"Selection type"];
        
        [self addOption:@"YES" selector:@selector(multipleSelectionSelected) inSection:@"Multiple selection"];
        [self addOption:@"NO" selector:@selector(singleSelectionSelected) inSection:@"Multiple selection"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [TKDataSource new];
    [_dataSource loadDataFromJSONResource:@"ListViewSampleData" ofType:@"json" rootItemKeyPath:@"players"];
    
    _listView = [[TKListView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 55)];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.delegate = self;
    _listView.dataSource = _dataSource;
    _listView.selectionBehavior = TKListViewSelectionBehaviorPress;
    _listView.allowsMultipleSelection = YES;
    [self.view addSubview:_listView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _label.textAlignment = NSTextAlignmentCenter;
    [_listView addSubview:_label];

    TKListViewColumnsLayout *layout = (TKListViewColumnsLayout*)_listView.layout;
    layout.cellAlignment = TKListViewCellAlignmentStretch;
    layout.minimumLineSpacing = 0;

    // select the second row
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [_listView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectionOnPressSelected
{
    _listView.selectionBehavior = TKListViewSelectionBehaviorPress;
    [_listView.layout invalidateLayout];
}

- (void)selectionOnHoldSelected
{
    _listView.selectionBehavior = TKListViewSelectionBehaviorLongPress;
}

- (void)noSelectionSelected
{
    _listView.selectionBehavior = TKListViewSelectionBehaviorNone;
    [_listView clearSelectedItems];
}

- (void)multipleSelectionSelected
{
    _listView.allowsMultipleSelection = YES;
}

- (void)singleSelectionSelected
{
    _listView.allowsMultipleSelection = NO;
}

#pragma mark - TKListViewDelegate

- (void)listView:(TKListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _label.text = [NSString stringWithFormat:@"Selected: %@", _dataSource.items[indexPath.row]];
    NSLog(@"Did select item at row %ld",(long)indexPath.row);
}

- (void)listView:(TKListView *)listView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did deselect item at row %ld",(long)indexPath.row);
}

@end
