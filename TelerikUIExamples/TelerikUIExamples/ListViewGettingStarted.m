//
//  ListViewGettingStarted.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "ListViewGettingStarted.h"
#import <TelerikUI/TelerikUI.h>
#import "ImageWithTextListViewCell.h"

@interface ListViewGettingStarted () <TKListViewDataSource>

@end

@implementation ListViewGettingStarted
{
    TKDataSource *_photos;
    TKDataSource *_names;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // >> datasource-file
    _photos = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"photos"];
    // << datasource-file
    
    _names = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"names"];
    
    TKListView *listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    listView.dataSource = self;
    [self.view addSubview:listView];
    [listView registerClass:[ImageWithTextListViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    TKListViewGridLayout *layout = [TKListViewGridLayout new];
    layout.itemAlignment = TKListViewItemAlignmentCenter;
    layout.spanCount = 2;
    layout.itemSize = CGSizeMake(150, 200);
    layout.lineSpacing = 60;
    layout.itemSpacing = 10;
    listView.layout = layout;
    
    TKView *view = [TKView new];
    
    view.fill = [TKLinearGradientFill linearGradientFillWithColors:@[
                                                                     [UIColor colorWithRed:0.35 green:0.68 blue:0.89 alpha:0.89],
                                                                     [UIColor colorWithRed:0.35 green:0.68 blue:1.00 alpha:1.0],
                                                                     [UIColor colorWithRed:0.85 green:0.8 blue:0.2 alpha:0.8]
                                                                     ]];
    listView.backgroundView = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TKListViewDataSource

- (NSInteger)listView:(TKListView *)listView numberOfItemsInSection:(NSInteger)section
{
    return _names.items.count;
}

- (TKListViewCell*)listView:(TKListView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TKListViewCell *cell = [listView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_photos.items[indexPath.row]];
    cell.textLabel.text = _names.items[indexPath.row];
    return cell;
}

@end
