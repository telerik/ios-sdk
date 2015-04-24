//
//  CalendarEventKitDataBinding.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarEventKitDataBinding: ExampleViewController {
    
    let calendarView = TKCalendar()
    let dataSource = TKCalendarEventKitDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendarView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.calendarView.dataSource = self.dataSource
        self.view.addSubview(self.calendarView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.calendarView.frame = self.exampleBounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
