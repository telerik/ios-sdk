//
//  SideDrawerGettingStarted.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerGettingStarted.h"
#import "SideDrawerHeaderView.h"

@implementation SideDrawerGettingStarted

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.sideDrawerView = [[TKSideDrawerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_sideDrawerView];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.sideDrawerView.mainView.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.image = [UIImage imageNamed:@"sdk-examples-bg"];
    [self.sideDrawerView.mainView addSubview:backgroundView];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.sideDrawerView.mainView.bounds), 44)];
    _navItem = [[UINavigationItem alloc] init];
    _navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(showSideDrawer)];;
    navBar.items = @[_navItem];
    navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.sideDrawerView.mainView addSubview:navBar];
    
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.delegate = self;
    sideDrawer.style.headerHeight = 44;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissSideDrawer)];
    
    TKSideDrawerSection *section = [sideDrawer addSectionWithTitle:@"Primary"];
    [section addItemWithTitle:@"Social"];
    [section addItemWithTitle:@"Promotions"];
    
    section = [sideDrawer addSectionWithTitle:@"Labels"];
    [section addItemWithTitle:@"Important"];
    [section addItemWithTitle:@"Starred"];
    [section addItemWithTitle:@"Sent Mail"];
    [section addItemWithTitle:@"Drafts"];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _sideDrawerView.frame = self.view.bounds;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)showSideDrawer
{
    [self.sideDrawer show];
}

- (void)dismissSideDrawer
{
    [self.sideDrawer dismiss];
}

- (TKSideDrawer *)sideDrawer
{
    return _sideDrawerView.defaultSideDrawer;
}

#pragma mark TKSideDrawerDelegate

- (void)sideDrawer:(TKSideDrawer *)sideDrawer updateVisualsForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TKSideDrawerSection *section = sideDrawer.sections[indexPath.section];
    TKSideDrawerItem *item = section.items[indexPath.item];
    item.style.contentInsets = UIEdgeInsetsMake(0, -5, 0, 0);
}

- (void)sideDrawer:(TKSideDrawer *)sideDrawer updateVisualsForSection:(NSInteger)sectionIndex
{
    TKSideDrawerSection *section = sideDrawer.sections[sectionIndex];
    section.style.contentInsets = UIEdgeInsetsMake(0, -15, 0, 0);
}

@end
