//
//  iOS7StyleCalendar.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "iOS7StyleCalendar.h"
#import <TelerikUI/TelerikUI.h>

@interface iOS7StyleCalendar ()

@end

@implementation iOS7StyleCalendar

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
    // Do any additional setup after loading the view.

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Tap to load iOS 7 style calendar" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, self.view.bounds.size.height/2. - 20, self.view.bounds.size.width, 40);
    button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|
                              UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:button];
}

- (void)buttonTouched:(id)sender
{
    self.title = @"Back";
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendar.firstWeekday = 2;
        
    TKCalendarYearViewController *controller = [TKCalendarYearViewController new];
    controller.contentView.minDate = [TKCalendar dateWithYear:2012 month:1 day:1 withCalendar:calendar];
    controller.contentView.maxDate = [TKCalendar dateWithYear:2018 month:1 day:1 withCalendar:calendar];
    [controller.contentView navigateToDate:[NSDate date] animated:NO];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.title = @"iOS 7 style calendar";
    self.navigationController.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
