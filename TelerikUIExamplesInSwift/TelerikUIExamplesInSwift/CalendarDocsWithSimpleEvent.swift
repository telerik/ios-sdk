//
//  CalendarWithSimpleEvent.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

// >> getting-started-example-swift
import Foundation

// >> getting-started-datasource-swift
class CalendarDocsWithSimpleEvent: TKExamplesExampleViewController, TKCalendarDataSource, TKCalendarDelegate {
// << getting-started-datasource-swift
    
    let calendarView = TKCalendar();
    var events = NSMutableArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
// >> getting-started-calendar-swift
        let calendarView = TKCalendar(frame: self.view.bounds)
        calendarView.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(calendarView)
// << getting-started-calendar-swift

        calendarView.delegate = self
// >> getting-started-assigndatasource-swift
        calendarView.dataSource = self
// << getting-started-assigndatasource-swift
        
// >> getting-started-minmaxdate-swift
        calendarView.minDate = TKCalendar.dateWithYear(2010, month: 1, day: 1, withCalendar: nil)
        calendarView.maxDate = TKCalendar.dateWithYear(2016, month: 12, day: 31, withCalendar: nil)
// << getting-started-minmaxdate-swift
        
// >> getting-started-event-swift
        let array = NSMutableArray();
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        for _ in 0..<3 {
            let event = TKCalendarEvent()
            event.title = "Sample event"
            let components = self.calendarView.calendar.components(NSCalendarUnit(rawValue:NSCalendarUnit.Year.rawValue | NSCalendarUnit.Month.rawValue | NSCalendarUnit.Day.rawValue), fromDate: date)
            components.day = Int(arc4random() % 50)
            event.startDate = calendar.dateFromComponents(components)!
            event.endDate = calendar.dateFromComponents(components)!
            event.eventColor = UIColor.redColor()
            self.events.addObject(event)
        }
    
        self.events = array;
// << getting-started-event-swift
    
// >> getting-started-navigatetodate-swift
        let components = NSDateComponents()
        components.year = 2016
        components.month = 6
        components.day = 1
        let newDate = self.calendarView.calendar.dateFromComponents(components)
// >> navigation-navigate-swift
        calendarView.navigateToDate(newDate!, animated: false)
// << navigation-navigate-swift        
// << getting-started-navigatetodate-swift
    
        self.calendarView.reloadData();
    }

// >> getting-started-eventsfordate-swift
    func calendar(calendar: TKCalendar, eventsForDate date: NSDate) -> [AnyObject]? {
        let components = self.calendarView.calendar.components(NSCalendarUnit(rawValue:NSCalendarUnit.Year.rawValue | NSCalendarUnit.Month.rawValue | NSCalendarUnit.Day.rawValue), fromDate: date)
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endDate = self.calendarView.calendar.dateFromComponents(components)
        let predicate = NSPredicate(format: "(startDate <= %@) AND (endDate >= %@)", endDate!, date)
        return self.events.filteredArrayUsingPredicate(predicate)
    }
// << getting-started-eventsfordate-swift

// >> getting-started-didselectdate-swift
    func calendar(calendar: TKCalendar, didSelectDate date: NSDate) {
        NSLog("%@", date)
    }
// << getting-started-didselectdate-swift    

}
// << getting-started-example-swift
