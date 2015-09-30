//
//  AlertCustomContentView.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class AlertCustomContentView: UIView, TKCalendarDelegate {

    let dayLabel = UILabel()
    let calendarView = TKCalendar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width : CGFloat = CGRectGetWidth(frame)
        let height : CGFloat = CGRectGetHeight(frame)
        let color : UIColor = UIColor(red: 0.5, green: 0.7, blue: 0.2, alpha: 1)
        
        self.calendarView.frame = CGRectMake(width/2 - 0.5, 0, width/2 + 0.5, height)
        self.calendarView.delegate = self
        self.addSubview(self.calendarView)
        
        let presenter :TKCalendarMonthPresenter = self.calendarView.presenter as! TKCalendarMonthPresenter
        presenter.style.backgroundColor = color

        self.dayLabel.frame = CGRectMake(0, 0, width/2, height)
        self.dayLabel.textAlignment = NSTextAlignment.Center
        self.dayLabel.textColor = color
        self.dayLabel.font = UIFont.systemFontOfSize(60)
        self.dayLabel.text = "20"
        self.addSubview(self.dayLabel)        

        self.calendarView.selectedDate = NSDate()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - TKCalendarDelegate
    
    func calendar(calendar: TKCalendar, updateVisualsForCell cell: TKCalendarCell) {
        
        cell.style().textColor = UIColor.whiteColor()
        cell.style().bottomBorderWidth = 0
        cell.style().topBorderWidth = 0
        cell.style().textFont = UIFont.systemFontOfSize(10)
        cell.style().shapeFill = TKSolidFill(color: UIColor.whiteColor())
    
        if cell.isKindOfClass(TKCalendarDayCell.self) {
            let dayCell = cell as! TKCalendarDayCell
            if ((dayCell.state.rawValue & TKCalendarDayState.Selected.rawValue) != 0) {
                dayCell.style().textColor = UIColor(red: 0.5, green: 0.7, blue: 0.2, alpha: 1)
            }
        }
        
        if cell.isKindOfClass(TKCalendarDayNameCell.self) {
            let dayNameCell = cell as! TKCalendarDayNameCell
            dayNameCell.label.text = (dayNameCell.label.text as NSString!).substringWithRange(NSRange(location: 0, length: 1))
        }
        
        if cell.isKindOfClass(TKCalendarMonthTitleCell.self) {
            let monthTitleCell = cell as! TKCalendarMonthTitleCell
            monthTitleCell.layoutMode = TKCalendarMonthTitleCellLayoutMode.MonthWithButtons
            monthTitleCell.tintColor = UIColor.whiteColor()
        }
    }
    
    func calendar(calendar: TKCalendar, didSelectDate date: NSDate) {
        let components: NSDateComponents = calendar.calendar.components(NSCalendarUnit.Day, fromDate: date)
        self.dayLabel.text = "\(components.day)"
    }
}
