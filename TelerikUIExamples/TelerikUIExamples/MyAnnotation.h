//
//  MyAnnotation.h
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>

@interface MyAnnotation : TKChartPointAnnotation

- (id)initWithShape:(TKShape*)shape X:(id)xValue Y:(id)yValue forSeries:(TKChartSeries *)series;

@property (nonatomic,strong) TKFill *fill;
@property (nonatomic,strong) TKStroke *stroke;

@end
