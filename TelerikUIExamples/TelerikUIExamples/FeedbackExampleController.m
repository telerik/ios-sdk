//
//  FeedbackExampleController.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import <TelerikAppFeedback/TelerikAppFeedback.h>
#import "FeedbackExampleController.h"

@implementation FeedbackExampleController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        if (bounds.size.height <= 480) {
            self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
        }
        else {
            self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        }
    }

    [TKFeedback setDataSource:[[TKPlatformFeedbackSource alloc] initWithKey:@"58cb0070-f612-11e3-b9fc-55b0b983d3be" uid: @"iosteam@telerik.com"]];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [TKFeedback showFeedback];
}

- (IBAction)sendFeedback:(id)sender
{
    [TKFeedback showFeedback];
}

@end
