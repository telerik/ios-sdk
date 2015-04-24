//
//  CalendarCustomization.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CalendarCustomization.h"
#import <TelerikUI/TelerikUI.h>
#import "CustomCell.h"

@interface CalendarCustomization () <TKCalendarDelegate>

@property (nonatomic, strong) TKCalendar *calendarView;

@end

@implementation CalendarCustomization

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
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:CGRectZero];
    self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.calendarView.delegate = self;
    [self.view addSubview:self.calendarView];
    
    UIImage *img = [UIImage imageNamed:@"calendar_header"];

    TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)self.calendarView.presenter;
    presenter.style.titleCellHeight = 20;
    presenter.headerView.contentMode = UIViewContentModeScaleToFill;
    presenter.headerView.backgroundColor = [UIColor colorWithPatternImage:img];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat width = fminf(CGRectGetWidth(self.exampleBounds), CGRectGetHeight(self.exampleBounds));
    self.calendarView.frame = CGRectMake(self.exampleBounds.origin.x + (CGRectGetWidth(self.exampleBounds) - width)/2., self.exampleBounds.origin.y, width, width);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TKCalendarDelegate

- (TKCalendarCell *)calendar:(TKCalendar *)calendar viewForCellOfKind:(TKCalendarCellType)cellType
{
    if (cellType == TKCalendarCellTypeDay) {
        return [[CustomCell alloc] init];
    }
    return nil;
}

@end
