//
//  FeedbackExampleController.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//
#import <TelerikUI/TelerikUI.h>
#import "FeedbackExampleController.h"

@interface FeedbackExampleController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation FeedbackExampleController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showDescription];
    
    TKFeedbackController *feedbackController = (TKFeedbackController*)self.view.window.rootViewController;
    feedbackController.dataSource = [[TKPlatformFeedbackSource alloc] initWithKey:@"58cb0070-f612-11e3-b9fc-55b0b983d3be" uid:@"iosteam@telerik.com"];
}

- (IBAction)sendFeedback:(id)sender
{
    TKFeedbackController *feedbackController = (TKFeedbackController*)self.view.window.rootViewController;
    [feedbackController showFeedback];
}

- (void)showDescription
{
    if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone)
        return;
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (bounds.size.height <= 480) {
        _descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
        return;
    }
    
    _descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
}

@end
