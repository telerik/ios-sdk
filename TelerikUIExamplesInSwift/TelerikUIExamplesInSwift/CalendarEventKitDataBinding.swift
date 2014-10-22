//
//  CalendarEventKitDataBinding.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarEventKitDataBinding: ExampleViewController, TKCalendarEventKitDataSourceDelegate {
    
    let calendarView = TKCalendar()
    let dataSource = TKCalendarEventKitDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource.delegate = self
        
        self.calendarView.frame = self.view.bounds
        self.calendarView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.calendarView.dataSource = self.dataSource
        self.view.addSubview(self.calendarView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - TKCalendarEventKitDataSourceDelegate
    
    func shouldImportEventsFromCalendar(calendar: EKCalendar!) -> Bool {
        if calendar.type.value == EKCalendarTypeLocal.value  {
            return true
        }
        return false
    }
}
