//
//  Indicators.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "IndicatorsViewController.h"
#import <TelerikUI/TelerikUI.h>
#import "OptionInfo.h"
#import "StockDataPoint.h"
#import "IndicatorsTableView.h"

@implementation IndicatorsViewController
{
    TKChart *_overlayChart;
    TKChart *_indicatorsChart;
    TKChartCandlestickSeries *_series;
    NSArray *_options;
    NSArray *_data;
    IndicatorsTableView *_settings;
    BOOL _hasObservers;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _indicators = [[NSMutableArray alloc] init];
        _trendlines = [[NSMutableArray alloc] init];
        [self addTrendlineOption:@"Simple moving average" selector:@selector(addOverlayToChart:) tag:[TKChartSimpleMovingAverageIndicator class]];
        [self addTrendlineOption:@"Exponential moving average" selector:@selector(addOverlayToChart:) tag:[TKChartExponentialMovingAverageIndicator class]];
        [self addTrendlineOption:@"Weighted moving average" selector:@selector(addOverlayToChart:) tag:[TKChartWeightedMovingAverageIndicator class]];
        [self addTrendlineOption:@"Triangular moving average" selector:@selector(addOverlayToChart:) tag:[TKChartTriangularMovingAverageIndicator class]];
        [self addTrendlineOption:@"Bollinger bands indicator" selector:@selector(addOverlayToChart:) tag:[TKChartBollingerBandIndicator class]];
        [self addTrendlineOption:@"Moving average envelopes" selector:@selector(addOverlayToChart:) tag:[TKChartMovingAverageEnvelopesIndicator class]];
        [self addIndicatorOption:@"Percentage volume oscillator" selector:@selector(addIndicatorToChart:) tag:[TKChartPercentageVolumeOscillator class]];
        [self addIndicatorOption:@"Percentage price oscillator" selector:@selector(addIndicatorToChart:) tag:[TKChartPercentagePriceOscillator class]];
        [self addIndicatorOption:@"Absolute volume oscillator" selector:@selector(addIndicatorToChart:) tag:[TKChartAbsoluteVolumeOscillator class]];
        [self addIndicatorOption:@"MACD indicator" selector:@selector(addIndicatorToChart:) tag:[TKChartMACDIndicator class]];
        [self addIndicatorOption:@"RSI" selector:@selector(addIndicatorToChart:) tag:[TKChartRelativeStrengthIndex class]];
        [self addIndicatorOption:@"Accumulation distribution line" selector:@selector(addIndicatorToChart:) tag:[TKChartAccumulationDistributionLine class]];
        [self addIndicatorOption:@"True range" selector:@selector(addIndicatorToChart:) tag:[TKChartTrueRangeIndicator class]];
        [self addIndicatorOption:@"Average true range" selector:@selector(addIndicatorToChart:) tag:[TKChartAverageTrueRangeIndicator class]];
        [self addIndicatorOption:@"Commodity channel index" selector:@selector(addIndicatorToChart:) tag:[TKChartCommodityChannelIndex class]];
        [self addIndicatorOption:@"Fast stochastic indicator" selector:@selector(addIndicatorToChart:) tag:[TKChartFastStochasticIndicator class]];
        [self addIndicatorOption:@"Slow stochastic indicator" selector:@selector(addIndicatorToChart:) tag:[TKChartSlowStochasticIndicator class]];
        [self addIndicatorOption:@"Rate of change" selector:@selector(addIndicatorToChart:) tag:[TKChartRateOfChangeIndicator class]];
        [self addIndicatorOption:@"TRIX" selector:@selector(addIndicatorToChart:) tag:[TKChartTRIXIndicator class]];
        [self addIndicatorOption:@"Williams percent" selector:@selector(addIndicatorToChart:) tag:[TKChartWilliamsPercentIndicator class]];
        [self addTrendlineOption:@"Typical price" selector:@selector(addOverlayToChart:) tag:[TKChartTypicalPriceIndicator class]];
        [self addTrendlineOption:@"Weighted close" selector:@selector(addOverlayToChart:) tag:[TKChartWeightedCloseIndicator class]];
        [self addIndicatorOption:@"Ease of movement" selector:@selector(addIndicatorToChart:) tag:[TKChartEaseOfMovementIndicator class]];
        [self addTrendlineOption:@"Median price" selector:@selector(addOverlayToChart:) tag:[TKChartMedianPriceIndicator class]];
        [self addIndicatorOption:@"Detrended price oscillator" selector:@selector(addIndicatorToChart:) tag:[TKChartDetrendedPriceOscillator class]];
        [self addIndicatorOption:@"Force index" selector:@selector(addIndicatorToChart:) tag:[TKChartForceIndexIndicator class]];
        [self addIndicatorOption:@"Rapid adaptive variance" selector:@selector(addIndicatorToChart:) tag:[TKChartRapidAdaptiveVarianceIndicator class]];
        [self addTrendlineOption:@"Modified moving average" selector:@selector(addOverlayToChart:) tag:[TKChartModifiedMovingAverageIndicator class]];
        [self addTrendlineOption:@"Adaptive moving average" selector:@selector(addOverlayToChart:) tag:[TKChartAdaptiveMovingAverageIndicator class]];
        [self addIndicatorOption:@"Standard deviation" selector:@selector(addIndicatorToChart:) tag:[TKChartStandardDeviationIndicator class]];
        [self addIndicatorOption:@"Relative momentum index" selector:@selector(addIndicatorToChart:) tag:[TKChartRelativeMomentumIndex class]];
        [self addIndicatorOption:@"On balance volume" selector:@selector(addIndicatorToChart:) tag:[TKChartOnBalanceVolumeIndicator class]];
        [self addIndicatorOption:@"Price volume trend" selector:@selector(addIndicatorToChart:) tag:[TKChartPriceVolumeTrendIndicator class]];
        [self addIndicatorOption:@"Positive volume index" selector:@selector(addIndicatorToChart:) tag:[TKChartPositiveVolumeIndexIndicator class]];
        [self addIndicatorOption:@"Negative volume index" selector:@selector(addIndicatorToChart:) tag:[TKChartNegativeVolumeIndexIndicator class]];
        [self addIndicatorOption:@"Money flow index" selector:@selector(addIndicatorToChart:) tag:[TKChartMoneyFlowIndexIndicator class]];
        [self addIndicatorOption:@"Ultimate oscillator" selector:@selector(addIndicatorToChart:) tag:[TKChartUltimateOscillator class]];
        [self addIndicatorOption:@"Full stochastic indicator" selector:@selector(addIndicatorToChart:) tag:[TKChartFullStochasticIndicator class]];
        [self addIndicatorOption:@"Market facilitation index" selector:@selector(addIndicatorToChart:) tag:[TKChartMarketFacilitationIndex class]];
        [self addIndicatorOption:@"Chaikin oscillator" selector:@selector(addIndicatorToChart:) tag:[TKChartChaikinOscillator class]];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect exampleBounds = [self exampleBounds];
    CGRect overlayChartBounds = CGRectMake(exampleBounds.origin.x, exampleBounds.origin.y, exampleBounds.size.width, exampleBounds.size.height / 1.5);
    CGRect indicatorsChartBounds = CGRectMake(exampleBounds.origin.x, overlayChartBounds.size.height + 15, exampleBounds.size.width, exampleBounds.size.height / 3);
    
    _overlayChart = [[TKChart alloc] initWithFrame:overlayChartBounds];
    _overlayChart.gridStyle.verticalLinesHidden = NO;
    _overlayChart.autoresizingMask = ~UIViewAutoresizingNone;
    
    _indicatorsChart = [[TKChart alloc] initWithFrame:indicatorsChartBounds];
    _indicatorsChart.autoresizingMask = ~UIViewAutoresizingNone;
    [self.view addSubview:_overlayChart];
    [self.view addSubview:_indicatorsChart];

    _data = [StockDataPoint stockPoints];
    _settings = [[IndicatorsTableView alloc] init];
    _settings.example = self;
    
    _selectedIndicator = 0;
    _selectedTrendline = 0;
    _series = [[TKChartCandlestickSeries alloc] initWithItems:_data];
    _hasObservers = NO;
    
    [self loadCharts];
}

- (void)addTrendlineOption:(NSString *)text selector:(SEL)selector tag:(id)tag
{
    OptionInfo *option = [[OptionInfo alloc] initWithText:text selector:selector tag:tag];
    [_trendlines addObject:option];
    [super addOption:option];
}

- (void)addIndicatorOption:(NSString *)text selector:(SEL)selector tag:(id)tag
{
    OptionInfo *option = [[OptionInfo alloc] initWithText:text selector:selector tag:tag];
    [_indicators addObject:option];
    [super addOption:option];
}

- (void)addOverlayToChart:(OptionInfo *)option
{
    [_overlayChart removeAllData];
    [_overlayChart addSeries:_series];
    Class indicatorClass = option.tag;
    TKChartFinancialIndicator *indicator = [[indicatorClass alloc] initWithSeries:_series];
    indicator.selectionMode = TKChartSeriesSelectionModeSeries;
    [_overlayChart addSeries:indicator];
    [_overlayChart reloadData];
}

- (void)addIndicatorToChart:(OptionInfo *)option
{
    [_indicatorsChart removeAllData];
    Class indicatorClass = option.tag;
    TKChartFinancialIndicator *indicator = [[indicatorClass alloc] initWithSeries:_series];
    indicator.selectionMode = TKChartSeriesSelectionModeSeries;
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
    [_indicatorsChart reloadData];
}

- (void)settingsTouched
{
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (idiom == UIUserInterfaceIdiomPad) {
        if (self.popover && [self.popover isPopoverVisible]) {
            [self.popover dismissPopoverAnimated:YES];
            return;
        }
        
        if (!self.popover) {
            self.popover = [[UIPopoverController alloc] initWithContentViewController:_settings];
            CGRect settingsBounds = _settings.view.bounds;
            CGSize size = CGSizeMake(MIN(settingsBounds.size.width, settingsBounds.size.height) / 2.0, settingsBounds.size.height);
            self.popover.popoverContentSize = size;
        }
        
        [self.popover presentPopoverFromBarButtonItem:self.settingsButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else {
        [self.navigationController pushViewController:_settings animated:YES];
    }
}

- (void)loadCharts
{
    [_overlayChart removeAllData];
    [_indicatorsChart removeAllData];
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@250 andMaximum:@750];
    yAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignmentRight | TKChartAxisLabelAlignmentBottom;
    yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignmentRight | TKChartAxisLabelAlignmentTop;
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
    
    [_series.xAxis addObserver:self forKeyPath:@"zoom" options:NSKeyValueObservingOptionNew context:NULL];
    [_series.xAxis addObserver:self forKeyPath:@"pan" options:NSKeyValueObservingOptionNew context:NULL];
    
    OptionInfo *trendlineInfo = _trendlines[_selectedTrendline];
    IMP trendlineImp = [self methodForSelector:trendlineInfo.selector];
    void (*trendlineFunc)(id, SEL, OptionInfo *) = (void *)trendlineImp;
    trendlineFunc(self, trendlineInfo.selector, trendlineInfo);
    
    OptionInfo *indicatorInfo = _indicators[_selectedIndicator];
    IMP indicatorImp = [self methodForSelector:indicatorInfo.selector];
    void (*indicatorFunc)(id, SEL, OptionInfo *) = (void *)indicatorImp;
    indicatorFunc(self, indicatorInfo.selector, indicatorInfo);
}

- (void)removePanZoomObservers
{
    [_overlayChart.xAxis removeObserver:self forKeyPath:@"zoom"];
    [_overlayChart.xAxis removeObserver:self forKeyPath:@"pan"];
    _hasObservers = NO;
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
