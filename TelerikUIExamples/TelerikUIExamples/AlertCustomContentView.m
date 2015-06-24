//
//  AlertCustomContentView.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "AlertCustomContentView.h"

@interface AlertCustomContentView() <TKCalendarDelegate>

@end

@implementation AlertCustomContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        UIColor *color = [UIColor colorWithRed:0.5 green:0.7 blue:0.2 alpha:1];
        
        self.calendarView = [[TKCalendar alloc] initWithFrame:CGRectMake(width/2 - 0.5, 0, width/2 + 0.5, height)];
        self.calendarView.delegate = self;
        [self addSubview:self.calendarView];

        self.calendarView.tintColor = [UIColor whiteColor];
        
        TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)self.calendarView.presenter;
        presenter.style.backgroundColor = color;
        presenter.headerIsSticky = YES;
        
        self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width/2., height)];
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel.textColor = color;
        self.dayLabel.font = [UIFont systemFontOfSize:60];
        self.dayLabel.text = @"20";
        [self addSubview:self.dayLabel];
        
        self.calendarView.selectedDate = [NSDate date];
    }
    return self;
}

#pragma mark - TKCalendarDelegate

- (void)calendar:(TKCalendar *)calendar updateVisualsForCell:(TKCalendarCell *)cell
{
    cell.style.textColor = [UIColor whiteColor];
    cell.style.bottomBorderWidth = 0;
    cell.style.topBorderWidth = 0;
    cell.style.textFont = [UIFont systemFontOfSize:10];
    cell.style.shapeFill = [TKSolidFill solidFillWithColor:[UIColor whiteColor]];
    if ([cell isKindOfClass:[TKCalendarDayCell class]]) {
        TKCalendarDayCell *dayCell = (TKCalendarDayCell*)cell;
        if (dayCell.state & TKCalendarDayStateSelected) {
            dayCell.style.textColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.2 alpha:1];
        }
    }
    if ([cell isKindOfClass:[TKCalendarDayNameCell class]]) {
        TKCalendarDayNameCell *dayNameCell = (TKCalendarDayNameCell*)cell;
        dayNameCell.label.text = [dayNameCell.label.text substringWithRange:NSMakeRange(0, 1)];
    }
    if ([cell isKindOfClass:[TKCalendarMonthTitleCell class]]) {
        TKCalendarMonthTitleCell *titleCell = (TKCalendarMonthTitleCell*)cell;
        titleCell.layoutMode = TKCalendarMonthTitleCellLayoutModeMonthWithButtons;
    }
}

- (void)calendar:(TKCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSDateComponents *components = [calendar.calendar components:NSCalendarUnitDay fromDate:date];
    self.dayLabel.text = [NSString stringWithFormat:@"%d", (int)components.day];
}

@end
