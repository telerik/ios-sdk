//
//  DocsCustomCell.swift
//  TelerikUIExamplesInSwift
//  Copyright © 2016 Telerik. All rights reserved.
//

import Foundation

// >> customization-customcell-swift
class DocsCustomCell: TKCalendarDayCell {
    override func updateVisuals() {
        super.updateVisuals()
        
        if self.state.rawValue & TKCalendarDayState.Today.rawValue != 0 {
            self.label.textColor = UIColor.redColor()
        }
        else {
            self.label.textColor = UIColor.blueColor()
        }
    }
}
// << customization-customcell-swift