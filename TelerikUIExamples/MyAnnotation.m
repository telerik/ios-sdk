//
//  MyAnnotation.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
{
    TKShape *_shape;
    CGPoint _center;
}

- (id)initWithShape:(TKShape*)shape X:(id)xValue Y:(id)yValue forSeries:(TKChartSeries *)series
{
    self = [super initWithX:xValue Y:yValue forSeries:series];
    if (self) {
        _shape = shape;
    }
    return self;
}

- (void)layoutInRect:(CGRect)bounds
{
    _center = [self locationInRect:bounds];
    _center.x -= _shape.size.width/2;
    _center.y -= _shape.size.height/2;
}

- (void)drawInContext:(CGContextRef)context
{
    NSMutableArray *drawables = [NSMutableArray new];
    if (_fill) {
        [drawables addObject:_fill];
    }
    if (_stroke) {
        [drawables addObject:_stroke];
    }
    [_shape drawInContext:context withCenter:_center drawings:drawables];
}


@end
