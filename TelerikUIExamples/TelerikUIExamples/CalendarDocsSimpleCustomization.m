//
//  CalendarSimpleCustomization.m
//  TelerikUIExamples
//
//  Created by Miroslava Ivanova on 6/6/16.
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "CalendarDocsSimpleCustomization.h"
#import <TelerikUI/TelerikUI.h>
#import "DocsCustomCell.h"

@interface CalendarDocsSimpleCustomization() <TKCalendarDelegate>

//@property (nonatomic, strong) TKCalendar *calendarView;

@end

@implementation CalendarDocsSimpleCustomization

- (void)viewDidLoad
{
// >> customization-theme
    TKCalendar *calendarView = [[TKCalendar alloc] initWithFrame:self.view.bounds];
    calendarView.theme = [TKCalendarIPadTheme new];
    [self.view addSubview:calendarView];
// << customization-theme    
    
// >> customization-presenter
    TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)calendarView.presenter;
    presenter.style.titleCellHeight = 40;
    presenter.style.backgroundColor = [UIColor redColor];
    presenter.headerIsSticky = YES;
    presenter.style.monthNameTextEffect = TKCalendarTextEffectLowercase;
    [presenter update:NO];
// << customization-presenter
    
}

#pragma mark TKCalendarDelegate
// >> customization-updatevisualcell
- (void)calendar:(TKCalendar*)calendar updateVisualsForCell:(TKCalendarCell*)cell;
{
    if ([cell isKindOfClass:[TKCalendarDayCell class]]) {
        TKCalendarDayCell *dayCell = (TKCalendarDayCell*)cell;
        if (dayCell.state & TKCalendarDayStateToday) {
            cell.style.textColor = [UIColor colorWithRed:0.0039 green:0.5843 blue:0.5529 alpha:1.0000];
        }
        else {
            cell.style.textColor = [UIColor greenColor];
        }
    }
}
// << customization-updatevisualcell

// >> customization-viewforcell
- (TKCalendarCell *)calendar:(TKCalendar *)calendar viewForCellOfKind:(TKCalendarCellType)cellType
{
    if (cellType == TKCalendarCellTypeDay) {
        DocsCustomCell *cell = [DocsCustomCell new];
        return cell;
    }
    return nil;
}
// << customization-viewforcell

@end
