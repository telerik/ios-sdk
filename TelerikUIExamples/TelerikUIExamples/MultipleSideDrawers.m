//
//  MultipleSideDrawers.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "MultipleSideDrawers.h"
#import <TelerikUI/TelerikUI.h>
#import "SideDrawerHeaderView.h"

@interface MultipleSideDrawers () <TKSideDrawerDelegate>

@end

@implementation MultipleSideDrawers
{
    TKSideDrawerView *sideDrawerView;
    UINavigationItem *navItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sideDrawerView = [[TKSideDrawerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:sideDrawerView];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:sideDrawerView.mainView.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.image = [UIImage imageNamed:@"sdk-examples-bg"];
    [sideDrawerView.mainView addSubview:backgroundView];
    
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(sideDrawerView.mainView.bounds), 44)];
    
    navItem = [[UINavigationItem alloc] init];
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(showLeftSideDrawer)];
    
    navItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(showRightSideDrawer)];
    
    
    navigationBar.items = @[navItem];
    navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [sideDrawerView.mainView addSubview:navigationBar];
    
    TKSideDrawer *sideDrawerRight = [sideDrawerView addSideDrawerAtPosition:TKSideDrawerPositionRight];
    sideDrawerRight.delegate = self;
    sideDrawerRight.style.headerHeight = 44;
    sideDrawerRight.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissRightSideDrawer)];
    
    TKSideDrawerSection *sectionRight = [sideDrawerRight addSectionWithTitle:@"Primary"];
    [sectionRight addItemWithTitle:@"Social"];
    [sectionRight addItemWithTitle:@"Promotions"];
    
    sectionRight = [sideDrawerRight addSectionWithTitle:@"Labels"];
    [sectionRight addItemWithTitle:@"Important"];
    [sectionRight addItemWithTitle:@"Starred"];
    [sectionRight addItemWithTitle:@"Sent Mail"];
    [sectionRight addItemWithTitle:@"Drafts"];
    
    TKSideDrawer *sideDrawerLeft = sideDrawerView.sideDrawers[0];
    sideDrawerLeft.delegate = self;
    sideDrawerLeft.style.headerHeight = 44;
    sideDrawerLeft.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissLeftSideDrawer)];
    
    TKSideDrawerSection *sectionLeft = [sideDrawerLeft addSectionWithTitle:@"Inbox"];
    [sectionLeft addItemWithTitle:@"Sent Items"];
    [sectionLeft addItemWithTitle:@"Deleted Items"];
    [sectionLeft addItemWithTitle:@"Outbox"];
    
    sectionLeft = [sideDrawerLeft addSectionWithTitle:@"Mobile"];
    [sectionLeft addItemWithTitle:@"iOS"];
    [sectionLeft addItemWithTitle:@"Android"];
    [sectionLeft addItemWithTitle:@"Windows Phone"];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    sideDrawerView.frame = self.view.bounds;
}

-(void)showLeftSideDrawer
{
    [sideDrawerView.sideDrawers[0] show];
}

- (void)showRightSideDrawer
{
    [sideDrawerView.sideDrawers[1] show];
}

-(void)dismissLeftSideDrawer
{
    [sideDrawerView.sideDrawers[0] dismiss];
}

-(void)dismissRightSideDrawer
{
    [sideDrawerView.sideDrawers[1] dismiss];
}


@end
