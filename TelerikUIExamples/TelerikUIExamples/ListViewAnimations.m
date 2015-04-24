//
//  ListViewAnimations.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewAnimations.h"

@interface ListViewAnimations ()
{
    TKListView *_listView;
    TKDataSource *_dataSource;
}

@end

@implementation ListViewAnimations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Scale in" selector:@selector(scaleInSelected)];
        [self addOption:@"Fade in" selector:@selector(fadeInSelected)];
        [self addOption:@"Slide in" selector:@selector(slideInSelected)];
        [self addOption:@"Fade + Scale in" selector:@selector(fadePlusScaleSelected)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [TKDataSource new];
    [_dataSource loadDataFromJSONResource:@"ListViewSampleData" ofType:@"json" rootItemKeyPath:@"photos"];
    
    [_dataSource.settings.listView initCell:^(TKListView *listView, NSIndexPath *indexPath, TKListViewCell *cell, id item) {
        cell.imageView.image = [UIImage imageNamed:_dataSource.items[indexPath.row]];
        TKView *view = (TKView*)cell.backgroundView;
        view.stroke.width = 0;
        
        cell.imageView.layer.shadowColor = [UIColor colorWithRed:0.27 green:0.27 blue:0.55 alpha:1.0].CGColor;
        cell.imageView.layer.shadowOffset= CGSizeMake(2, 2);
        cell.imageView.layer.shadowOpacity = 0.5;
        cell.imageView.layer.shadowRadius = 3;
    }];
    
    _listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.dataSource = _dataSource;
    _listView.cellAppearBehavior = [[TKListViewCellScaleInBehavior alloc] init];
    _listView.cellAppearBehavior.animateOnce = NO;
    [self.view addSubview:_listView];

    TKListViewColumnsLayout *layout = (TKListViewColumnsLayout*)_listView.layout;
    layout.itemSize = CGSizeMake(130, 180);
    layout.minimumLineSpacing = 10;
    layout.cellAlignment = TKListViewCellAlignmentStretch;
    
    UIButton *insertRemoveButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 36, 36)];
    UIColor *lightBlue = [UIColor colorWithRed:19/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
    [insertRemoveButton setTitleColor:lightBlue forState:UIControlStateNormal];
    [insertRemoveButton setTitle:@"-" forState:UIControlStateNormal];
    insertRemoveButton.titleLabel.font = [UIFont systemFontOfSize:28.00];
    [insertRemoveButton addTarget:self action:@selector(insertRemove:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:insertRemoveButton];
}

- (void)insertRemove:(UIButton *)sender
{
    if([sender.titleLabel.text isEqualToString:@"+"]){
        [self insertCell];
        [sender setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [self removeCell];
        [sender setTitle:@"+" forState:UIControlStateNormal];
    }
}

- (void)insertCell
{
    NSIndexPath *insertionIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    NSMutableArray *newItems = [NSMutableArray arrayWithArray:_dataSource.items];
    [newItems insertObject:@"ALFKIF.JPG" atIndex:0];
    _dataSource.itemSource = newItems;
    [_listView insertItemsAtIndexPaths:@[insertionIndexPath]];
}

- (void)removeCell
{
    NSIndexPath *insertionIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    NSMutableArray *newItems = [NSMutableArray arrayWithArray:_dataSource.items];
    [newItems removeObjectAtIndex:0];
    _dataSource.itemSource = newItems;
    [_listView deleteItemsAtIndexPaths:@[insertionIndexPath]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fadeInSelected
{
    _listView.cellAppearBehavior = [[TKListViewCellFadeInBehavior alloc] init];
    _listView.cellAppearBehavior.animateOnce = NO;
}

- (void)slideInSelected
{
    _listView.cellAppearBehavior = [[TKListViewCellSlideInBehavior alloc] init];
    _listView.cellAppearBehavior.animateOnce = NO;
}

- (void)scaleInSelected
{
    _listView.cellAppearBehavior = [[TKListViewCellScaleInBehavior alloc] init];
    _listView.cellAppearBehavior.animateOnce = NO;
}

- (void)fadePlusScaleSelected
{
    _listView.cellAppearBehavior = [[TKListViewCellFadeInBehavior alloc] init];
    [_listView.cellAppearBehavior addChildBehavior:[[TKListViewCellScaleInBehavior alloc] init]];
}

@end
