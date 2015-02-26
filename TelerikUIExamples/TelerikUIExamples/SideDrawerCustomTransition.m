//
//  SideDrawerCustomTransition.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerCustomTransition.h"
#import "SideDrawerCustomTransitionModal.h"

@implementation SideDrawerCustomTransition

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SideDrawerCustomTransitionModal *contentController = [[SideDrawerCustomTransitionModal alloc] init];
    TKSideDrawerController *sideDrawerController = [[TKSideDrawerController alloc] initWithContent: contentController];
    sideDrawerController.view.backgroundColor = [UIColor grayColor];
    [self.navigationController presentViewController:sideDrawerController animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end
