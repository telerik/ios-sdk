//
//  ChartDocsGridCustomization.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsGridCustomization.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsGridCustomization
{
    TKChart *chart;
}
- (void) viewDidLoad{
    [super viewDidLoad];
    
    chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:chart];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<7; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:@(i+1) Y:@(arc4random() % 100)]];
    }
    
    TKChartLineSeries *lineSeries = [[TKChartLineSeries alloc] initWithItems:array];
    [chart addSeries:lineSeries];
    
}

- (void) zPosition
{
    // >> chart-grid-z
    TKChartGridStyle* gridStyle = chart.gridStyle;
    
    gridStyle.horizontalLineStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.horizontalLineAlternateStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.horizontalLinesHidden = NO;
    gridStyle.horizontalFill = [TKSolidFill solidFillWithColor:[UIColor colorWithWhite:228.f/255.f alpha:0.7f]];
    gridStyle.horizontalAlternateFill = [TKSolidFill solidFillWithColor:[UIColor clearColor]];
    
    gridStyle.verticalFill = nil;
    gridStyle.verticalAlternateFill = nil;
    gridStyle.verticalLinesHidden = YES;
    
    gridStyle.zPosition = TKChartGridZPositionAboveSeries;
    // << chart-grid-z
}

- (void) combindingItAltogether
{
    // >> chart-grid-combining
    TKChartGridStyle* gridStyle = chart.gridStyle;
    
    gridStyle.horizontalLineStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.horizontalLineAlternateStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.horizontalFill = [TKSolidFill solidFillWithColor:[UIColor colorWithWhite:228.f/255.f alpha:1.f]];
    gridStyle.horizontalAlternateFill = [TKSolidFill solidFillWithColor:[UIColor whiteColor]];
    gridStyle.horizontalLinesHidden = NO;
    
    gridStyle.verticalLineStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.verticalLineAlternateStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.verticalLinesHidden = NO;
    gridStyle.verticalFill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:1.f green:1.f blue:0.f alpha:0.1f]];
    gridStyle.verticalAlternateFill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:0.f green:1.f blue:0.f alpha:0.1f]];
    // << chart-grid-combining
    
    // >> chart-grid-first
    gridStyle.drawOrder = TKChartGridDrawModeVerticalFirst;
    // << chart-grid-first
    
    // >> chart-grid-bg-fill
    gridStyle.backgroundFill = [TKSolidFill solidFillWithColor:[UIColor whiteColor]];
    // << chart-grid-bg-fill
    
    // >> chart-grid-img-fill
    gridStyle.backgroundFill = [TKSolidFill solidFillWithColor:
                                [UIColor colorWithPatternImage:[UIImage imageNamed:@"telerik_logo"]]];
    // << chart-grid-img-fill
    
}

- (void) colorfulGridLines
{
    // >> chart-grid-colorful
    TKChartGridStyle* gridStyle = chart.gridStyle;
    gridStyle.verticalLineStroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    gridStyle.verticalLineAlternateStroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    gridStyle.verticalLinesHidden = NO;
    gridStyle.verticalFill = nil;
    gridStyle.verticalAlternateFill = nil;
    
    gridStyle.horizontalLineStroke = [TKStroke strokeWithColor:[UIColor redColor]];
    gridStyle.horizontalLineAlternateStroke = [TKStroke strokeWithColor:[UIColor blueColor]];
    gridStyle.horizontalFill = nil;
    gridStyle.horizontalAlternateFill = nil;
    gridStyle.horizontalLinesHidden = NO;
    // << chart-grid-colorful
}

- (void) verticalAlternativeFills
{
    // >> chart-grid-alternate-vertical
    TKChartGridStyle* gridStyle = chart.gridStyle;
    
    gridStyle.verticalLineStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.verticalLineAlternateStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.verticalLinesHidden = NO;
    gridStyle.verticalFill = [TKSolidFill solidFillWithColor:[UIColor colorWithWhite:228.f/255.f alpha:1.f]];
    gridStyle.verticalAlternateFill = [TKSolidFill solidFillWithColor:[UIColor whiteColor]];
    
    gridStyle.horizontalFill = nil;
    gridStyle.horizontalAlternateFill = nil;
    gridStyle.horizontalLinesHidden = YES;
    // << chart-grid-alternate-vertical
}

- (void) removeVerticalLines
{
    // >> chart-grid-remove-vertical
    TKChartGridStyle* gridStyle = chart.gridStyle;
    
    gridStyle.verticalLinesHidden = YES;
    gridStyle.verticalFill = nil;
    gridStyle.verticalAlternateFill = nil;
    
    gridStyle.horizontalLineStroke = [TKStroke strokeWithColor:[UIColor redColor]];
    gridStyle.horizontalLineAlternateStroke = [TKStroke strokeWithColor:[UIColor blueColor]];
    gridStyle.horizontalFill = nil;
    gridStyle.horizontalAlternateFill = nil;
    gridStyle.horizontalLinesHidden = NO;
    // << chart-grid-remove-vertical
}

- (void) alternativeFills
{
    // >> chart-grid-alternate-horizontal
    TKChartGridStyle* gridStyle = chart.gridStyle;
    
    gridStyle.horizontalLineStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.horizontalLineAlternateStroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:215.f/255.f alpha:1.f]];
    gridStyle.horizontalLinesHidden = NO;
    gridStyle.horizontalFill = [TKSolidFill solidFillWithColor:[UIColor colorWithWhite:228.f/255.f alpha:1.f]];
    gridStyle.horizontalAlternateFill = [TKSolidFill solidFillWithColor:[UIColor whiteColor]];
    
    gridStyle.verticalFill = nil;
    gridStyle.verticalAlternateFill = nil;
    gridStyle.verticalLinesHidden = YES;
    // << chart-grid-alternate-horizontal
}


@end
