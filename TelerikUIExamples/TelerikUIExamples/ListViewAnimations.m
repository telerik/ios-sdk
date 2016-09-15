//
//  ListViewAnimations.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewAnimations.h"
#import "AnimationListCell.h"

@interface ListViewAnimations ()
{
    TKListView *_listView;
    TKDataSource *_dataSource;
    NSMutableArray *_images;
}

@end

@implementation ListViewAnimations

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Scale in" selector:@selector(scaleInSelected)];
        [self addOption:@"Fade in" selector:@selector(fadeInSelected)];
        [self addOption:@"Slide in" selector:@selector(slideInSelected)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [TKDataSource new];
    [_dataSource loadDataFromJSONResource:@"ListViewSampleData" ofType:@"json" rootItemKeyPath:@"photos"];
    
    _images = [NSMutableArray new];
    for (int i = 0; i<_dataSource.items.count; i++) {
        [_images addObject:[UIImage imageNamed:_dataSource.items[i]]];
    }
    
    [_dataSource.settings.listView createCell:^TKListViewCell *(TKListView *listView, NSIndexPath *indexPath, id item) {
        return [listView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    }];
    
    [_dataSource.settings.listView initCell:^(TKListView *listView, NSIndexPath *indexPath, TKListViewCell *cell, id item) {
        cell.imageView.image = _images[indexPath.row];
    }];
    
    _listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.dataSource = _dataSource;
    [_listView registerClass:[AnimationListCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_listView];

    TKListViewGridLayout *layout = [TKListViewGridLayout new];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        layout.spanCount = 3;
    }
    else {
        layout.spanCount = 2;
    }
    layout.itemSize = CGSizeMake(130, 180);
    layout.itemSpacing = 10;
    layout.lineSpacing = 10;
    
    // >> listview-alignment
    layout.itemAlignment = TKListViewItemAlignmentCenter;
    // << listview-alignment
    
    layout.itemAppearAnimation = TKListViewItemAnimationScale;
    
    // >> listview-animation-duration
    layout.animationDuration = 0.4;
    // << listview-animation-duration
    
    _listView.layout = layout;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fadeInSelected
{
    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)_listView.layout;
    layout.itemAppearAnimation = TKListViewItemAnimationFade;
    layout.itemInsertAnimation = TKListViewItemAnimationFade;
    layout.itemInsertAnimation = TKListViewItemAnimationFade;
}

- (void)slideInSelected
{
    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)_listView.layout;
    layout.itemAppearAnimation = TKListViewItemAnimationSlide;
    layout.itemInsertAnimation = TKListViewItemAnimationSlide;
    layout.itemDeleteAnimation = TKListViewItemAnimationSlide;
}

- (void)scaleInSelected
{
    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)_listView.layout;
    // >> listview-appear
    layout.itemAppearAnimation = TKListViewItemAnimationScale;
    // << listview-appear
    
    // >> listview-insert
    layout.itemInsertAnimation = TKListViewItemAnimationScale;
    // << listview-insert
    
    // >> listview-delete
    layout.itemDeleteAnimation = TKListViewItemAnimationScale;
    // << listview-delete
    
}

@end
