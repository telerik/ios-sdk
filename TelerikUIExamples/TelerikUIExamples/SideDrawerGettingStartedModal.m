//
//  SIdeDrawerGettinStartedModal.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerGettingStartedModal.h"
#import "SideDrawerHeaderView.h"

@implementation SideDrawerGettingStartedModal

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.image = [UIImage imageNamed:@"sdk-examples-bg"];
    [self.view addSubview:backgroundView];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Getting Started"];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    UIBarButtonItem *showSideDrawerButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showSideDrawer)];
    navItem.rightBarButtonItem = doneButton;
    navItem.leftBarButtonItem = showSideDrawerButton;
    navBar.items = @[navItem];
    [self.view addSubview:navBar];
    
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.delegate = self;
    sideDrawer.style.headerHeight = 64;
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

- (void)showSideDrawer
{
    [self.sideDrawer show];
}

- (void)dismissSideDrawer
{
    [self.sideDrawer dismiss];
}

- (void)dismiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark TKSideDrawerDelegate

- (void)sideDrawer:(TKSideDrawer *)sideDrawer updateVisualsForItem:(NSInteger)itemIndex inSection:(NSInteger)sectionIndex
{
    TKSideDrawerSection *section = sideDrawer.sections[sectionIndex];
    TKSideDrawerItem *item = section.items[itemIndex];
    item.style.contentInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    item.style.separatorColor = [TKSolidFill solidFillWithColor:[UIColor clearColor]];
}

- (void)sideDrawer:(TKSideDrawer *)sideDrawer updateVisualsForSection:(NSInteger)sectionIndex
{
    TKSideDrawerSection *section = sideDrawer.sections[sectionIndex];
    section.style.contentInsets = UIEdgeInsetsMake(0, -15, 0, 0);
}

@end
