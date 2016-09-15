//
//  CalendarEventKitDataBinding.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarEventKitDataBinding: TKExamplesExampleViewController {
    
    let calendarView = TKCalendar()
    var dataSource = TKCalendarEventKitDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = TKCalendarEventKitDataSource()
// >> populating-with-data-kitdatasource-swift
        self.calendarView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.calendarView.dataSource = self.dataSource
        self.view.addSubview(self.calendarView)
// << populating-with-data-kitdatasource-swift
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.calendarView.frame = self.view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
