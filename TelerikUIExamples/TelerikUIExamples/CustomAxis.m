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

// >> chart-custom-axis-render
@implementation MyAxis

- (TKChartAxisRender *)renderForChart:(TKChart *)chart
{
    return [[AxisRender alloc] initWithAxis:self chart:chart];
}

@end
// << chart-custom-axis-render

@implementation CustomAxis
{
    TKChart* _chart;
    NSArray *_names;
    NSArray *_offsets;
    NSArray *_strokes;
    NSArray *_fills;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Custom Labels" selector:@selector(customLabelsSelected)];
        [self addOption:@"Custom Axis Drawing" selector:@selector(customAxisDrawingSelected)];
        
        _names = @[ @"Upper class", @"Upper middle class", @"Middle class", @"Lower middle class" ];
        _offsets = @[ @350, @250, @150, @100 ];
        _strokes = @[ [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5],
                              [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.6],
                              [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6],
                              [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6]
                              ];
        _fills = @[ @[ [UIColor colorWithRed:0.78 green:0.81 blue:0.86 alpha:0.5], [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5] ],
                            @[ [UIColor colorWithRed:0.78 green:0.76 blue:0.70 alpha:1.0], [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5] ],
                            @[ [UIColor colorWithRed:0.80 green:0.73 blue:0.67 alpha:1.0], [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5] ],
                            @[ [UIColor colorWithRed:0.70 green:0.58 blue:0.58 alpha:1.0], [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5] ]
                            ];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _chart.legend.hidden = NO;
    [self.view addSubview:_chart];
    
    [self customLabelsSelected];
}

-(void) customAxisDrawingSelected {
    
    [_chart removeAllData];
    
    MyAxis *yAxis = [[MyAxis alloc] initWithMinimum:@100 andMaximum:@450];
    _chart.yAxis = yAxis;
    
    for (int i = 0; i<_names.count; i++) {
        NSMutableArray *items = [NSMutableArray new];
        for (int j = 0; j<5; j++) {
            NSDate *date = [self dateWithYear:j + 2002 month:1 day:1];
            TKChartDataPoint *point = [[TKChartDataPoint alloc] initWithX:date Y:@(arc4random_uniform(50) + [_offsets[i] integerValue])];
            [items addObject:point];
        }
        TKChartSplineAreaSeries* series = [[TKChartSplineAreaSeries alloc] initWithItems:items];
        series.title  = _names[i];
        // >> chart-style-fill
        series.style.palette = [[TKChartPalette alloc] init];
        TKChartPaletteItem *palleteItem = [[TKChartPaletteItem alloc] init];
        palleteItem.stroke = [TKStroke strokeWithColor:_strokes[i] width:1.5];
        palleteItem.fill = [[TKLinearGradientFill alloc] initWithColors:_fills[i]];
        [series.style.palette addPaletteItem:palleteItem];
        // << chart-style-fill
        [_chart addSeries:series];
    }
}

-(void) customLabelsSelected {
    
    [_chart removeAllData];
    
    for (int i = 0; i<_names.count; i++) {
        NSMutableArray *items = [NSMutableArray new];
        for (int j = 0; j<5; j++) {
            NSDate *date = [self dateWithYear:j + 2002 month:1 day:1];
            TKChartDataPoint *point = [[TKChartDataPoint alloc] initWithX:date Y:@(arc4random_uniform(50) + [_offsets[i] integerValue])];
            [items addObject:point];
        }
        TKChartSplineAreaSeries* series = [[TKChartSplineAreaSeries alloc] initWithItems:items];
        series.title  = _names[i];
        [_chart addSeries:series];
    }
    
    _chart.yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@0 andMaximum:@400];
    
    // >> chart-custom-axis-labels
    _chart.yAxis.customLabels = @{
                                  @100 :[UIColor blueColor],
                                  @200 : [UIColor colorWithRed:1.00 green:0.89 blue:0.20 alpha:1.0],
                                  @400: [UIColor colorWithRed:0.00 green:0.90 blue:0.42 alpha:1.0]};
    // << chart-custom-axis-labels
    
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
