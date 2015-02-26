//
//  SideDrawerGettingStarted.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerGettingStarted.h"
#import <TelerikUI/TelerikUI.h>
#import "SideDrawerGettingStartedModal.h"

@implementation SideDrawerGettingStarted

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SideDrawerGettingStartedModal *contentController = [[SideDrawerGettingStartedModal alloc] init];
    TKSideDrawerController *sideDrawerController = [[TKSideDrawerController alloc] initWithContent: contentController];
    [self.navigationController presentViewController:sideDrawerController animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end
