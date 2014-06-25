//
//  LocalizedCalendar.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "LocalizedCalendar.h"
#import <TelerikUI/TelerikUI.h>

@interface LocalizedCalendar ()

@property (nonatomic, strong) TKCalendar *calendarView;

@end

@implementation LocalizedCalendar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addOption:@"Russian" selector:@selector(selectRussian)];
        [self addOption:@"German" selector:@selector(selectGerman)];
        [self addOption:@"Hebrew" selector:@selector(selectHebrew)];
        [self addOption:@"Chinese" selector:@selector(selectChinese)];
        
        self.selectedOption = 2;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:self.view.bounds];
    self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.calendarView];
    
    [self selectHebrew];
}

- (void)selectRussian
{
    self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    [self.calendarView.presenter update:NO];
}

- (void)selectGerman
{
    self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    [self.calendarView.presenter update:NO];
}

- (void)selectHebrew
{
    self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
    self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"he_IL"];
    [self.calendarView.presenter update:NO];
}

- (void)selectChinese
{
    self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_SG"];
    [self.calendarView.presenter update:NO];
}

@end
