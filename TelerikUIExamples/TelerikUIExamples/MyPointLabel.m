//
//  MyPointLabel.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "MyPointLabel.h"
#import <TelerikUI/TelerikUI.h>

@implementation MyPointLabel

- (CGSize)sizeThatFits:(CGSize)size
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = self.style.textAlignment;
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:18],
                                  NSForegroundColorAttributeName: self.style.textColor,
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    CGSize textSize = [self.text sizeWithAttributes:attributes];
    CGSize labelSize = CGSizeMake(textSize.width - 1.5 * (self.style.insets.left + self.style.insets.right) + fabs(self.style.shadowOffset.width),
                                  textSize.height - 1.5 * (self.style.insets.top + self.style.insets.bottom) + fabs(self.style.shadowOffset.height));
    return labelSize;
}

- (void)drawInContext:(CGContextRef)ctx inRect:(CGRect)bounds forVisualPoint:(TKChartVisualPoint *)visualPoint color:(UIColor * _Nullable)paletteTextColor
{
    UIGraphicsPushContext(ctx);
    TKFill *fill = self.style.fill;
    TKStroke *stroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    TKBalloonShape *shape = [[TKBalloonShape alloc] initWithArrowPosition:TKBalloonShapeArrowPositionBottom size:bounds.size];
    [shape drawInContext:ctx withCenter:CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds)) drawings:@[fill, stroke]];
    
    
    CGRect textRect = CGRectMake(bounds.origin.x, bounds.origin.y - self.style.insets.top,
                                 bounds.size.width, bounds.size.height + self.style.insets.bottom);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = self.style.textAlignment;
    NSMutableDictionary *attributes = [@{ NSFontAttributeName: [UIFont systemFontOfSize:16],
                                          NSForegroundColorAttributeName: paletteTextColor,
                                          NSParagraphStyleAttributeName: paragraphStyle } mutableCopy];
    
    [self.text drawWithRect:textRect
                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
             attributes:attributes
                context:nil];
    
    UIGraphicsPopContext();
}

@end
