//
//  SideDrawerCustomContentModal.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerCustomContentModal.h"
#import "SideDrawerHeaderView.h"

@implementation SideDrawerCustomContentModal

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.delegate = self;
    sideDrawer.content = [self setupSideDrawerContent];
    sideDrawer.style.headerHeight = 64;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissSideDrawer)];
}

- (UIView *)setupSideDrawerContent
{
    UIView *sideDrawerContent = [[UIView alloc] init];
    sideDrawerContent.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    imageView.frame = CGRectMake(self.sideDrawer.width / 2 - imageView.frame.size.width / 2, self.view.frame.size.height / 2 - imageView.frame.size.height, imageView.frame.size.width, imageView.frame.size.height);
    [sideDrawerContent addSubview:imageView];
    
    return sideDrawerContent;
}

@end
