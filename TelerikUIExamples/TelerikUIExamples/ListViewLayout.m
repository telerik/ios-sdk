//
//  ListViewWrapLayout.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewLayout.h"
#import "SimpleListViewCell.h"

@interface ListViewLayout ()

@end

@implementation ListViewLayout
{
    TKDataSource *_photos;
    TKDataSource *_names;
    TKListView *_listView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Wrap layout" selector:@selector(wrapLayoutSelected) inSection:@"Layout"];
        [self addOption:@"Columns layout" selector:@selector(columnLayoutSelected) inSection:@"Layout"];
        
        [self addOption:@"Horizontal" selector:@selector(horizontalSelected) inSection:@"Orientation"];
        [self addOption:@"Vertical" selector:@selector(verticalSelected) inSection:@"Orientation"];
        [self setSelectedOption:1 inSection:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _photos = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"photos"];
    _names = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"names"];
    
    [_photos.settings.listView createCell:^TKListViewCell *(TKListView *listView, NSIndexPath *indexPath, id item) {
        return [listView dequeueReusableCellWithReuseIdentifier:@"simpleCell" forIndexPath:indexPath];
    }];
    
    [_photos.settings.listView initCell:^(TKListView *listView, NSIndexPath *indexPath, TKListViewCell *cell, id item) {
        cell.imageView.image = [UIImage imageNamed:_photos.items[indexPath.row]];
        cell.textLabel.text = _names.items[indexPath.row];
        TKView *view = (TKView*)cell.backgroundView;
        view.stroke.strokeSides = [listView.layout isKindOfClass:[TKListViewColumnsLayout class]] ?
                                    TKRectSideRight | TKRectSideBottom : TKRectSideAll;
        [view setNeedsDisplay];
    }];
    
    _listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.dataSource = _photos;
    [_listView registerClass:[SimpleListViewCell class] forCellWithReuseIdentifier:@"simpleCell"];
    [self.view addSubview:_listView];

    [self wrapLayoutSelected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wrapLayoutSelected
{
    _listView.insets = UIEdgeInsetsMake(4, 4, 0, 4);
    TKListViewWrapLayout *layout = [TKListViewWrapLayout new];
    layout.minimumLineSpacing = 4;
    layout.minimumInteritemSpacing = 4;
    layout.itemSize = CGSizeMake(100, 100);
    _listView.layout = layout;
    [_listView reloadData];
}

- (void)columnLayoutSelected
{
    _listView.insets = UIEdgeInsetsZero;
    TKListViewColumnsLayout *layout = [TKListViewColumnsLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(100, 100);
    layout.columnsCount = 2;
    layout.cellAlignment = TKListViewCellAlignmentStretch;
    _listView.layout = layout;
    [_listView reloadData];
    
    _listView.scrollDirection = TKListViewScrollDirectionVertical;
    [self setSelectedOption:1 inSection:1];
}

- (void)verticalSelected
{
    _listView.scrollDirection = TKListViewScrollDirectionVertical;
    [_listView.layout prepareLayout];
}

- (void)horizontalSelected
{
    if ([_listView.layout isKindOfClass:[TKListViewColumnsLayout class]]) {
        [self setSelectedOption:1 inSection:1];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TKListView"
                                                        message:@"Columns layout supports only vertical scroll direction."
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    //Plese note that columns layout would not be affected by setting horizontal direction as it supports only vertical scroll direction.
    _listView.scrollDirection = TKListViewScrollDirectionHorizontal;
    [_listView.layout prepareLayout];
}

@end
