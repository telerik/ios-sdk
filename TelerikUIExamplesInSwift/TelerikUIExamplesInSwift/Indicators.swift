//
//  IndicatorsViewController.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class Indicators : ExampleViewController, UIPopoverControllerDelegate {
    
    let trendlines = NSMutableArray()
    let indicators = NSMutableArray()
    let settings = IndicatorsTableView()
    let overlayChart = TKChart()
    let indicatorsChart = TKChart()
    let data = StockDataPoint.stockPoints() as! [TKChartDataPoint]

    var series: TKChartCandlestickSeries?
    var hasObservers: Bool = false
    var selectedTrendline = 0
    var selectedIndicator = 0

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        settings.example = self
        
        self.addTrendline("Simple moving average") { self.addOverlayToChart(TKChartSimpleMovingAverageIndicator(series:self.series)) }
        self.addTrendline("Exponential moving average") { self.addOverlayToChart(TKChartExponentialMovingAverageIndicator(series:self.series)) }
        self.addTrendline("Weighted moving average") { self.addOverlayToChart(TKChartWeightedMovingAverageIndicator(series:self.series)) }
        self.addTrendline("Triangular moving average") { self.addOverlayToChart(TKChartTriangularMovingAverageIndicator(series:self.series)) }
        self.addTrendline("Bollinger bands indicator") { self.addOverlayToChart(TKChartBollingerBandIndicator(series:self.series)) }
        self.addTrendline("Moving average envelopes") { self.addOverlayToChart(TKChartMovingAverageEnvelopesIndicator(series:self.series)) }
        self.addIndicator("Percentage volume oscillator") { self.addIndicatorToChart(TKChartPercentageVolumeOscillator(series:self.series)) }
        self.addIndicator("Percentage price oscillator") { self.addIndicatorToChart(TKChartPercentagePriceOscillator(series:self.series)) }
        self.addIndicator("Absolute volume oscillator") { self.addIndicatorToChart(TKChartAbsoluteVolumeOscillator(series:self.series)) }
        self.addIndicator("MACD indicator") { self.addIndicatorToChart(TKChartMACDIndicator(series:self.series)) }
        self.addIndicator("RSI") { self.addIndicatorToChart(TKChartRelativeStrengthIndex(series:self.series)) }
        self.addIndicator("Accumulation distribution line") { self.addIndicatorToChart(TKChartAccumulationDistributionLine(series:self.series)) }
        self.addIndicator("True range") { self.addIndicatorToChart(TKChartTrueRangeIndicator(series:self.series)) }
        self.addIndicator("Average true range") { self.addIndicatorToChart(TKChartAverageTrueRangeIndicator(series:self.series)) }
        self.addIndicator("Commodity channel index") { self.addIndicatorToChart(TKChartCommodityChannelIndex(series:self.series)) }
        self.addIndicator("Fast stochastic indicator") { self.addIndicatorToChart(TKChartFastStochasticIndicator(series:self.series)) }
        self.addIndicator("Slow stochastic indicator") { self.addIndicatorToChart(TKChartSlowStochasticIndicator(series:self.series)) }
        self.addIndicator("Rate of change") { self.addIndicatorToChart(TKChartRateOfChangeIndicator(series:self.series)) }
        self.addIndicator("TRIX") { self.addIndicatorToChart(TKChartTRIXIndicator(series:self.series)) }
        self.addIndicator("Williams percent") { self.addIndicatorToChart(TKChartWilliamsPercentIndicator(series:self.series)) }
        self.addTrendline("Typical price") { self.addOverlayToChart(TKChartTypicalPriceIndicator(series:self.series)) }
        self.addTrendline("Weighted close") { self.addOverlayToChart(TKChartWeightedCloseIndicator(series:self.series)) }
        self.addIndicator("Ease of movement") { self.addIndicatorToChart(TKChartEaseOfMovementIndicator(series:self.series)) }
        self.addTrendline("Median price") { self.addOverlayToChart(TKChartMedianPriceIndicator(series:self.series)) }
        self.addIndicator("Detrended price oscillator") { self.addIndicatorToChart(TKChartDetrendedPriceOscillator(series:self.series)) }
        self.addIndicator("Force index") { self.addIndicatorToChart(TKChartForceIndexIndicator(series:self.series)) }
        self.addIndicator("Rapid adaptive variance") { self.addIndicatorToChart(TKChartRapidAdaptiveVarianceIndicator(series:self.series)) }
        self.addTrendline("Modified moving average") { self.addOverlayToChart(TKChartModifiedMovingAverageIndicator(series:self.series)) }
        self.addTrendline("Adaptive moving average") { self.addOverlayToChart(TKChartAdaptiveMovingAverageIndicator(series:self.series)) }
        self.addIndicator("Standard deviation") { self.addIndicatorToChart(TKChartStandardDeviationIndicator(series:self.series)) }
        self.addIndicator("Relative momentum index") { self.addIndicatorToChart(TKChartRelativeMomentumIndex(series:self.series)) }
        self.addIndicator("On balance volume") { self.addIndicatorToChart(TKChartOnBalanceVolumeIndicator(series:self.series)) }
        self.addIndicator("Price volume trend") { self.addIndicatorToChart(TKChartPriceVolumeTrendIndicator(series:self.series)) }
        self.addIndicator("Positive volume index") { self.addIndicatorToChart(TKChartPositiveVolumeIndexIndicator(series:self.series)) }
        self.addIndicator("Negative volume index") { self.addIndicatorToChart(TKChartNegativeVolumeIndexIndicator(series:self.series)) }
        self.addIndicator("Money flow index") { self.addIndicatorToChart(TKChartMoneyFlowIndexIndicator(series:self.series)) }
        self.addIndicator("Ultimate oscillator") { self.addIndicatorToChart(TKChartUltimateOscillator(series:self.series)) }
        self.addIndicator("Full stochastic indicator") { self.addIndicatorToChart(TKChartFullStochasticIndicator(series:self.series)) }
        self.addIndicator("Market facilitation index") { self.addIndicatorToChart(TKChartMarketFacilitationIndex(series:self.series)) }
        self.addIndicator("Chaikin oscillator") { self.addIndicatorToChart(TKChartChaikinOscillator(series:self.series)) }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exampleBounds = self.exampleBoundsWithInset;
        
        overlayChart.frame = CGRectMake(exampleBounds.origin.x, exampleBounds.origin.y, exampleBounds.size.width, exampleBounds.size.height / 1.5)
        overlayChart.gridStyle().verticalLinesHidden = false
        overlayChart.autoresizingMask = ~UIViewAutoresizing.None
        self.view.addSubview(overlayChart)
        
        let indicatorsOffset = exampleBounds.origin.y + overlayChart.bounds.size.height + 15
        indicatorsChart.frame = CGRectMake(exampleBounds.origin.x, indicatorsOffset, exampleBounds.size.width, self.view.bounds.size.height - indicatorsOffset)
        indicatorsChart.autoresizingMask = ~UIViewAutoresizing.None
        self.view.addSubview(indicatorsChart)
        
        series = TKChartCandlestickSeries(items: data)
        
        self.loadCharts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTrendline(text:String, selector: Optional<() -> ()>) {
        super.addOption(text, selector: selector)
        let option = self.options[self.options.count-1] as! OptionInfo
        self.trendlines.addObject(option)
    }
    
    func addIndicator(text:String, selector: Optional<() -> ()>) {
        super.addOption(text, selector: selector)
        let option = self.options[self.options.count-1] as! OptionInfo
        self.indicators.addObject(option)
    }
    
    func loadCharts() {
        overlayChart.removeAllData()
        indicatorsChart.removeAllData()
        
        let yAxis = TKChartNumericAxis(minimum: 250, andMaximum: 750)
        yAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignment.Right | TKChartAxisLabelAlignment.Bottom
        yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignment.Right | TKChartAxisLabelAlignment.Top
        yAxis.allowZoom = true
        series!.yAxis = yAxis
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        let minDate = formatter.dateFromString("01/01/2011")
        let maxDate = formatter.dateFromString("01/01/2013")
        let xAxis = TKChartDateTimeAxis(minimumDate: minDate, andMaximumDate: maxDate)
        xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days
        xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Years
        xAxis.majorTickInterval = 1
        xAxis.style.majorTickStyle.ticksHidden = false
        xAxis.style.majorTickStyle.ticksOffset = -3
        xAxis.style.majorTickStyle.ticksWidth = 1.5
        xAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingMode.Visible
        xAxis.style.majorTickStyle.ticksFill = TKSolidFill(color: UIColor(red: 203.0/255.0, green: 203.0/255.0, blue: 203.0/255.0, alpha: 1.0))
        xAxis.allowZoom = true
        series!.xAxis = xAxis
        
        series!.xAxis.addObserver(self, forKeyPath: "zoom", options: NSKeyValueObservingOptions.New, context: nil)
        series!.xAxis.addObserver(self, forKeyPath: "pan", options: NSKeyValueObservingOptions.New, context: nil)
        
        let trendlineInfo = trendlines[selectedTrendline] as! OptionInfo
        trendlineInfo.selector!()
        
        let indicatorInfo = indicators[selectedIndicator] as! OptionInfo
        indicatorInfo.selector!()
    }
    
//MARK: - Events
    
    func addOverlayToChart(indicator: TKChartSeries) {
        overlayChart.removeAllData()
        overlayChart.addSeries(self.series)
        indicator.selectionMode = TKChartSeriesSelectionMode.Series
        overlayChart.addSeries(indicator)
    }
    
    func addIndicatorToChart(indicator: TKChartSeries) {
        indicatorsChart.removeAllData()
        indicator.selectionMode = TKChartSeriesSelectionMode.Series
        indicatorsChart.addSeries(indicator)
        let yAxis = indicatorsChart.yAxis as! TKChartNumericAxis
        var max = ceil(yAxis.range.maximum.floatValue)
        var min = floor(yAxis.range.minimum.floatValue)
        if (max < 0) {
            max *= -1
            min *= -1
        }
        yAxis.range.minimum = min;
        yAxis.range.maximum = max;
        yAxis.majorTickInterval = (max - min) / 2.0;
        yAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignment.Right|TKChartAxisLabelAlignment.Bottom
        yAxis.style.lineHidden = false
        
        let xAxis = indicatorsChart.xAxis as! TKChartDateTimeAxis
        xAxis.range = series!.xAxis.range
        xAxis.style.labelStyle.textHidden = true
        xAxis.zoom = overlayChart.xAxis.zoom
        xAxis.pan = overlayChart.xAxis.pan
        xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Years
        xAxis.majorTickInterval = 1
    }
    
    override func settingsTouched() {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            if let popover = self.popover {
                if popover.popoverVisible {
                    return
                }
            }
            if (self.popover == nil) {
                self.popover = UIPopoverController(contentViewController: settings)
                let settingsBounds = settings.view.bounds;
                self.popover!.popoverContentSize = CGSizeMake(min(settingsBounds.width, settingsBounds.height) / 2.0, settingsBounds.height)
            }
            
            self.popover!.presentPopoverFromBarButtonItem(self.settingsButton!, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
        }
        else {
            self.navigationController?.pushViewController(settings, animated: true)
        }
    }
    
    func removePanZoomObservers() {
        overlayChart.xAxis.removeObserver(self, forKeyPath: "zoom")
        overlayChart.xAxis.removeObserver(self, forKeyPath: "pan")
        hasObservers = false
    }

    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "zoom" {
            self.indicatorsChart.xAxis.zoom = overlayChart.xAxis.zoom
        }
        else {
            indicatorsChart.xAxis.pan = overlayChart.xAxis.pan
        }
    }
}

