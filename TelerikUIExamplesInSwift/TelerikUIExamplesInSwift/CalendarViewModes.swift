//
//  CalendarViewModes.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarViewModes: ExampleViewController, TKCalendarDelegate {
    
    let calendarView = TKCalendar()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Week view") { self.selectWeekView() }
        self.addOption("Month") { self.selectMonth() }
        self.addOption("Month Names") { self.selectMonthNames() }
        self.addOption("Year") { self.selectYear() }
        self.addOption("Year Numbers") { self.selectYearNumbers() }
        self.addOption("Flow") { self.selectFlow() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        calendar.firstWeekday = 2
        let components = NSDateComponents()
        components.year = -10
        let minDate: NSDate = calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue:0))!
        components.year = 10
        let maxDate: NSDate = calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue:0))!
        
        self.calendarView.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(self.calendarView)
        
        self.calendarView.delegate = self
        self.calendarView.viewMode = TKCalendarViewMode.Year
        self.calendarView.calendar = calendar
        self.calendarView.minDate = minDate
        self.calendarView.maxDate = maxDate
        self.calendarView.navigateToDate(date, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.calendarView.viewMode == TKCalendarViewMode.Week {
            self.calendarView.frame = CGRectMake(0, self.exampleBounds.origin.y, CGRectGetWidth(self.exampleBounds), 100)
        }
        else {
            self.calendarView.frame = self.exampleBounds
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - Events
    
    func selectYear() {
        self.calendarView.viewMode = TKCalendarViewMode.Year
    }
    
    func selectMonth() {
        self.calendarView.viewMode = TKCalendarViewMode.Month
    }
    
    func selectMonthNames() {
        self.calendarView.viewMode = TKCalendarViewMode.MonthNames
    }
    
    func selectYearNumbers() {
        self.calendarView.viewMode = TKCalendarViewMode.YearNumbers
    }
    
    func selectFlow() {
        self.calendarView.viewMode = TKCalendarViewMode.Flow
    }
    
    func selectWeekView() {
        self.calendarView.viewMode = TKCalendarViewMode.Week
    }
    
//MARK: - TKCalendarDelegate

    func calendar(calendar: TKCalendar, didChangedViewModeFrom previousViewMode: TKCalendarViewMode, to viewMode: TKCalendarViewMode) {
        if viewMode == TKCalendarViewMode.Week || previousViewMode == TKCalendarViewMode.Week {
            self.view.setNeedsLayout()
        }
        
        self.selectedOption = viewMode.rawValue;
    }
}