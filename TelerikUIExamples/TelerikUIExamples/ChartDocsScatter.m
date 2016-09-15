//
//  ChartDocsScatter.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsScatter.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsScatter
{
    NSMutableArray *scatterPoints;
    TKChart *chart;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *xValues = @[ @460, @510, @600, @640, @700, @760, @800, @890, @920, @1000, @1060, @1120, @1200, @1342, @1440];
    NSArray *yValues = @[ @7, @9, @12, @17, @19, @25, @32, @42, @50, @16, @56, @77, @24, @80, @90 ];
    scatterPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i<xValues.count; i++) {
        [scatterPoints addObject:[[TKChartDataPoint alloc] initWithX:xValues[i] Y:yValues[i]]];
    }
    //    [self selection];
}

- (void) selection
{
    // >> chart-scatter-selection
    TKChartScatterSeries *series = [[TKChartScatterSeries alloc] initWithItems:scatterPoints];
    series.selection = TKChartSeriesSelectionDataPoint;
    series.marginForHitDetection = 30.f;
    [chart addSeries:series];
    // << chart-scatter-selection
}

- (void) visualAppearance
{
    // >> chart-scatter-visual
    TKChartScatterSeries *series = [[TKChartScatterSeries alloc] initWithItems:scatterPoints];
    TKChartPaletteItem *palleteItem = [[TKChartPaletteItem alloc] init];
    palleteItem.fill = [TKSolidFill solidFillWithColor:[UIColor redColor]];
    series.style.palette = [[TKChartPalette alloc] init];
    [series.style.palette addPaletteItem:palleteItem];
    [chart addSeries:series];
    // << chart-scatter-visual
}

- (void) scatterSeries
{
    TKChartScatterSeries *series = [[TKChartScatterSeries alloc] initWithItems:scatterPoints];
    [chart addSeries:series];
}

@end
