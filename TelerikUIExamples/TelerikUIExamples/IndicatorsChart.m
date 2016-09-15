//
//  IndicatorsChart.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "IndicatorsChart.h"
#import "StockDataPoint.h"

@interface IndicatorInfo : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) Class class;

@end

@implementation IndicatorInfo

- (instancetype)initWithTitle:(NSString*)title class:(Class)class
{
    self = [self init];
    if (self) {
        self.title = title;
        self.class = class;
    }
    return self;
}

@end

@implementation IndicatorsChart
{
    TKChart *_overlayChart;
    TKChart *_indicatorsChart;
    TKChartCandlestickSeries *_series;
    NSArray *_data;
    NSMutableArray *_trendlines;
    NSMutableArray *_indicators;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _trendlines = [NSMutableArray new];
        
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Simple moving average" class:[TKChartSimpleMovingAverageIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Exponential moving average" class:[TKChartExponentialMovingAverageIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Weighted moving average" class:[TKChartWeightedMovingAverageIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Triangular moving average" class:[TKChartTriangularMovingAverageIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Bollinger bands indicator" class:[TKChartBollingerBandIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Moving average envelopes" class:[TKChartMovingAverageEnvelopesIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Typical price" class:[TKChartTypicalPriceIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Weighted close" class:[TKChartWeightedCloseIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Median price" class:[TKChartMedianPriceIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Modified moving average" class:[TKChartModifiedMovingAverageIndicator class]]];
        [_trendlines addObject:[[IndicatorInfo alloc] initWithTitle:@"Adaptive moving average" class:[TKChartAdaptiveMovingAverageIndicator class]]];
        
        _indicators = [NSMutableArray new];
        
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Percentage volume oscillator" class:[TKChartPercentageVolumeOscillator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Percentage price oscillator" class: [TKChartPercentagePriceOscillator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Absolute volume oscillator" class: [TKChartAbsoluteVolumeOscillator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"MACD indicator" class: [TKChartMACDIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"RSI" class: [TKChartRelativeStrengthIndex class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Accumulation distribution line" class: [TKChartAccumulationDistributionLine class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"True range" class: [TKChartTrueRangeIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Average true range" class: [TKChartAverageTrueRangeIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Commodity channel index" class: [TKChartCommodityChannelIndex class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Fast stochastic indicator" class: [TKChartFastStochasticIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Slow stochastic indicator" class: [TKChartSlowStochasticIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Rate of change" class: [TKChartRateOfChangeIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"TRIX" class: [TKChartTRIXIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Williams percent" class: [TKChartWilliamsPercentIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Ease of movement" class: [TKChartEaseOfMovementIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Detrended price oscillator" class: [TKChartDetrendedPriceOscillator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Force index" class: [TKChartForceIndexIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Rapid adaptive variance" class: [TKChartRapidAdaptiveVarianceIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Standard deviation" class: [TKChartStandardDeviationIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Relative momentum index" class: [TKChartRelativeMomentumIndex class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"On balance volume" class: [TKChartOnBalanceVolumeIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Price volume trend" class: [TKChartPriceVolumeTrendIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Positive volume index" class: [TKChartPositiveVolumeIndexIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Negative volume index" class: [TKChartNegativeVolumeIndexIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Money flow index" class: [TKChartMoneyFlowIndexIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Ultimate oscillator" class: [TKChartUltimateOscillator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Full stochastic indicator" class: [TKChartFullStochasticIndicator class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Market facilitation index" class: [TKChartMarketFacilitationIndex class]]];
        [_indicators addObject:[[IndicatorInfo alloc] initWithTitle:@"Chaikin oscillator" class: [TKChartChaikinOscillator class]]];

        [_trendlines enumerateObjectsUsingBlock:^(IndicatorInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addOption:obj.title selector:@selector(addOverlayToChart) inSection:@"Trendlines"];
        }];
        
        [_indicators enumerateObjectsUsingBlock:^(IndicatorInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addOption:obj.title selector:@selector(addIndicatorToChart) inSection:@"Indicators"];
        }];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect exampleBounds = self.view.bounds;
    CGRect overlayChartBounds = CGRectMake(exampleBounds.origin.x, exampleBounds.origin.y,
                                           exampleBounds.size.width, exampleBounds.size.height / 1.5);
    CGFloat indicatorsOffset = exampleBounds.origin.y + overlayChartBounds.size.height + 15;
    CGRect indicatorsChartBounds = CGRectMake(exampleBounds.origin.x, indicatorsOffset,
                                              exampleBounds.size.width, self.view.bounds.size.height - indicatorsOffset);
    
    _overlayChart = [[TKChart alloc] initWithFrame:overlayChartBounds];
    _overlayChart.gridStyle.verticalLinesHidden = NO;
    _overlayChart.autoresizingMask = ~UIViewAutoresizingNone;
    
    _indicatorsChart = [[TKChart alloc] initWithFrame:indicatorsChartBounds];
    _indicatorsChart.autoresizingMask = ~UIViewAutoresizingNone;
    [self.view addSubview:_overlayChart];
    [self.view addSubview:_indicatorsChart];

    _data = [StockDataPoint stockPoints];
    
    _series = [[TKChartCandlestickSeries alloc] initWithItems:_data];
    
    [self loadCharts];
    
    [self addOverlayToChart];
    [self addIndicatorToChart];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_series.xAxis addObserver:self forKeyPath:@"zoom" options:NSKeyValueObservingOptionNew context:NULL];
    [_series.xAxis addObserver:self forKeyPath:@"pan" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removePanZoomObservers];
}

- (void)addOverlayToChart
{
    TKExamplesSectionInfo *section = self.sections[0];

    [_overlayChart removeAllData];
    [_overlayChart addSeries:_series];
    IndicatorInfo *info = _trendlines[section.selectedOption];
    TKChartFinancialIndicator *indicator = [[info.class alloc] initWithSeries:_series];
    indicator.selection = TKChartSeriesSelectionSeries;
    [_overlayChart addSeries:indicator];
}

- (void)addIndicatorToChart
{
    TKExamplesSectionInfo *section = self.sections[1];
    
    [_indicatorsChart removeAllData];
    IndicatorInfo *info = _indicators[section.selectedOption];
    TKChartFinancialIndicator *indicator = [[info.class alloc] initWithSeries:_series];
    indicator.selection = TKChartSeriesSelectionSeries;
    [_indicatorsChart addSeries:indicator];
    TKChartNumericAxis *yAxis = (TKChartNumericAxis *)_indicatorsChart.yAxis;
    
    NSInteger max = ceil([yAxis.range.maximum doubleValue]);
    NSInteger min = floor([yAxis.range.minimum doubleValue]);
    if (max < 0) {
        max *= -1;
        min *= -1;
    }
    
    yAxis.range.minimum = @(min);
    yAxis.range.maximum = @(max);
    yAxis.majorTickInterval = @((max - min) / 2.0);
    yAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignmentRight | TKChartAxisLabelAlignmentBottom;
    yAxis.style.lineHidden = NO;
    
    TKChartDateTimeAxis *xAxis = (TKChartDateTimeAxis *)_indicatorsChart.xAxis;
    xAxis.range = _series.xAxis.range;
    xAxis.style.labelStyle.textHidden = YES;
    xAxis.zoom = _overlayChart.xAxis.zoom;
    xAxis.pan = _overlayChart.xAxis.pan;
    xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitYears;
    xAxis.majorTickInterval = 1;
}

- (void)loadCharts
{
    [_overlayChart removeAllData];
    [_indicatorsChart removeAllData];
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@250 andMaximum:@750];
    
    // >> chart-text-align
    yAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignmentRight | TKChartAxisLabelAlignmentBottom;
    yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignmentRight | TKChartAxisLabelAlignmentTop;
    yAxis.style.labelStyle.textOffset = UIOffsetMake(0, 0);
    yAxis.style.labelStyle.firstLabelTextOffset = UIOffsetMake(0, 0);
    // << chart-text-align
    yAxis.allowZoom = YES;
    _series.yAxis = yAxis;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSDate *minDate = [formatter dateFromString:@"01/01/2011"];
    NSDate *maxDate = [formatter dateFromString:@"01/01/2013"];
    TKChartDateTimeAxis *xAxis = [[TKChartDateTimeAxis alloc] initWithMinimumDate:minDate andMaximumDate:maxDate];
    xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitDays;
    xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitYears;
    xAxis.majorTickInterval = 1;
    xAxis.style.majorTickStyle.ticksHidden = NO;
    xAxis.style.majorTickStyle.ticksOffset = -3;
    xAxis.style.majorTickStyle.ticksWidth = 1.5;
    xAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingModeVisible;
    xAxis.style.majorTickStyle.ticksFill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0]];
    xAxis.allowZoom = YES;
    _series.xAxis = xAxis;
    
//    [_series.xAxis addObserver:self forKeyPath:@"zoom" options:NSKeyValueObservingOptionNew context:NULL];
//    [_series.xAxis addObserver:self forKeyPath:@"pan" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)removePanZoomObservers
{
    [_overlayChart.xAxis removeObserver:self forKeyPath:@"zoom"];
    [_overlayChart.xAxis removeObserver:self forKeyPath:@"pan"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"zoom"]) {
        _indicatorsChart.xAxis.zoom = _overlayChart.xAxis.zoom;
    }
    else {
        _indicatorsChart.xAxis.pan = _overlayChart.xAxis.pan;
    }
}

@end
