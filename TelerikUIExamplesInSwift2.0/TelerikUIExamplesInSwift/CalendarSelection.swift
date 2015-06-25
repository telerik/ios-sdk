//
//  CalendarSelection.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarSelection: ExampleViewController, TKCalendarDelegate {
    
    let calendarView = TKCalendar()
    var unselectable:NSDate?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Single date selection") { self.selectSingleMode() }
        self.addOption("Multiple dates selection") { self.selectMultipleMode() }
        self.addOption("Date range selection") { self.selectRangeMode() }

        self.selectedOption = 2
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendarView.delegate = self
        self.calendarView.selectionMode = TKCalendarSelectionMode.Range
        self.view.addSubview(self.calendarView)
        
        let date = NSDate()
        let components = NSDateComponents()
        components.day = 1
        self.unselectable = self.calendarView.calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue:0))
        components.day = 3
        let startDate = self.calendarView.calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue:0))
        components.day = 6
        let endDate = self.calendarView.calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue:0));
        
        components.year = -5
        self.calendarView.minDate = self.calendarView.calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0))

        components.year = 5
        self.calendarView.maxDate = self.calendarView.calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0))

        self.calendarView.selectedDatesRange = TKDateRange(start: startDate, end: endDate)
        
        let presenter = self.calendarView.presenter() as! TKCalendarMonthPresenter
        presenter.headerIsSticky = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.calendarView.frame = self.exampleBounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - Events
    
    func selectSingleMode() {
        self.calendarView.selectionMode = TKCalendarSelectionMode.Single
    }
    
    func selectMultipleMode() {
        self.calendarView.selectionMode = TKCalendarSelectionMode.Multiple
    }
    
    func selectRangeMode() {
        self.calendarView.selectionMode = TKCalendarSelectionMode.Range
    }
    
//MARK: - TKCalendarDelegate
    
    func calendar(calenadr:TKCalendar, didSelectDate date: NSDate) {
        print("selected: %@", date)
    }
    
    func calendar(calenadr:TKCalendar, didDeselectedDate date: NSDate) {
        print("deselected: %@", date)
    }
    
    func calendar(calenadr:TKCalendar, shouldSelectDate date: NSDate)->Bool {
        print("Trying to select the unselectable: %@", date)
        return TKCalendar.isDate(self.unselectable, equalToDate: date, withComponents: NSCalendarUnit.Year, withCalendar: calendarView.calendar)
    }
    
    func calendar(calendar: TKCalendar!, updateVisualsForCell cell: TKCalendarCell!) {
        if cell.isKindOfClass(TKCalendarMonthTitleCell.self) {
            let monthTitleCell = cell as! TKCalendarMonthTitleCell
            monthTitleCell.layoutMode = TKCalendarMonthTitleCellLayoutMode.MonthAndYearWithButotns
        }
    }
}
