//
//  SideDrawerCustom.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerCustomContent.h"
#import "SideDrawerHeaderView.h"

@implementation SideDrawerCustomContent

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.sideDrawer.delegate = self;
    self.sideDrawer.content = [self setupSideDrawerContent];
    self.sideDrawer.style.headerHeight = 44;
    self.sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissSideDrawer)];
}

- (UIView *)setupSideDrawerContent
{
    UIView *sideDrawerContent = [UIView new];
    sideDrawerContent.backgroundColor = [UIColor clearColor];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];

    imageView.frame = CGRectMake((self.sideDrawer.width - imageView.frame.size.width) / 2.0,
                                 self.view.frame.size.height / 2 - imageView.frame.size.height,
                                 imageView.frame.size.width,
                                 imageView.frame.size.height);
    
    [sideDrawerContent addSubview:imageView];
    
    return sideDrawerContent;
}

@end
