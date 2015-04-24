//
//  SideDrawerPositions.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerPositions.h"
#import "SideDrawerHeaderView.h"

@implementation SideDrawerPositions
{
    UIScrollView *_scrollView;
    CGFloat _buttonY;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.scrollEnabled = YES;
    
    [self.sideDrawerView.mainView addSubview:_scrollView];
    
    [self addButtonWithTitle:@"Left" target:self selector:@selector(leftSideDrawer)];
    [self addButtonWithTitle:@"Right" target:self selector:@selector(rightSideDrawer)];
    [self addButtonWithTitle:@"Top" target:self selector:@selector(topSideDrawer)];
    [self addButtonWithTitle:@"Bottom" target:self selector:@selector(bottomSideDrawer)];
    
    self.sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    self.sideDrawer.transition = TKSideDrawerTransitionTypeReveal;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _scrollView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44);
}

- (void)leftSideDrawer
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.position = TKSideDrawerPositionLeft;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:nil selector:nil];
    [self showSideDrawer];
}

- (void)rightSideDrawer
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.position = TKSideDrawerPositionRight;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissSideDrawer)];
    [self showSideDrawer];
}

- (void)topSideDrawer
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.position = TKSideDrawerPositionTop;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:nil selector:nil];
    [((TKSideDrawerTableView *)sideDrawer.content) setContentOffset:CGPointZero animated:NO];
    sideDrawer.allowScroll = YES;
    [self showSideDrawer];
}

- (void)bottomSideDrawer
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.position = TKSideDrawerPositionBottom;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissSideDrawer)];
    [((TKSideDrawerTableView *)sideDrawer.content) setContentOffset:CGPointZero animated:NO];
    sideDrawer.allowScroll = YES;
    [self showSideDrawer];
}

- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    CGSize titleSize = [title sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18] }];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 15 + _buttonY, titleSize.width * 2, 44)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:[UIColor whiteColor].CGColor];
    [button.layer setCornerRadius:3.f];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
    _buttonY += 50;
    _scrollView.contentSize = CGSizeMake(fmax(CGRectGetWidth(button.frame), _scrollView.contentSize.width), _buttonY + 15);
}

#pragma mark TKSideDrawerDelegate

- (void)sideDrawer:(TKSideDrawer *)sideDrawer updateVisualsForSection:(NSInteger)sectionIndex
{
    TKSideDrawerSection *section = sideDrawer.sections[sectionIndex];
    section.style.contentInsets = UIEdgeInsetsMake(0, -15, 0, 0);
}

- (void)sideDrawer:(TKSideDrawer *)sideDrawer updateVisualsForItem:(NSInteger)item inSection:(NSInteger)section
{
    TKSideDrawerItem *currentItem = ((TKSideDrawerSection *)sideDrawer.sections[section]).items[item];
    currentItem.style.contentInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    currentItem.style.separatorColor = [TKSolidFill solidFillWithColor:[UIColor clearColor]];
}

@end
