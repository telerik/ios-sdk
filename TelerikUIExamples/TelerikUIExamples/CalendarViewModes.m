//
//  CalendarViewModes.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CalendarViewModes.h"
#import <TelerikUI/TelerikUI.h>

@interface CalendarViewModes () <TKCalendarDelegate>

@property (nonatomic, strong) TKCalendar *calendarView;

@end

@implementation CalendarViewModes

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self addOption:@"Week view" selector:@selector(selectWeekView)];
        [self addOption:@"Month" selector:@selector(selectMonth)];
        [self addOption:@"Month Names" selector:@selector(selectMonthNames)];
        [self addOption:@"Year" selector:@selector(selectYear)];
        [self addOption:@"Year Numbers" selector:@selector(selectYearNumbers)];
        [self addOption:@"Flow" selector:@selector(selectFlow)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.firstWeekday = 2;
    NSDate *date = [NSDate date];
    NSDateComponents *components = [NSDateComponents new];
    components.year = -10;
    NSDate *minDate = [calendar dateByAddingComponents:components toDate:date options:0];
    components.year = 10;
    NSDate *maxDate = [calendar dateByAddingComponents:components toDate:date options:0];
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.calendarView];

    self.calendarView.delegate = self;
    [self selectYear];
    self.calendarView.calendar = calendar;
    self.calendarView.minDate = minDate;
    self.calendarView.maxDate = maxDate;
// >> view-modes-pinchzoom
    self.calendarView.allowPinchZoom = NO;
// << view-modes-pinchzoom    
    
    [self.calendarView navigateToDate:date animated:NO];
    
// >> view-modes-presenter
    TKCalendarYearPresenter *presenter = (TKCalendarYearPresenter*)self.calendarView.presenter;
    presenter.columns = 3;
// << view-modes-presenter
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.calendarView.viewMode == TKCalendarViewModeWeek) {
        self.calendarView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, CGRectGetWidth(self.view.bounds), 100);
    }
    else {
        self.calendarView.frame = self.view.bounds;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectYear
{
// >> getting-started-viewmodeyear
    self.calendarView.viewMode = TKCalendarViewModeYear;
// << getting-started-viewmodeyear    
}

- (void)selectMonth
{
// >> view-modes-month
    self.calendarView.viewMode = TKCalendarViewModeMonth;
// << view-modes-month
}

- (void)selectMonthNames
{
// >> view-modes-monthnames
    self.calendarView.viewMode = TKCalendarViewModeMonthNames;
// << view-modes-monthnames    
}

- (void)selectYearNumbers
{
// >> view-modes-yearnumber
    self.calendarView.viewMode = TKCalendarViewModeYearNumbers;
// << view-modes-yearnumber    
}

- (void)selectFlow
{
// >> view-modes-flow
    self.calendarView.viewMode = TKCalendarViewModeFlow;
// << view-modes-flow    
}

- (void)selectWeekView
{
// >> view-modes-week
    self.calendarView.viewMode = TKCalendarViewModeWeek;
// << view-modes-week
}

#pragma mark TKCalendarDelegate

// >> view-modes-changeviewmode
- (void)calendar:(TKCalendar *)calendar didChangedViewModeFrom:(TKCalendarViewMode)previousViewMode to:(TKCalendarViewMode)viewMode
{
    if (viewMode == TKCalendarViewModeWeek || previousViewMode == TKCalendarViewModeWeek) {
        [self.view setNeedsLayout];
    }
    
    self.selectedOption = (int)viewMode;
}
// << view-modes-changeviewmode



@end
