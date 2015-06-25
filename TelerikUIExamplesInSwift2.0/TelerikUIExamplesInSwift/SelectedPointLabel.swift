//
//  SelectedPointLabel.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class SelectedPointLabel: CALayer {
    
    var labelStyle: TKChartPointLabelStyle?
    var text: NSString?
    var isOutsideBounds = false

    override func drawInContext(ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        let fill = self.labelStyle!.fill
        let stroke = TKStroke(color: UIColor.blackColor())
        let shape = TKBalloonShape(size: CGSizeMake(self.bounds.size.width - stroke.width, self.bounds.size.height - stroke.width))
        var textRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y - self.labelStyle!.insets.top, self.bounds.size.width, self.bounds.size.height + self.labelStyle!.insets.bottom)
        if self.isOutsideBounds {
            shape.arrowPosition = TKBalloonShapeArrowPosition.Top
            textRect = CGRectMake(bounds.origin.x, bounds.origin.y - self.labelStyle!.insets.top + shape.arrowSize.height,
                bounds.size.width, bounds.size.height - self.labelStyle!.insets.bottom)
        }
        else {
            shape.arrowPosition = TKBalloonShapeArrowPosition.Bottom
        }
        
        shape.drawInContext(ctx, withCenter: CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)), drawings: [fill, stroke])
        let paragraphStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = self.labelStyle!.textAlignment
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(16),
                          NSForegroundColorAttributeName: self.labelStyle!.textColor,
                          NSParagraphStyleAttributeName: paragraphStyle]
        
        self.text!.drawWithRect(textRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        UIGraphicsPopContext()
    }
    
}
