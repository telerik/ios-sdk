//
//  SideDrawerCustomTransition.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerCustomTransition.h"
#import "SideDrawerHeaderView.h"
#import "MyTransition.h"

@implementation SideDrawerCustomTransition

- (void)viewDidLoad
{
    [super viewDidLoad];
    TKSideDrawer *sideDrawer = self.sideDrawer;
    self.sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:nil selector:nil];
    self.sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    self.sideDrawer.width = 200;
    self.sideDrawer.transitionManager = [[MyTransition alloc] initWithSideDrawer:sideDrawer];
}

- (UIView *)sideDrawerHeader
{
    TKSideDrawerHeader *sideDrawerHeader = [[TKSideDrawerHeader alloc] initWithTitle:@"Navigation Menu" button:nil image:nil];
    sideDrawerHeader.buttonPosition = TKSideDrawerHeaderButtonPositionLeft;
    sideDrawerHeader.contentInsets = UIEdgeInsetsMake(-15, -20, 0, 0);
    return sideDrawerHeader;
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
    currentItem.style.contentInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    currentItem.style.separatorColor = [TKSolidFill solidFillWithColor:[UIColor clearColor]];
}

@end
