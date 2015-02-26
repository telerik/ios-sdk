//
//  SideDrawerCustomContent.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerCustomContent.h"
#import "SideDrawerCustomContentModal.h"

@implementation SideDrawerCustomContent

- (void)viewDidLoad
{
    [super viewDidLoad];

    SideDrawerCustomContentModal *contentController = [[SideDrawerCustomContentModal alloc] init];
    TKSideDrawerController *sideDrawerController = [[TKSideDrawerController alloc] initWithContent: contentController];
    [self.navigationController presentViewController:sideDrawerController animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end
