//
//  FeedbackExampleController.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//
#import <TelerikUI/TelerikUI.h>
#import <TelerikAppFeedback/AppFeedback.h>
#import "FeedbackExampleController.h"



@interface FeedbackExampleController ()
{
    TKPlatformFeedbackSource *_platformFeedbackSource;
}

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation FeedbackExampleController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //api key used to work with Telerik AppFeedback service
    static NSString *apiKey = @"58cb0070-f612-11e3-b9fc-55b0b983d3be";
    
    //user id used to send feedback to Telerik AppFeedback service
    static NSString *uID = @"iosteam@telerik.com";
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _platformFeedbackSource = [[TKPlatformFeedbackSource alloc] initWithKey:apiKey uid:uID];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showDescription];
    
    TKFeedbackController *feedbackController = (TKFeedbackController*)self.view.window.rootViewController;
    feedbackController.dataSource = _platformFeedbackSource;
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
