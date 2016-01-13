//
//  CalendarInlineEvents.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "CalendarInlineEvents.h"
#import <TelerikUI/TelerikUI.h>

@interface CalendarInlineEvents () <TKCalendarDataSource, TKCalendarMonthPresenterDelegate>

@property (nonatomic, strong) TKCalendar *calendarView;
@property (nonatomic, strong) NSArray *events;

@end

@implementation CalendarInlineEvents

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createEvents];
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:self.view.bounds];
    self.calendarView.dataSource = self;
    [self.view addSubview:self.calendarView];
    
    TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)self.calendarView.presenter;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        presenter.inlineEventsViewMode = TKCalendarInlineEventsViewModePopover;
    }
    else {
        presenter.inlineEventsViewMode = TKCalendarInlineEventsViewModeInline;
    }
    presenter.inlineEventsView.maxHeight = 140;
    presenter.inlineEventsView.fixedHeight = NO;
    presenter.delegate = self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.calendarView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createEvents
{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *locations = @[ @"Sofia", @"London", @"Paris", @"New York", @"San Francisco", @"Home" ];
    NSArray *colors = @[ TKRGB(88, 86, 214), TKRGB(255, 149, 3), TKRGB(255, 45, 85), TKRGB(76, 217, 100), TKRGB(255, 204, 3)];
    NSArray *titles = @[ @"Meeting with Jack",
                         @"Lunch with Peter",
                         @"Planning meeting",
                         @"Go shopping",
                         @"Very important meeting",
                         @"Another meeting",
                         @"Lorem ipsum"
                         ];
    
    
    TKCalendarEvent *event = [TKCalendarEvent new];
    event.title = @"Two-day event";
    event.startDate = [self dateWithOffset:1 hours:2];
    event.endDate = [self dateWithOffset:2 hours:4];
    event.allDay = YES;
    event.eventColor = colors[arc4random()%(colors.count-1)];
    [array addObject:event];
    
    event = [TKCalendarEvent new];
    event.title = @"Three-day event";
    event.startDate = [self dateWithOffset:2 hours:1];
    event.endDate = [self dateWithOffset:4 hours:2];
    event.allDay = YES;
    event.eventColor = colors[arc4random()%(colors.count-1)];
    [array addObject:event];
    
    for (int i = 0; i<3; i++) {
        event = [TKCalendarEvent new];
        event.title = titles[arc4random()%(titles.count-1)];
        event.startDate = [self dateWithOffset:7 hours:1];
        event.endDate = [self dateWithOffset:7 hours:2];
        event.allDay = YES;
        event.eventColor = colors[arc4random()%(colors.count-1)];
        [array addObject:event];
        
    }
    
    for (int i = 0; i<5; i++) {
        
        int dayOffset = arc4random()%20;
        if (dayOffset < 10) dayOffset *= -1;
        else dayOffset -= 10;
        
        int duration = arc4random()%30;
        
        event = [TKCalendarEvent new];
        event.startDate = [self dateWithOffset:dayOffset hours:0];
        event.endDate = [self dateWithOffset:dayOffset+duration/10 hours:3];
        event.location = locations[arc4random()%(locations.count-1)];
        event.eventColor = colors[arc4random()%(colors.count-1)];
        event.title = titles[arc4random()%(titles.count-1)];
        [array addObject:event];
    }
    
    self.events = array;
}

- (NSDate*)dateWithOffset:(NSInteger)days hours:(NSInteger)hours
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.day = days;
    components.hour = hours;
    return [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
}

#pragma mark - TKCalendarDataSource

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

#pragma mark - TKCalendarMonthPresenterDelegate

- (void)monthPresenter:(TKCalendarMonthPresenter *)presenter inlineEventSelected:(id<TKCalendarEventProtocol>)event
{
    NSLog(@"event selected: %@", event.title);

    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event selected"
                                                        message:event.title
                                                       delegate:nil
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        [alert show];
    });
}

@end
