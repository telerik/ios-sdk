//
//  ListViewUpdate.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewUpdate.h"

@interface ListViewUpdate () <TKListViewDelegate>

@property (nonatomic, weak) UIToolbar *toolbar;
@property (nonatomic, weak) TKListView *listView;
@property (nonatomic, strong) TKDataSource *dataSource;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic) NSInteger added;

@end

@implementation ListViewUpdate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.items = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
        [self addItem];
    }
    
    self.dataSource = [[TKDataSource alloc] initWithArray:self.items];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.origin.y, CGRectGetWidth(self.view.frame), 44)];
    toolbar.items = @[
                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                        [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addTouched)],
                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                        [[UIBarButtonItem alloc] initWithTitle:@"Remove" style:UIBarButtonItemStylePlain target:self action:@selector(removeTouched)],
                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                        [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(updateTouched)],
                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                      ];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:toolbar];
    
    TKListView *listView = [[TKListView alloc] initWithFrame:CGRectMake(0, self.view.bounds.origin.y + 44,
                                                                        CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.bounds) - 44)];
    listView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    listView.dataSource = self.dataSource;
    listView.delegate = self;
    [self.view addSubview:listView];
    
    self.toolbar.items[3].enabled = NO;
    self.toolbar.items[5].enabled = NO;

    self.toolbar = toolbar;
    self.listView = listView;
}

- (void)addItem
{
    self.added ++;
    [self.items addObject:[NSString stringWithFormat:@"Item %d", (int)self.added]];
}

- (void)addTouched
{
    [self addItem];
    
    // >> listview-insert-item
    [self.listView insertItemsAtIndexPaths:@[ [NSIndexPath indexPathForItem:self.items.count-1 inSection:0] ]];
    // << listview-insert-item
    [self.listView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.items.count-1 inSection:0]
                                animated:NO
                          scrollPosition:UICollectionViewScrollPositionCenteredVertically];
}

- (void)removeTouched
{
    NSArray *selectedItemsPaths = [self.listView indexPathsForSelectedItems];
    if (selectedItemsPaths.count > 0) {
        NSIndexPath *indexPath = selectedItemsPaths[0];
        [self.items removeObjectAtIndex:indexPath.row];
        
        // >> listview-delete-item
        [self.listView deleteItemsAtIndexPaths:selectedItemsPaths];
        // << listview-delete-item
        
        if (indexPath.row < self.dataSource.items.count) {
            [self.listView selectItemAtIndexPath:indexPath
                                        animated:NO
                                  scrollPosition:UICollectionViewScrollPositionNone];
        }
        else if (self.dataSource.items.count > 0) {
            [self.listView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                                        animated:NO
                                  scrollPosition:UICollectionViewScrollPositionNone];
        }
    }
}

- (void)updateTouched
{
    NSArray *selectedItems = [self.listView indexPathsForSelectedItems];
    if (selectedItems.count > 0) {
        NSIndexPath *indexPath = selectedItems[0];
        self.items[indexPath.row] = @"updated";
        [self.listView reloadItemsAtIndexPaths:selectedItems];
        [self.listView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TKListViewDelegate

- (void)listView:(TKListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.toolbar.items[3].enabled = YES;
    self.toolbar.items[5].enabled = YES;
}

@end
