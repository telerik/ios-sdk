//
//  CalendarEventKitDataBinding.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CalendarEventKitDataBinding.h"
#import <TelerikUI/TelerikUI.h>

@interface CalendarEventKitDataBinding () <TKCalendarEventKitDataSourceDelegate>

@property (nonatomic, strong) TKCalendar *calendarView;
@property (nonatomic, strong) TKCalendarEventKitDataSource *dataSource;
@end

@implementation CalendarEventKitDataBinding

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
    
    self.dataSource = [TKCalendarEventKitDataSource new];
    self.dataSource.delegate = self;
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:self.view.bounds];
    self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.calendarView.dataSource = self.dataSource;
    [self.view addSubview:self.calendarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TKCalendarEventKitDataSource

//- (BOOL)shouldImportEventsFromCalendar:(EKCalendar *)calendar
//{
//    if (calendar.type == EKCalendarTypeLocal)
//        return YES;
//    return NO;
//}

@end