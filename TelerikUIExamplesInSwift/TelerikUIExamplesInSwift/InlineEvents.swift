//
//  InlineEvents.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class InlineEvents: ExampleViewController, TKCalendarDataSource, TKCalendarMonthPresenterDelegate {
    
    let calendarView = TKCalendar()
    let events = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createEvents()
        
        // Do any additional setup after loading the view.
        self.calendarView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.calendarView.dataSource = self
        self.view.addSubview(self.calendarView)
        
        let presenter = self.calendarView.presenter as! TKCalendarMonthPresenter
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            presenter.inlineEventsViewMode = TKCalendarInlineEventsViewMode.Popover
        }
        else {
            presenter.inlineEventsViewMode = TKCalendarInlineEventsViewMode.Inline
        }
        presenter.inlineEventsView.maxHeight = 140
        presenter.inlineEventsView.fixedHeight = false
        presenter.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.calendarView.frame = self.exampleBounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createEvents() {

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
        e.allDay = false
        e.eventColor = colors[Int(arc4random()%count)]
        events.addObject(e)
        
        e = TKCalendarEvent()
        e.title = "Three-day event"
        e.startDate = self.dateWithOffset(2, hours: 1)
        e.endDate = self.dateWithOffset(4, hours: 2)
        e.allDay = false
        e.eventColor = colors[Int(arc4random()%count)]
        events.addObject(e)
        
        for _ in 0..<3 {
            e = TKCalendarEvent()
            e.title = titles[Int(arc4random()%UInt32(titles.count-1))]
            e.startDate = self.dateWithOffset(7, hours: 1)
            e.endDate = self.dateWithOffset(7, hours: 2)
            e.allDay = true
            e.eventColor = colors[Int(arc4random()%count)]
            events.addObject(e)
        }
        
        for _ in 0..<5 {
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
    
    func dateWithOffset(days:NSInteger, hours:NSInteger) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.day = days
        components.hour = hours
        return calendar.dateByAddingComponents(components, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))!
    }
    
//MARK: - TKCalendarDataSource

    func calendar(calendar: TKCalendar, eventsForDate date: NSDate) -> [AnyObject]? {
        var components : NSDateComponents
        components = self.calendarView.calendar.components(NSCalendarUnit(rawValue: NSCalendarUnit.Year.rawValue | NSCalendarUnit.Month.rawValue | NSCalendarUnit.Day.rawValue), fromDate: date)
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endDate = self.calendarView.calendar.dateFromComponents(components)
        let predicate = NSPredicate(format: "(startDate <= %@) AND (endDate >= %@)", endDate!, date)
        return self.events.filteredArrayUsingPredicate(predicate)
    }
    
//MARK: - TKCalendarMonthPresenterDelegate
    
    func monthPresenter(presenter: TKCalendarMonthPresenter, inlineEventSelected event: TKCalendarEventProtocol) {
        
        print("event selected: \(event.title)")
        
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertView(title: "Event selected", message: event.title, delegate: nil, cancelButtonTitle: "Done")
            alert.show()
        });
    }
}
