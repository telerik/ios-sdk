//
//  ListViewWrapLayout.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewLayout.h"
#import "CustomListCell.h"

@interface ListViewLayout () <TKListViewLinearLayoutDelegate>

@end

@implementation ListViewLayout
{
    TKDataSource *_dataSource;
    NSArray *_categories;
    NSMutableArray *_sizes;
    TKListView *_listView;
    TKListViewScrollDirection _scrollDirection;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Linear layout" selector:@selector(linearLayoutSelected) inSection:@"Layout"];
        [self addOption:@"Grid layout" selector:@selector(gridLayoutSelected) inSection:@"Layout"];
        [self addOption:@"Staggered layout" selector:@selector(staggeredLayoutSelected) inSection:@"Layout"];
        [self addOption:@"Flow layout" selector:@selector(flowLayoutSelected) inSection:@"Layout"];
        
        [self addOption:@"Horizontal" selector:@selector(horizontalSelected) inSection:@"Orientation"];
        [self addOption:@"Vertical" selector:@selector(verticalSelected) inSection:@"Orientation"];
        
        [self setSelectedOption:1 inSection:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _categories = @[@"breakfast", @"paleo", @"desserts"];
    _dataSource = [[TKDataSource alloc] initWithDataFromJSONResource:@"ListItems" ofType:@"json" rootItemKeyPath:@"items"];
    [_dataSource addFilterDescriptor:[[TKDataSourceFilterDescriptor alloc] initWithQuery:[NSString stringWithFormat:@"category LIKE '%@' OR category LIKE '%@' OR category LIKE '%@'", _categories[0], _categories[1], _categories[2]]]];
    
    _sizes = [[NSMutableArray alloc] initWithCapacity:_dataSource.items.count];
    for (int i = 0; i<_dataSource.items.count; i++) {
        [_sizes addObject:@(50 + 5*(arc4random()%40))];
    }
    
    [_dataSource reloadData];
    [_dataSource groupWithKey:@"category"];

    [_dataSource.settings.listView createCell:^TKListViewCell *(TKListView *listView, NSIndexPath *indexPath, id item) {
        TKListViewCell* cell = [listView dequeueReusableCellWithReuseIdentifier:@"custom" forIndexPath:indexPath];
        return cell;
    }];
    
    [_dataSource.settings.listView initCell:^(TKListView *listView, NSIndexPath *indexPath, TKListViewCell *cell, id item) {
        cell.imageView.image = [UIImage imageNamed:[item objectForKey:@"photo"]];
        cell.textLabel.text = [item objectForKey:@"title"];
        cell.detailTextLabel.text = [item objectForKey:@"author"];
    }];
    
    [_dataSource.settings.listView initHeader:^(TKListView *listView, NSIndexPath *indexPath, TKListViewHeaderCell *headerCell, TKDataSourceGroup *group) {
        headerCell.textLabel.textAlignment = NSTextAlignmentCenter;
        headerCell.textLabel.text = [group.key capitalizedString];
        headerCell.backgroundColor = [UIColor lightGrayColor];
    }];
    
    _listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.dataSource = _dataSource;
    [_listView registerClass:[CustomListCell class] forCellWithReuseIdentifier:@"custom"];
    [self.view addSubview:_listView];

    [self linearLayoutSelected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)linearLayoutSelected
{
    // >> listview-linear
    TKListViewLinearLayout *layout = [TKListViewLinearLayout new];
    layout.itemSize = CGSizeMake(200, 200);
    layout.headerReferenceSize = CGSizeMake(100, 30);
    layout.itemSpacing = 1;
    layout.scrollDirection = _scrollDirection;
   _listView.layout = layout;
    // << listview-linear
}

- (void)gridLayoutSelected
{
    // >> listview-grid
    TKListViewGridLayout *layout = [TKListViewGridLayout new];
    layout.itemSize = CGSizeMake(200, 100);
    layout.headerReferenceSize = CGSizeMake(100, 30);
    layout.spanCount = 2;
    layout.itemSpacing = 1;
    layout.lineSpacing = 1;
    layout.scrollDirection = _scrollDirection;
    _listView.layout = layout;
    // << listview-grid
}

- (void)staggeredLayoutSelected
{
    // >> listview-staggered
    TKListViewStaggeredLayout *layout = [TKListViewStaggeredLayout new];
    layout.delegate = self;
    layout.itemSize = CGSizeMake(200, 100);
    layout.headerReferenceSize = CGSizeMake(100, 30);
    layout.spanCount = 2;
    layout.itemSpacing = 1;
    layout.lineSpacing = 1;
    layout.scrollDirection = _scrollDirection;
    layout.alignLastLine = YES;
    _listView.layout = layout;
    // << listview-staggered
}

- (void)flowLayoutSelected
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((CGRectGetWidth(_listView.bounds)-3)/3.0, CGRectGetHeight(_listView.bounds)/4.0);
    layout.headerReferenceSize = CGSizeMake(100, 30);
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    _listView.layout = layout;
    _scrollDirection = TKListViewScrollDirectionVertical;
    [self setSelectedOption:1 inSection:1];
}

- (void)verticalSelected
{
    _listView.scrollDirection = TKListViewScrollDirectionVertical;
    _scrollDirection = TKListViewScrollDirectionVertical;
}

- (void)horizontalSelected
{
    _listView.scrollDirection = TKListViewScrollDirectionHorizontal;
    _scrollDirection = TKListViewScrollDirectionHorizontal;
}

// >> listview-staggered-size
- (CGSize)listView:(TKListView *)listView layout:(TKListViewLinearLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (layout.scrollDirection == TKListViewScrollDirectionVertical) {
        return CGSizeMake(100, [_sizes[indexPath.row] floatValue]);
    }
    else {
        return CGSizeMake([_sizes[indexPath.row] floatValue], 100);
    }
}
// << listview-staggered-size

@end
