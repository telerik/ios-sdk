//
//  CalendarWithSimpleEvent.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

// >> getting-started-example
#import "CalendarDocsWithSimpleEvent.h"
#import <TelerikUI/TelerikUI.h>

// >> getting-started-datasource
@interface CalendarDocsWithSimpleEvent() <TKCalendarDataSource, TKCalendarDelegate>
// << getting-started-datasource

@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) TKCalendar *calendarView;

@end

@implementation CalendarDocsWithSimpleEvent

- (void)viewDidLoad
{
    [super viewDidLoad];
    
// >> getting-started-calendar
    TKCalendar *calendarView = [[TKCalendar alloc] initWithFrame:self.view.bounds];
    calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:calendarView];
// << getting-started-calendar
    
    calendarView.delegate = self;
    
// >> getting-started-assigndatasource
    calendarView.dataSource = self;
// << getting-started-assigndatasource
    
// >> getting-started-minmaxdate
    calendarView.minDate = [TKCalendar dateWithYear:2010 month:1 day:1 withCalendar:nil];
    calendarView.maxDate = [TKCalendar dateWithYear:2016 month:12 day:31 withCalendar:nil];
// << getting-started-minmaxdate
    
    self.calendarView = calendarView;
    
// >> getting-started-event
    TKCalendarEvent *event = [TKCalendarEvent new];
    NSMutableArray *array = [NSMutableArray new];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    for (int i = 0; i<3; i++) {
        event.title = @"Sample event";
        event.allDay = YES;
        NSDateComponents *components = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
        components.day = arc4random()%50;
        event.startDate = [calendar dateFromComponents:components];
        event.endDate = [calendar dateFromComponents:components];
        event.eventColor = [UIColor redColor];
        
        [array addObject:event];
    }
    
    self.events = array;
// << getting-started-event
    
// >> getting-started-navigatetodate
    NSDateComponents *components = [NSDateComponents new];
    components.year = 2016;
    components.month = 6;
    components.day = 1;
    NSDate *newDate = [self.calendarView.calendar dateFromComponents:components];
// >> navigation-navigate
    [self.calendarView navigateToDate:newDate animated:NO];
// << navigation-navigate
// << getting-started-navigatetodate
    
    [self.calendarView reloadData];
}

#pragma mark TKCalendarDataSource

// >> getting-started-eventsfordate
- (NSArray *)calendar:(TKCalendar *)calendar eventsForDate:(NSDate *)date
{
    NSDateComponents *components = [self.calendarView.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    NSDate *endDate = [self.calendarView.calendar dateFromComponents:components];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(startDate <= %@) AND (endDate >= %@)", endDate, date];
    return [self.events filteredArrayUsingPredicate:predicate];
}
// << getting-started-eventsfordate

#pragma mark TKCalendarDelegate
// >> getting-started-didselectdate
- (void)calendar:(TKCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"%@", date);
}
// << getting-started-didselectdate

@end
// << getting-started-example
