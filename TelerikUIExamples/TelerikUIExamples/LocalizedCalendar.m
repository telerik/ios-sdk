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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addOption:@"Russian" selector:@selector(selectRussian)];
        [self addOption:@"German" selector:@selector(selectGerman)];
        [self addOption:@"Hebrew" selector:@selector(selectHebrew)];
        [self addOption:@"Chinese" selector:@selector(selectChinese)];
        [self addOption:@"Islamic"  selector:@selector(selectIslamic)];
        
        self.selectedOption = 2;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.calendarView];
    
    [self selectHebrew];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.calendarView.frame = self.view.bounds;
}

- (void)selectRussian
{
    self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
// >> localization-localeproperty
    self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
// << localization-localeproperty    
    [self.calendarView.presenter update:NO];
}

- (void)selectGerman
{
    self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    [self.calendarView.presenter update:NO];
}

- (void)selectHebrew
{
    self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierHebrew];
    self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"he_IL"];
    [self.calendarView.presenter update:NO];
}

- (void)selectChinese
{
// >> localization-chinesecalendar
    self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
// << localization-chinesecalendar
    self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_SG"];
    [self.calendarView.presenter update:NO];
}

- (void)selectIslamic
{
    self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamic];
    self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar-QA"];
// >> localization-update
    [self.calendarView.presenter update:NO];
// << localization-update
}

@end
