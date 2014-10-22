//
//  PointLabelsViewController.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "PointLabels.h"

@interface PointLabels ()

@end

@implementation PointLabels
{
    TKChart *_chart;
    NSMutableArray *_columnData;
    NSMutableArray *_barData;
    NSMutableArray *_lineData;
    NSMutableArray *_pieDonutData;
    NSMutableArray *_ohlcData;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Bar Series" selector:@selector(barSeries)];
        [self addOption:@"Column Series" selector:@selector(columnSeries)];
        [self addOption:@"Line Series" selector:@selector(lineSeries)];
        [self addOption:@"Pie Series" selector:@selector(pieSeries)];
        [self addOption:@"Ohlc Series" selector:@selector(ohlcSeries)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _chart = [[TKChart alloc] initWithFrame:self.exampleBounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.delegate = self;
    _chart.allowAnimations = YES;
    [self.view addSubview:_chart];
    
    _columnData = [[NSMutableArray alloc] init];
    NSArray *categories = @[ @"Greetings", @"Perfecto", @"NearBy", @"Family Store", @"Fresh & Green" ];
    for (int i = 0; i < categories.count; i++) {
        TKChartDataPoint *point = [TKChartDataPoint dataPointWithX:categories[i] Y:@(arc4random() % 100)];
        [_columnData addObject:point];
    }
    
    _barData = [[NSMutableArray alloc] init];
    for (int i = 0; i < categories.count; i++) {
        TKChartDataPoint *point = [TKChartDataPoint dataPointWithX:@(arc4random() % 100) Y:categories[i]];
        [_barData addObject:point];
    }
    
    NSArray *lineValues = @[@82, @68, @83, @46, @32, @75, @8, @54, @47, @51];
    _lineData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        TKChartDataPoint *point = [TKChartDataPoint dataPointWithX:@(i) Y:lineValues[i]];
        [_lineData addObject:point];
    }
    
    _pieDonutData = [[NSMutableArray alloc] init];
    [_pieDonutData addObject:[[TKChartDataPoint alloc] initWithValue:@20 name:@"Google"]];
    [_pieDonutData addObject:[[TKChartDataPoint alloc] initWithValue:@30 name:@"Apple"]];
    [_pieDonutData addObject:[[TKChartDataPoint alloc] initWithValue:@10 name:@"Microsoft"]];
    [_pieDonutData addObject:[[TKChartDataPoint alloc] initWithValue:@5 name:@"IBM"]];
    [_pieDonutData addObject:[[TKChartDataPoint alloc] initWithValue:@8 name:@"Oracle"]];
    
    NSArray *openPrices = @[@100, @125, @69, @99, @140, @125];
    NSArray *closePrices = @[@85, @65, @135, @120, @80, @136];
    NSArray *lowPrices = @[@50, @60, @65, @55, @75, @90];
    NSArray *highPrices = @[@129, @142, @141, @123, @150, @161];
    NSDate *dateNow = [NSDate date];
    _ohlcData = [[NSMutableArray alloc] init];
    for (int i = 0; i < openPrices.count; i++) {
        NSDate *date = [dateNow dateByAddingTimeInterval:60 * 60 * 24 * i];
        TKChartFinancialDataPoint *dataPoint = [TKChartFinancialDataPoint dataPointWithX:date open:openPrices[i] high:highPrices[i] low:lowPrices[i] close:closePrices[i]];
        [_ohlcData addObject:dataPoint];
    }
    
    [self barSeries];
}

- (void)barSeries
{
    [_chart removeAllData];
    TKChartBarSeries *barSeries = [[TKChartBarSeries alloc] initWithItems:_barData];
    barSeries.style.pointLabelStyle.textHidden = NO;
    barSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(15, 0);
    
    [_chart addSeries:barSeries];
    [_chart reloadData];
}

- (void)columnSeries
{
    [_chart removeAllData];
    TKChartColumnSeries *columnSeries = [[TKChartColumnSeries alloc] initWithItems:_columnData];
    columnSeries.style.pointLabelStyle.textHidden = NO;
    columnSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -15);
    
    [_chart addSeries:columnSeries];
    [_chart reloadData];
}

- (void)lineSeries
{
    [_chart removeAllData];
    TKChartLineSeries *lineSeries = [[TKChartLineSeries alloc] initWithItems:_lineData];
    lineSeries.style.pointLabelStyle.textHidden = NO;
    lineSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, 15);
    lineSeries.style.pointLabelStyle.font = [UIFont systemFontOfSize:9];
    
    [_chart addSeries:lineSeries];
    [_chart reloadData];
}

- (void)pieSeries
{
    [_chart removeAllData];
    TKChartPieSeries *pieSeries = [[TKChartPieSeries alloc] initWithItems:_pieDonutData];
    pieSeries.style.pointLabelStyle.textHidden = NO;
    pieSeries.style.pointLabelStyle.textColor = [UIColor whiteColor];
    pieSeries.labelDisplayMode = TKChartPieSeriesLabelDisplayModeInside;
    
    [_chart addSeries:pieSeries];
    [_chart reloadData];
    
}

- (void)ohlcSeries
{
    [_chart removeAllData];
    TKChartOhlcSeries *ohlcSeries = [[TKChartOhlcSeries alloc] initWithItems:_ohlcData];
    ohlcSeries.style.pointLabelStyle.textHidden = NO;
    ohlcSeries.style.pointLabelStyle.labelOffset = UIOffsetMake(0, -40);
    ohlcSeries.style.pointLabelStyle.textAlignment = NSTextAlignmentJustified;
    
    [_chart addSeries:ohlcSeries];
    TKChartDateTimeAxis *xAxis = (TKChartDateTimeAxis *)_chart.xAxis;
    xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitDays;
    xAxis.majorTickInterval = 1;
    xAxis.plotMode = TKChartAxisPlotModeBetweenTicks;
    
    [_chart reloadData];
}

- (NSString *)chart:(TKChart *)chart textForLabelAtPoint:(id<TKChartData>)dataPoint inSeries:(TKChartSeries *)series atIndex:(NSUInteger)dataIndex
{
    if ([series isKindOfClass:TKChartPieSeries.class]) {
        return dataPoint.dataName;
    }
    else if ([series isKindOfClass:TKChartBarSeries.class]) {
        return [NSString stringWithFormat:@"%@", dataPoint.dataXValue];
    }
    else if ([series isKindOfClass:TKChartOhlcSeries.class]) {
        return [NSString stringWithFormat:@"O:%@\nH:%@\nL:%@\nC:%@", dataPoint.open, dataPoint.high, dataPoint.low, dataPoint.close];
    }
    
    return [NSString stringWithFormat:@"%@", dataPoint.dataYValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
