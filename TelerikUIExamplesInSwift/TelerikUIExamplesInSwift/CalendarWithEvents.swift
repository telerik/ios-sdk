//
//  CalendarWithEvents.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarWithEvents: ExampleViewController, TKCalendarDataSource, TKCalendarDelegate, UITableViewDataSource {
    
    let kCellID = "cell"
    let calendarView = TKCalendar()
    let tableView = UITableView()
    let events = NSMutableArray()
    var eventsForDate:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createEvents()
        
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        calendar.firstWeekday = 2
        
        let components = NSDateComponents()
        components.year = -10
        let date = NSDate()
        let minDate = calendar.dateByAddingComponents(components, toDate: date , options: NSCalendarOptions(0))
        components.year = 10
        let maxDate = calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(0))
        
        self.calendarView.calendar = calendar
        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        self.calendarView.minDate = minDate
        self.calendarView.maxDate = maxDate
        self.calendarView.allowPinchZoom = true
        
        let presenter = self.calendarView.presenter() as! TKCalendarMonthPresenter
        presenter.style().titleCellHeight = 40
        presenter.headerIsSticky = true
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            presenter.weekNumbersHidden = true
            self.calendarView.theme = TKCalendarIPadTheme()
            self.calendarView.presenter().update(true)
        }
        else {
            presenter.weekNumbersHidden = false
        }
        self.view.addSubview(self.calendarView)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellID)
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.calendarView.theme!.isKindOfClass(TKCalendarIPadTheme.self) || UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
            self.tableView.frame = CGRectZero
            self.calendarView.frame = self.exampleBounds
        }
        else {
            let height =  CGRectGetHeight(self.exampleBounds)
            let tableHeight = height/3.2
            self.calendarView.frame = CGRectMake(0, self.exampleBounds.origin.y, self.exampleBounds.size.width, height - tableHeight)
            self.tableView.frame = CGRectMake(0, self.exampleBounds.origin.y + self.exampleBounds.size.height - tableHeight, self.exampleBounds.size.width, tableHeight)
        }
    }
    
    func createEvents() {
        let locations = ["Sofia", "London", "Paris", "New York", "San Francisco", "Home"]
        let colors = [
            UIColor(red:88.0/255.0, green:86.0/255.0, blue:214.0/255.0, alpha:1.0),
            UIColor(red:255.0/255.0, green:149.0/255.0, blue:3.0/255.0, alpha:1.0),
            UIColor(red:255.0/255.0, green:45.0/255.0, blue:85.0/255.0, alpha:1.0),
            UIColor(red:76.0/255.0, green:217.0/255.0, blue:100.0/255.0, alpha:1.0),
            UIColor(red:255.0/255.0, green:204.0/255.0, blue:3.0/255.0, alpha:1.0) ]
        let titles = ["Meeting with Jack", "Lunch with Peter", "Planning meeting", "Go shopping", "Very important meeting", "Another meeting", "Lorem ipsum"]
        let count:UInt32 = UInt32(colors.count-1)
        
        var e = TKCalendarEvent()
        e.title = "Two-day event"
        e.startDate = self.dateWithOffset(1, hours: 2)
        e.endDate = self.dateWithOffset(2, hours: 4)
        e.allDay = true
        e.eventColor = colors[Int(arc4random()%count)]
        events.addObject(e)
        
        e = TKCalendarEvent()
        e.title = "Three-day day event"
        e.startDate = self.dateWithOffset(2, hours: 1)
        e.endDate = self.dateWithOffset(4, hours: 2)
        e.allDay = true
        e.eventColor = colors[Int(arc4random()%count)]
        events.addObject(e)

        for i in 0..<3 {
            e = TKCalendarEvent()
            e.title = titles[Int(arc4random()%UInt32(titles.count-1))]
            e.startDate = self.dateWithOffset(7, hours: 1)
            e.endDate = self.dateWithOffset(7, hours: 2)
            e.allDay = true
            e.eventColor = colors[Int(arc4random()%count)]
            events.addObject(e)
        }
        
        for i in 0..<5 {
            var dayOffset = Int(arc4random() % 20)
            if dayOffset < 10 {
                dayOffset = dayOffset * 1
            }
            else {
                dayOffset -= 10
            }
            
            let duration = Int(arc4random()%30)
            e = TKCalendarEvent()
            e.title = titles[Int(arc4random()%UInt32(titles.count-1))]
            e.startDate = self.dateWithOffset(dayOffset, hours: 0)
            e.endDate = self.dateWithOffset((dayOffset+duration/10), hours: 3)
            e.allDay = true
            e.eventColor = colors[Int(arc4random()%UInt32(colors.count-1))]
            events.addObject(e)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dateWithOffset(days:NSInteger, hours:NSInteger) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.day = days
        components.hour = hours
        return calendar.dateByAddingComponents(components, toDate: NSDate(), options: NSCalendarOptions(0))!
    }
    
//MARK: - TKCalendarDataSource

    func calendar(calendar: TKCalendar!, eventsForDate date: NSDate!) -> [AnyObject]! {
        var components : NSDateComponents
        
        components = self.calendarView.calendar.components(NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit, fromDate: date)
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endDate = self.calendarView.calendar.dateFromComponents(components)
        let predicate = NSPredicate(format: "(startDate <= %@) AND (endDate >= %@)", endDate!, date)
        let result:NSArray = self.events.filteredArrayUsingPredicate(predicate)
        return result as [AnyObject]
    }
    
//MARK: - TKCalendarDelegate

    func calendar(calendar: TKCalendar!, didSelectDate date: NSDate!) {
        self.eventsForDate = self.calendarView.eventsForDate(date)
        self.tableView.reloadData()
    }
    
//MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.eventsForDate != nil {
            return self.eventsForDate!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellID) as! UITableViewCell
        let event = self.eventsForDate![indexPath.row] as! TKCalendarEvent
        cell.textLabel!.text = event.title
        return cell
    }
}
