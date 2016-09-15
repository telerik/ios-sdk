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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    // >> listview-selection-behavior
    _listView.selectionBehavior = TKListViewSelectionBehaviorPress;
    // << listview-selection-behavior
    
    // >> listview-multiple-selection
    _listView.allowsMultipleSelection = YES;
    // << listview-multiple-selection
    
    [self.view addSubview:_listView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _label.textAlignment = NSTextAlignmentCenter;
    [_listView addSubview:_label];

    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)_listView.layout;
    layout.itemSpacing = 0;
    
    // select the second row
    
    // >> listview-selection-programatically
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [_listView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    // << listview-selection-programatically
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
    // >> listview-selection-behavior-long
    _listView.selectionBehavior = TKListViewSelectionBehaviorLongPress;
    // << listview-selection-behavior-long
}

- (void)noSelectionSelected
{
    // >> listview-selection-behavior-none
    _listView.selectionBehavior = TKListViewSelectionBehaviorNone;
    // << listview-selection-behavior-none
    _label.text = @"";
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

- (void)listView:(TKListView *)listView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did highlight item at row %ld", (long)indexPath.row);
    TKListViewCell *cell = [listView cellForItemAtIndexPath:indexPath];
    if (!cell.selected && listView.selectionBehavior == TKListViewSelectionBehaviorLongPress) {
        cell.selectedBackgroundView.hidden = YES;
    }
}

- (void)listView:(TKListView *)listView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did unhighlight item at row %ld", (long)indexPath.row);
}

// >> listview-respond
- (void)listView:(TKListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _label.text = [NSString stringWithFormat:@"Selected: %@", _dataSource.items[indexPath.row]];
    NSLog(@"Did select item at row %ld", (long)indexPath.row);
    TKListViewCell *cell = [listView cellForItemAtIndexPath:indexPath];
    cell.selectedBackgroundView.hidden = NO;
    cell.selectedBackgroundView.backgroundColor = [UIColor greenColor];
    
}

- (void)listView:(TKListView *)listView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did deselect item at row %ld", (long)indexPath.row);
}
// << listview-respond

@end
