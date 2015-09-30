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
    self.calendarView.viewMode = TKCalendarViewModeYear;
    self.calendarView.calendar = calendar;
    self.calendarView.minDate = minDate;
    self.calendarView.maxDate = maxDate;
    self.calendarView.allowPinchZoom = NO;
    
    [self.calendarView navigateToDate:date animated:NO];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.calendarView.viewMode == TKCalendarViewModeWeek) {
        self.calendarView.frame = CGRectMake(self.exampleBounds.origin.x, self.exampleBounds.origin.y, CGRectGetWidth(self.exampleBounds), 100);
    }
    else {
        self.calendarView.frame = self.exampleBounds;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectYear
{
    self.calendarView.viewMode = TKCalendarViewModeYear;
}

- (void)selectMonth
{
    self.calendarView.viewMode = TKCalendarViewModeMonth;
}

- (void)selectMonthNames
{
    self.calendarView.viewMode = TKCalendarViewModeMonthNames;
}

- (void)selectYearNumbers
{
    self.calendarView.viewMode = TKCalendarViewModeYearNumbers;
}

- (void)selectFlow
{
    self.calendarView.viewMode = TKCalendarViewModeFlow;
}

- (void)selectWeekView
{
    self.calendarView.viewMode = TKCalendarViewModeWeek;
}

#pragma mark TKCalendarDelegate

- (TKCalendarCell *)calendar:(TKCalendar *)calendar viewForCellOfKind:(TKCalendarCellType)cellType
{
    return nil;
}

- (void)calendar:(TKCalendar *)calendar didChangedViewModeFrom:(TKCalendarViewMode)previousViewMode to:(TKCalendarViewMode)viewMode
{
    if (viewMode == TKCalendarViewModeWeek || previousViewMode == TKCalendarViewModeWeek) {
        [self.view setNeedsLayout];
    }
    
    self.selectedOption = (int)viewMode;
}

@end
