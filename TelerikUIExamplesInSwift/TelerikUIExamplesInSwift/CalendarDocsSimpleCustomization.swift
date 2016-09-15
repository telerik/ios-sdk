//
//  CalendarDocsSimpleCustomization.swift
//  TelerikUIExamplesInSwift
//  Copyright © 2016 Telerik. All rights reserved.
//

import Foundation

class CalendarDocsSimpleCustomization: UIViewController, TKCalendarDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
// >> customization-theme-swift
        let calendar = TKCalendar(frame: self.view.bounds)
        calendar.theme = TKCalendarIPadTheme()
        calendar.delegate = self
// << customization-theme-swift         
        
// >> customization-presenter-swift
        let presenter = calendar.presenter as! TKCalendarMonthPresenter
        presenter.style.titleCellHeight = 40
        presenter.style.backgroundColor = UIColor.redColor()
        presenter.headerIsSticky = true
        presenter.style.monthNameTextEffect = TKCalendarTextEffect.Lowercase
        presenter.update(false)
// << customization-presenter-swift        
    }

// >> customization-updatevisualcell-swift
    func calendar(calendar: TKCalendar, updateVisualsForCell cell: TKCalendarCell) {
        if cell.isKindOfClass(TKCalendarDayCell) {
            let dayCell: TKCalendarDayCell = cell as! TKCalendarDayCell
            if (dayCell.state.rawValue & TKCalendarDayState.Today.rawValue) != 0 {
                cell.style().textColor = UIColor(red: 0.0039, green: 0.5843, blue: 0.5529, alpha: 1.0000)
            }
            else {
                cell.style().textColor = UIColor.blackColor()
            }
        }
    }
// << customization-updatevisualcell-swift
    
// >> customization-viewforcell-swift
    func calendar(calendar: TKCalendar, viewForCellOfKind cellType: TKCalendarCellType) -> TKCalendarCell? {
        if cellType == TKCalendarCellType.Day {
            let cell = DocsCustomCell()
            return cell
        }
        return nil
    }
// << customization-viewforcell-swift
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
