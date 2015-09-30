//
//  AlertViewAnimations.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "UIButton_Circle.h"
#import "AlertViewGettingStarted.h"
#import "AlertViewAnimations.h"

@interface AlertViewAnimations () <TKListViewDelegate>
@end

@implementation AlertViewAnimations
{
    UILabel *_appearLabel;
    UILabel *_dismissLabel;
    TKDataSource *_appearAnimations;
    TKDataSource *_hideAnimations;
    TKListView *_appearAnimationsList;
    TKListView *_hideAnimationsList;
    TKAlert *_alert;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Show Alert" selector:@selector(show)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _alert = [TKAlert new];
    _alert.title = @"Animations";
    _alert.style.backgroundStyle = TKAlertBackgroundStyleBlur;
    
    [_alert addActionWithTitle:@"Close" handler:^BOOL(TKAlert *alert, TKAlertAction *action) {
        return YES;
    }];

    _appearAnimations = [[TKDataSource alloc] initWithArray:@[@"Scale in", @"Fade in", @"Slide from left", @"Slide from top", @"Slide from right", @"Slide from bottom"]];
    _hideAnimations = [[TKDataSource alloc] initWithArray:@[@"Scale out", @"Fade out", @"Slide to left", @"Slide to top", @"Slide to right", @"Slide to bottom"]];
    
    TKDataSourceListViewSettings_InitCellWithItemBlock block = ^(TKListView *listView, NSIndexPath *indexPath, TKListViewCell *cell, id item) {
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = item;
    };
    
    [_appearAnimations.settings.listView initCell:block];
    [_hideAnimations.settings.listView initCell:block];
    
    [self.view addSubview:[TKListView new]];
    
    _appearAnimationsList = [[TKListView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height)];
    _appearAnimationsList.dataSource = _appearAnimations;
    _appearAnimationsList.delegate = self;
    _appearAnimationsList.tag = 0;
    _appearAnimationsList.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:_appearAnimationsList];
    
    [_appearAnimationsList selectItemAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];

    _hideAnimationsList = [[TKListView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2., 0, self.view.frame.size.width/2., self.view.frame.size.height)];
    _hideAnimationsList.dataSource = _hideAnimations;
    _hideAnimationsList.delegate = self;
    _hideAnimationsList.tag = 1;
    _hideAnimationsList.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:_hideAnimationsList];
    
    [_hideAnimationsList selectItemAtIndexPath:[NSIndexPath indexPathForItem:5 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
    _appearLabel = [UILabel new];
    _appearLabel.text = @"Show animation:";
    _appearLabel.textColor = [UIColor blackColor];
    _appearLabel.font = [UIFont systemFontOfSize:12];
    _appearLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_appearLabel];
    
    _dismissLabel = [UILabel new];
    _dismissLabel.text = @"Dismiss animation:";
    _dismissLabel.textColor = [UIColor blackColor];
    _dismissLabel.font = [UIFont systemFontOfSize:12];
    _dismissLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_dismissLabel];
}

- (void)viewDidLayoutSubviews
{
    CGFloat titleHeight = 60;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        titleHeight = 50;
    }
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        titleHeight += 40;
    }
    
    CGFloat halfWidth = CGRectGetWidth(self.view.frame)/2;
    _appearLabel.frame = CGRectMake(0, titleHeight + 10, halfWidth, 20);
    _dismissLabel.frame = CGRectMake(halfWidth, titleHeight + 10, halfWidth, 20);
    
    CGFloat height = CGRectGetHeight(self.view.frame) - titleHeight - 50;
    
    _appearAnimationsList.frame = CGRectMake(0, titleHeight + 40, halfWidth, height);
    _hideAnimationsList.frame = CGRectMake(halfWidth, titleHeight + 40, halfWidth, height);
}

- (void)show
{
    NSMutableString *message = [NSMutableString new];
    
    NSArray *selected = [_appearAnimationsList indexPathsForSelectedItems];
    if (selected.count > 0) {
        NSIndexPath *indexPath = selected[0];
        [message appendString:[NSString stringWithFormat:@"Alert did %@.\n", [(NSString*)_appearAnimations.items[indexPath.row] lowercaseString]]];
    }

    selected = [_hideAnimationsList indexPathsForSelectedItems];
    if (selected.count > 0) {
        NSIndexPath *indexPath = selected[0];
        [message appendString:[NSString stringWithFormat:@"It will %@ when closed.", [(NSString*)_hideAnimations.items[indexPath.row] lowercaseString]]];
    }
    
    _alert.message = message;
    
    [_alert show:YES];
}

#pragma mark - TKListViewDelegate

- (void)listView:(TKListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (listView.tag == 0) {
        _alert.style.showAnimation = indexPath.row;
    }
    else {
        _alert.style.dismissAnimation = indexPath.row;
    }
}

@end
