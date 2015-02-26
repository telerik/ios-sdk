//
//  CalendarViewModes.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarViewModes: ExampleViewController, TKCalendarDelegate {
    
    let calendarView = TKCalendar()
    
    override init() {
        super.init()
        
        self.addOption("Week view") { self.selectWeekView() }
        self.addOption("Month") { self.selectMonth() }
        self.addOption("Month Names") { self.selectMonthNames() }
        self.addOption("Year") { self.selectYear() }
        self.addOption("Year Numbers") { self.selectYearNumbers() }
        self.addOption("Flow") { self.selectFlow() }
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        calendar.firstWeekday = 2
        let components = NSDateComponents()
        components.year = -10
        let minDate: NSDate = calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(0))!
        components.year = 10
        let maxDate: NSDate = calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(0))!
        
        self.calendarView.frame = self.view.bounds
        self.calendarView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
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
            self.calendarView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)
        }
        else {
            self.calendarView.frame = self.view.bounds
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

    func calendar(calendar: TKCalendar!, didChangedViewModeFrom previousViewMode: TKCalendarViewMode, to viewMode: TKCalendarViewMode) {
        if viewMode == TKCalendarViewMode.Week || previousViewMode == TKCalendarViewMode.Week {
            self.view.setNeedsLayout()
        }
        
        self.selectedOption = viewMode.rawValue;
    }
}