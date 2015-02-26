//
//  SideDrawerPositions.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerPositions.h"
#import "SideDrawerPositionsModal.h"

@implementation SideDrawerPositions

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SideDrawerPositionsModal *contentController = [[SideDrawerPositionsModal alloc] init];
    TKSideDrawerController *sideDrawerController = [[TKSideDrawerController alloc] initWithContent: contentController];
    [self.navigationController presentViewController:sideDrawerController animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end
