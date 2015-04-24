//
//  CalendarCustomization.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarCustomization: ExampleViewController, TKCalendarDelegate {
    
    let calendarView = TKCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendarView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.calendarView.delegate = self
        self.view.addSubview(self.calendarView)
        
        let img = UIImage(named: "calendar_header")
        let presenter = self.calendarView.presenter() as! TKCalendarMonthPresenter
        presenter.style().titleCellHeight = 20
        presenter.headerView().contentMode = UIViewContentMode.ScaleToFill
        presenter.headerView().backgroundColor = UIColor(patternImage: img!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = min(CGRectGetWidth(self.exampleBounds), CGRectGetHeight(self.exampleBounds))
        self.calendarView.frame = CGRectMake(self.exampleBounds.origin.x + (CGRectGetWidth(self.exampleBounds) - width)/2.0, self.exampleBounds.origin.y, width, width)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: TKCalendarDelegate
    
    func calendar(calendar: TKCalendar!, viewForCellOfKind cellType: TKCalendarCellType) -> TKCalendarCell! {
        if cellType == TKCalendarCellType.Day {
            return CustomCell()
        }
        return nil
    }
}