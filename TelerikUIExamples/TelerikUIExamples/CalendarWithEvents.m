//
//  CalendarWithEvents.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CalendarWithEvents.h"
#import <TelerikUI/TelerikUI.h>

static NSString* const cellID = @"cell";

@interface CalendarWithEvents () <TKCalendarDataSource, TKCalendarDelegate, UITableViewDataSource>

@property (nonatomic, strong) TKCalendar *calendarView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) NSArray *eventsForDate;

@end

@implementation CalendarWithEvents

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self createEvents];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.firstWeekday = 2;
    
    NSDateComponents *components = [NSDateComponents new];
    components.year = -10;
    NSDate *minDate = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    components.year = 10;
    NSDate *maxDate = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:CGRectZero];
    self.calendarView.calendar = calendar;
    self.calendarView.dataSource = self;
    self.calendarView.delegate = self;
    self.calendarView.minDate = minDate;
    self.calendarView.maxDate = maxDate;
    self.calendarView.allowPinchZoom = YES;
    
    TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)self.calendarView.presenter;
    presenter.style.titleCellHeight = 40;
    presenter.headerIsSticky = YES;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        presenter.weekNumbersHidden = YES;
        self.calendarView.theme = [TKCalendarIPadTheme new];
        [self.calendarView.presenter update:YES];
    }
    else {
        presenter.weekNumbersHidden = NO;
    }
    
    [self.view addSubview:self.calendarView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if ([self.calendarView.theme isKindOfClass:[TKCalendarIPadTheme class]] || UIDeviceOrientationIsLandscape(orientation)) {
        self.tableView.frame = CGRectZero;
        self.calendarView.frame = self.exampleBounds;
    }
    else {
        CGFloat height =  CGRectGetHeight(self.exampleBounds);
        CGFloat tableHeight = height/3.2;
        self.calendarView.frame = CGRectMake(0, self.exampleBounds.origin.y, self.exampleBounds.size.width, height - tableHeight);
        self.tableView.frame = CGRectMake(0, self.exampleBounds.origin.y + self.exampleBounds.size.height - tableHeight, self.exampleBounds.size.width, tableHeight);
    }
}

- (void)didReceiveMemoryWarning
{
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

#pragma mark TKCalendarDataSource

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

#pragma mark TKCalendarDelegate

- (void)calendar:(TKCalendar *)calendar didSelectDate:(NSDate *)date
{
    self.eventsForDate = [self.calendarView eventsForDate:date];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventsForDate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    TKCalendarEvent *event = self.eventsForDate[indexPath.row];
    cell.textLabel.text = event.title;
    return cell;
}

@end