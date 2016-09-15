//
//  ChartDocsLineSeries.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsLineSeries.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsLineSeries
{
    NSMutableArray *expensesData;
    NSMutableArray *incomesData;
    NSMutableArray *profitData;
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    expensesData = [[NSMutableArray alloc] init];
    incomesData = [[NSMutableArray alloc] init];
    profitData = [[NSMutableArray alloc] init];
   
    [self lineSeries];
    
    //chart
    [self visualAppearance];
}

- (void) lineSeries
{
    // >> chart-line
    NSArray *expensesValues = @[@60, @30, @50, @32, @31];
    NSArray *incomesValues = @[@70, @75, @58, @59, @88];
    NSArray *profitValues = @[@10, @45, @8, @27, @57];
    NSArray *categories = @[@"Greetings", @"Perfecto", @"NearBy", @"Family Store", @"Fresh & Green"];
    for (int i = 0; i < categories.count ; i++) {
        [expensesData addObject:[TKChartDataPoint dataPointWithX:categories[i] Y:expensesValues[i]]];
        [incomesData addObject:[TKChartDataPoint dataPointWithX:categories[i] Y:incomesValues[i]]];
        [profitData addObject:[TKChartDataPoint dataPointWithX:categories[i] Y:profitValues[i]]];
    }
    
    TKChartLineSeries* seriesForExpenses = [[TKChartLineSeries alloc] initWithItems:expensesData];
    seriesForExpenses.title = @"Expenses";
    [chart addSeries:seriesForExpenses];
    
    TKChartLineSeries* seriesForIncomes = [[TKChartLineSeries alloc] initWithItems:incomesData];
    seriesForIncomes.title = @"Incomes";
    [chart addSeries:seriesForIncomes];
    
    TKChartLineSeries* seriesForProfit = [[TKChartLineSeries alloc] initWithItems:profitData];
    seriesForProfit.title = @"Profit";
    [chart addSeries:seriesForProfit];
    // << chart-line
    
    chart.legend.hidden = NO;
}

- (void) input
{
    TKChartLineSeries* seriesForProfit = [[TKChartLineSeries alloc] initWithItems:profitData];
    seriesForProfit.selection = TKChartSeriesSelectionSeries;
    seriesForProfit.marginForHitDetection = 30.f;
    [chart addSeries:seriesForProfit];
}

- (void) visualAppearance
{
    // >> chart-line-series-stroke
    TKChartLineSeries *seriesForProfit = [[TKChartLineSeries alloc] initWithItems:profitData];
    seriesForProfit.style.palette = [[TKChartPalette alloc] init];
    TKChartPaletteItem *palleteItem = [[TKChartPaletteItem alloc] init];
    palleteItem.stroke = [TKStroke strokeWithColor:[UIColor greenColor]];
    [seriesForProfit.style.palette addPaletteItem:palleteItem];
    [chart addSeries:seriesForProfit];
    // << chart-line-series-stroke
}

@end
