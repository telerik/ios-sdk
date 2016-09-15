//
//  CalendarViewModes.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarViewModes: TKExamplesExampleViewController, TKCalendarDelegate {
    
    let calendarView = TKCalendar()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Week view", action: selectWeekView)
        self.addOption("Month", action: selectMonth)
        self.addOption("Month Names", action: selectMonthNames)
        self.addOption("Year", action: selectYear)
        self.addOption("Year Numbers", action: selectYearNumbers)
        self.addOption("Flow", action: selectFlow)
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
// >> view-modes-pinchzoom-swift
        self.calendarView.allowPinchZoom = true
// << view-modes-pinchzoom-swift
        self.calendarView.navigateToDate(date, animated: false)

// >> view-modes-presenter-swift
        let presenter = self.calendarView.presenter as! TKCalendarYearPresenter
        presenter.columns = 3
// << view-modes-presenter-swift
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.calendarView.viewMode == TKCalendarViewMode.Week {
            self.calendarView.frame = CGRectMake(0, self.view.bounds.origin.y, CGRectGetWidth(self.view.bounds), 100)
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
// >> getting-started-viewmodeyear-swift
        self.calendarView.viewMode = TKCalendarViewMode.Year
// << getting-started-viewmodeyear-swift        
    }
    
    func selectMonth() {
// >> view-modes-month-swift
        self.calendarView.viewMode = TKCalendarViewMode.Month
// << view-modes-month-swift        
    }
    
    func selectMonthNames() {
// >> view-modes-monthnames-swift
        self.calendarView.viewMode = TKCalendarViewMode.MonthNames
// << view-modes-monthnames-swift
    }
    
    func selectYearNumbers() {
// >> view-modes-yearnumber-swift
        self.calendarView.viewMode = TKCalendarViewMode.YearNumbers
// << view-modes-yearnumber-swift
    }
    
    func selectFlow() {
// >> view-modes-flow-swift
        self.calendarView.viewMode = TKCalendarViewMode.Flow
// << view-modes-flow-swift        
    }
    
    func selectWeekView() {
// >> view-modes-week-swift
        self.calendarView.viewMode = TKCalendarViewMode.Week
// << view-modes-week-swift        
    }
    
//MARK: - TKCalendarDelegate

// >> view-modes-changeviewmode-swift
    func calendar(calendar: TKCalendar, didChangedViewModeFrom previousViewMode: TKCalendarViewMode, to viewMode: TKCalendarViewMode) {
        if viewMode == TKCalendarViewMode.Week || previousViewMode == TKCalendarViewMode.Week {
            self.view.setNeedsLayout()
        }
        
        self.selectedOption = UInt(viewMode.rawValue);
    }
}
// << view-modes-changeviewmode-swift