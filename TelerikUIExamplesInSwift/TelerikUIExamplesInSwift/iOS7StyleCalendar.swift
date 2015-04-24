//
//  iOS7StyleCalendar.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class iOS7StyleCalendar:ExampleViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.setTitle("Tap to load iOS 7 style calendar", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonTouched:", forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(0, self.view.bounds.size.height/2.0 - 20, self.view.bounds.size.width, 40)
        self.view.addSubview(button)
    }
    
    func buttonTouched(sender: AnyObject) {
        self.title = "Back"
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        calendar.firstWeekday = 2
        let date = NSDate()
        let controller = TKCalendarYearViewController()
        controller.contentView().minDate = TKCalendar.dateWithYear(2012, month: 1, day: 1, withCalendar: calendar)
        controller.contentView().maxDate = TKCalendar.dateWithYear(2018, month: 12, day: 31, withCalendar: calendar)
        controller.contentView().navigateToDate(date, animated: false)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = "iOS 7 style calendar"
        self.navigationController?.delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
