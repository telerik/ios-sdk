//
//  Customize.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "Customize.h"
#import <TelerikUI/TelerikUI.h>

@interface Customize() <TKChartDelegate>
@end

@implementation Customize
{
    TKChart *_chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.delegate = self;
    [self.view addSubview:_chart];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random() % 100)]];
        [array2 addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random() % 100)]];
    }
    
    TKChartColumnSeries *columnSeries = [[TKChartColumnSeries alloc] initWithItems:array];
    columnSeries.selection = TKChartSeriesSelectionSeries;
    [_chart addSeries:columnSeries];

    TKChartAreaSeries *areaSeries = [[TKChartAreaSeries alloc] initWithItems:array2];
    areaSeries.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeStar andSize:CGSizeMake(20, 20)];
    areaSeries.style.shapeMode = TKChartSeriesStyleShapeModeAlwaysShow;
    areaSeries.selection = TKChartSeriesSelectionSeries;
    [_chart addSeries:areaSeries];
    
    // >> chart-label-style
    _chart.yAxis.style.labelStyle.font = [UIFont systemFontOfSize:18];
    _chart.yAxis.style.labelStyle.textColor = [UIColor blackColor];
    // << chart-label-style
    
    // >> chart-customize-axis
    _chart.xAxis.style.labelStyle.font = [UIFont systemFontOfSize:18];
    // << chart-customize-axis
    
    _chart.xAxis.style.labelStyle.textColor = [UIColor blackColor];
    
    _chart.gridStyle.horizontalAlternateFill = [[TKSolidFill alloc] initWithColor:[UIColor colorWithWhite:0.9 alpha:0.8]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(TKChartPaletteItem *)chart:(TKChart *)chart paletteItemForSeries:(TKChartSeries *)series atIndex:(NSInteger)index
{
    TKChartPaletteItem *item = nil;
    
    if (series.index == 1) {
        NSArray *colors = @[[UIColor colorWithRed:0. green:1. blue:0. alpha:.4],
                            [UIColor colorWithRed:1. green:0. blue:0. alpha:.4],
                            [UIColor colorWithRed:0. green:0. blue:1. alpha:.4]];
        TKLinearGradientFill *gradient = [TKLinearGradientFill linearGradientFillWithColors:colors
                                                                                 startPoint:CGPointMake(0.5f, 0.0f)
                                                                                   endPoint:CGPointMake(0.5f, 1.0f)];
        item = [[TKChartPaletteItem alloc] initWithFill:gradient];
    }
    else {
        TKImageFill *image = [TKImageFill imageFillWithImage:[UIImage imageNamed:@"pattern1"] cornerRadius:5.0f];
        image.resizingMode = TKImageFillResizingModeTile;
        TKStroke *stroke = [TKStroke strokeWithColor:[UIColor blackColor] width:1.f cornerRadius:5.0f];
        stroke.dashPattern = @[@2, @2, @5, @2];
        item = [[TKChartPaletteItem alloc] initWithDrawables:@[image, stroke]];
    }
    
    return item;
}

@end
