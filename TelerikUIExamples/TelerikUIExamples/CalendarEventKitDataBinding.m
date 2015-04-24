//
//  CalendarEventKitDataBinding.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CalendarEventKitDataBinding.h"
#import <TelerikUI/TelerikUI.h>

@interface CalendarEventKitDataBinding ()

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
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:self.exampleBounds];
    self.calendarView.dataSource = self.dataSource;
    [self.view addSubview:self.calendarView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.calendarView.frame = self.exampleBounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end