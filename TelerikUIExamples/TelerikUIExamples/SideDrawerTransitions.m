//
//  SideDrawerTransitions.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerTransitions.h"
#import "SideDrawerTransitionsModal.h"

@implementation SideDrawerTransitions

- (void)viewDidLoad
{
    [super viewDidLoad];

    SideDrawerTransitionsModal *contentController = [[SideDrawerTransitionsModal alloc] init];
    TKSideDrawerController *sideDrawerController = [[TKSideDrawerController alloc] initWithContent: contentController];
    [self.navigationController presentViewController:sideDrawerController animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end
