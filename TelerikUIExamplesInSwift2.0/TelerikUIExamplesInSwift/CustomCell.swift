//
//  CustomCell.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

struct CellImages
{
    static var dayImage: UIImage?
    static var currentDayImage: UIImage?
    static var selectedDayImage: UIImage?
 
    static func loadImages() {
        if (CellImages.dayImage == nil) {
            CellImages.dayImage = UIImage(named: "calendar_cell")
            CellImages.dayImage = CellImages.dayImage!.resizableImageWithCapInsets(UIEdgeInsetsMake(4, 4, 4, 4), resizingMode: UIImageResizingMode.Stretch)
        }
        
        if (CellImages.currentDayImage == nil) {
            CellImages.currentDayImage = UIImage(named: "calendar_current_cell")
            CellImages.currentDayImage = CellImages.currentDayImage!.resizableImageWithCapInsets(UIEdgeInsetsMake(4, 4, 4, 4), resizingMode: UIImageResizingMode.Stretch)
        }

        if (CellImages.selectedDayImage == nil) {
            CellImages.selectedDayImage = UIImage(named: "calendar_selected_cell")
            CellImages.selectedDayImage = CellImages.selectedDayImage!.resizableImageWithCapInsets(UIEdgeInsetsMake(12, 12, 12, 12), resizingMode: UIImageResizingMode.Stretch)
        }
    }
}

class CustomCell: TKCalendarDayCell {
    
    var currentImg: UIImage?
    
    override func updateVisuals() {
        super.updateVisuals()
    
        CellImages.loadImages()
        
        self.style()!.backgroundColor = UIColor.clearColor()
        self.style()!.shape = nil
        self.style()!.topBorderColor = nil
        self.style()!.bottomBorderColor = nil

        if self.state.rawValue & TKCalendarDayState.Selected.rawValue != 0 {
            self.currentImg = CellImages.selectedDayImage!
        }
        else if self.state.rawValue & TKCalendarDayState.Today.rawValue != 0 {
            self.currentImg = CellImages.currentDayImage!
            self.label.textColor = UIColor.whiteColor()
        }
        else {
            self.currentImg = CellImages.dayImage!
        }
    }
    
    override func drawRect(rect: CGRect) {
        if let img = self.currentImg {
            img.drawInRect(rect)
        }
        super.drawRect(rect)
    }
}