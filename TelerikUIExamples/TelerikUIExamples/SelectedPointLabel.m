//
//  SelectedPointLabel.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "SelectedPointLabel.h"

@implementation SelectedPointLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.needsDisplayOnBoundsChange = YES;
        self.contentsScale = [[UIScreen mainScreen] scale];
        self.drawsAsynchronously = YES;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    UIGraphicsPushContext(ctx);
    CGRect bounds = self.bounds;
    TKFill *fill = self.labelStyle.fill;
    TKStroke *stroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    TKBalloonShape *shape = [[TKBalloonShape alloc] initWithSize:CGSizeMake(bounds.size.width - stroke.width, bounds.size.height - stroke.width)];

    CGRect textRect;
    if (_isOutsideBounds) {
        shape.arrowPosition = TKBalloonShapeArrowPositionTop;
        textRect = CGRectMake(bounds.origin.x, bounds.origin.y - self.labelStyle.insets.top + shape.arrowSize.height,
                              bounds.size.width, bounds.size.height - self.labelStyle.insets.bottom);
    }
    else {
        shape.arrowPosition = TKBalloonShapeArrowPositionBottom;
        textRect = CGRectMake(bounds.origin.x, bounds.origin.y - self.labelStyle.insets.top,
                              bounds.size.width, bounds.size.height + self.labelStyle.insets.bottom);
    }
    
    [shape drawInContext:ctx withCenter:CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds)) drawings:@[fill, stroke]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = self.labelStyle.textAlignment;
    NSMutableDictionary *attributes = [@{ NSFontAttributeName: [UIFont systemFontOfSize:18],
                                          NSForegroundColorAttributeName: self.labelStyle.textColor,
                                          NSParagraphStyleAttributeName: paragraphStyle } mutableCopy];
    
    [self.text drawWithRect:textRect
                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                 attributes:attributes
                    context:nil];
    
    UIGraphicsPopContext();
}



@end
