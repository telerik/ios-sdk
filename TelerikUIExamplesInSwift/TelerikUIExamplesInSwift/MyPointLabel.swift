//
//  MyPointLabel.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class MyPointLabel: TKChartPointLabel {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var paragraphStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = self.style.textAlignment
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(18),
            NSForegroundColorAttributeName: self.style.textColor,
            NSParagraphStyleAttributeName: paragraphStyle]
        
        let text: NSString = self.text as NSString
        let textSize = text.sizeWithAttributes(attributes)
        let labelSize = CGSizeMake(textSize.width - 1.5 * (self.style.insets.left + self.style.insets.right) + abs(self.style.shadowOffset.width),
            textSize.height - 1.5 * (self.style.insets.top + self.style.insets.bottom) + abs(self.style.shadowOffset.height))
        return labelSize
    }
    
    override func drawInContext(ctx: CGContext!, inRect bounds: CGRect, forVisualPoint visualPoint: TKChartVisualPoint!) {
        UIGraphicsPushContext(ctx)
        let fill = self.style.fill
        let stroke = TKStroke(color: UIColor.blackColor())
        let shape = TKBalloonShape(arrowPosition: TKBalloonShapeArrowPosition.Bottom, size: bounds.size)
        shape.drawInContext(ctx, withCenter: CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds)), drawings: [fill, stroke])
        let textRect = CGRectMake(bounds.origin.x, bounds.origin.y - self.style.insets.top, bounds.size.width,
            bounds.size.height + self.style.insets.bottom)
        var paragraphStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = self.style.textAlignment
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(16),
                          NSForegroundColorAttributeName: self.style.textColor,
                          NSParagraphStyleAttributeName: paragraphStyle]
        
        (text as NSString).drawWithRect(textRect,
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: attributes,
            context: nil)
        
        UIGraphicsPopContext()
    }
}
