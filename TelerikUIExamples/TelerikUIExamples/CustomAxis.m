//
//  CustomAxis.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 г. Telerik. All rights reserved.
//

#import "CustomAxis.h"
#import <TelerikUI/TelerikUI.h>
#import "AxisRender.h"

@interface MyAxis : TKChartNumericAxis

@end

@implementation MyAxis

- (TKChartAxisRender *)renderForChart:(TKChart *)chart
{
    return [[AxisRender alloc] initWithAxis:self chart:chart];
}

@end

@implementation CustomAxis
{
    TKChart* _chart;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_chart];

    MyAxis *yAxis = [[MyAxis alloc] initWithMinimum:@100 andMaximum:@450];
    _chart.yAxis = yAxis;
    _chart.legend.hidden = NO;

    NSArray *names = @[ @"Upper class", @"Upper middle class", @"Middle class", @"Lower middle class" ];
    NSArray *offsets = @[ @350, @250, @150, @100 ];
    NSArray *strokes = @[ [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5],
                          [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.6],
                          [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6],
                          [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6]
                        ];
    NSArray *fills = @[ @[ [UIColor colorWithRed:0.78 green:0.81 blue:0.86 alpha:0.5], [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5] ],
                        @[ [UIColor colorWithRed:0.78 green:0.76 blue:0.70 alpha:1.0], [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5] ],
                        @[ [UIColor colorWithRed:0.80 green:0.73 blue:0.67 alpha:1.0], [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5] ],
                        @[ [UIColor colorWithRed:0.70 green:0.58 blue:0.58 alpha:1.0], [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5] ]
                      ];
    
    for (int i = 0; i<names.count; i++) {
        NSMutableArray *items = [NSMutableArray new];
        for (int j = 0; j<5; j++) {
            NSDate *date = [self dateWithYear:j + 2002 month:1 day:1];
            TKChartDataPoint *point = [[TKChartDataPoint alloc] initWithX:date Y:@(arc4random_uniform(50) + [offsets[i] integerValue])];
            [items addObject:point];
        }
        TKChartSplineAreaSeries* series = [[TKChartSplineAreaSeries alloc] initWithItems:items];
        series.title  = names[i];
        series.style.palette = [[TKChartPalette alloc] init];
        TKChartPaletteItem *palleteItem = [[TKChartPaletteItem alloc] init];
        palleteItem.stroke = [TKStroke strokeWithColor:strokes[i] width:1.5];
        palleteItem.fill = [[TKLinearGradientFill alloc] initWithColors:fills[i]];
        [series.style.palette addPaletteItem:palleteItem];
        [_chart addSeries:series];
    }
}
                                       
- (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

@end
