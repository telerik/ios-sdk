//
//  CalendarSelection.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CalendarSelection.h"
#import <TelerikUI/TelerikUI.h>

@interface CalendarSelection () <TKCalendarDelegate>

@property (nonatomic, strong) TKCalendar *calendarView;
@property (nonatomic, strong) NSDate *unselectable;

@end

@implementation CalendarSelection

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self addOption:@"Single date selection" selector:@selector(selectSingleMode)];
        [self addOption:@"Multiple dates selection" selector:@selector(selectMultipleMode)];
        [self addOption:@"Date range selection" selector:@selector(selectRangeMode)];
        
        self.selectedOption = 2;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:self.view.bounds];
    self.calendarView.delegate = self;
    self.calendarView.selectionMode = TKCalendarSelectionModeRange;
    [self.view addSubview:self.calendarView];
    
    NSDateComponents *components = [NSDateComponents new];
    components.day = 1;
    
    NSDate *date = [NSDate date];
    self.unselectable = [self.calendarView.calendar dateByAddingComponents:components toDate:date options:0];
    
    components.day = 3;
    NSDate *startDate = [self.calendarView.calendar dateByAddingComponents:components toDate:date options:0];
    
    components.day = 6;
    NSDate *endDate = [self.calendarView.calendar dateByAddingComponents:components toDate:date options:0];
    
    components.year = -5;
    self.calendarView.minDate = [self.calendarView.calendar dateByAddingComponents:components toDate:date options:0];
    
    components.year = 5;
    self.calendarView.maxDate = [self.calendarView.calendar dateByAddingComponents:components toDate:date options:0];
    
    self.calendarView.selectedDatesRange = [[TKDateRange alloc] initWithStart:startDate end:endDate];
    
    TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)self.calendarView.presenter;
    presenter.headerIsSticky = YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.calendarView.frame = self.view.bounds;
}

- (void)selectSingleMode
{
    self.calendarView.selectionMode = TKCalendarSelectionModeSingle;
}

- (void)selectMultipleMode
{
    self.calendarView.selectionMode = TKCalendarSelectionModeMultiple;
}

- (void)selectRangeMode
{
    self.calendarView.selectionMode = TKCalendarSelectionModeRange;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TKCalendarDelegate

- (void)calendar:(TKCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"selected: %@", date);
}

- (void)calendar:(TKCalendar *)calendar didDeselectedDate:(NSDate *)date
{
    NSLog(@"deselected: %@", date);
}

- (BOOL)calendar:(TKCalendar *)calendar shouldSelectDate:(NSDate *)date
{
    NSLog(@"Trying to select the unselectable: %@", date);
    
    return ![TKCalendar isDate:self.unselectable
                   equalToDate:date
                withComponents:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                  withCalendar:_calendarView.calendar];
}

- (void)calendar:(TKCalendar *)calendar updateVisualsForCell:(TKCalendarCell *)cell
{
    if ([cell isKindOfClass:[TKCalendarMonthTitleCell class]]) {
        TKCalendarMonthTitleCell *monthTitleCell = (TKCalendarMonthTitleCell*)cell;
        monthTitleCell.layoutMode = TKCalendarMonthTitleCellLayoutModeMonthAndYearWithButtons;
    }
}

@end
