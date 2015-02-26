//
//  SideDrawerPositionsModal.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerPositionsModal.h"
#import "SideDrawerHeaderView.h"

@implementation SideDrawerPositionsModal

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createButtonWithTitle:@"Left" target:self selector:@selector(leftSideDrawer) origin:CGPointMake(15, 80)];
    [self createButtonWithTitle:@"Right" target:self selector:@selector(rightSideDrawer) origin:CGPointMake(15, 130)];
    [self createButtonWithTitle:@"Top" target:self selector:@selector(topSideDrawer) origin:CGPointMake(15, 180)];
    [self createButtonWithTitle:@"Bottom" target:self selector:@selector(bottomSideDrawer) origin:CGPointMake(15, 230)];

    self.sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    self.sideDrawer.transition = TKSideDrawerTransitionTypeReveal;
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
    [((TKSideDrawerTableView *)sideDrawer.content).tableView setContentOffset:CGPointZero animated:NO];
    sideDrawer.allowScroll = YES;
    [self showSideDrawer];
}

- (void)bottomSideDrawer
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.position = TKSideDrawerPositionBottom;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissSideDrawer)];
    [((TKSideDrawerTableView *)sideDrawer.content).tableView setContentOffset:CGPointZero animated:NO];
    sideDrawer.allowScroll = YES;
    [self showSideDrawer];
}

- (void)createButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector origin:(CGPoint)origin
{
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(origin.x, origin.y, titleSize.width * 2, 44)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:[UIColor whiteColor].CGColor];
    [button.layer setCornerRadius:3.f];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
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
