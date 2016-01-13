//
//  IndicatorsChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class IndicatorsChart : TKExamplesExampleViewController, UIPopoverControllerDelegate {
    
    var trendlines = [(String, AnyClass)]()
    var indicators = [(String, AnyClass)]()
    let overlayChart = TKChart()
    let indicatorsChart = TKChart()
    let data = StockDataPoint.stockPoints()
    var series: TKChartCandlestickSeries?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.trendlines.append(("Simple moving average", TKChartSimpleMovingAverageIndicator.self))
        self.trendlines.append(("Exponential moving average", TKChartExponentialMovingAverageIndicator.self))
        self.trendlines.append(("Weighted moving average", TKChartWeightedMovingAverageIndicator.self))
        self.trendlines.append(("Triangular moving average", TKChartTriangularMovingAverageIndicator.self))
        self.trendlines.append(("Bollinger bands indicator", TKChartBollingerBandIndicator.self))
        self.trendlines.append(("Moving average envelopes", TKChartMovingAverageEnvelopesIndicator.self))
        self.trendlines.append(("Typical price", TKChartTypicalPriceIndicator.self))
        self.trendlines.append(("Weighted close", TKChartWeightedCloseIndicator.self))
        self.trendlines.append(("Median price", TKChartMedianPriceIndicator.self))
        self.trendlines.append(("Modified moving average", TKChartModifiedMovingAverageIndicator.self))
        self.trendlines.append(("Adaptive moving average", TKChartAdaptiveMovingAverageIndicator.self))
        
        self.indicators.append(("Percentage volume oscillator", TKChartPercentageVolumeOscillator.self))
        self.indicators.append(("Percentage price oscillator", TKChartPercentagePriceOscillator.self))
        self.indicators.append(("Absolute volume oscillator", TKChartAbsoluteVolumeOscillator.self))
        self.indicators.append(("MACD indicator", TKChartMACDIndicator.self))
        self.indicators.append(("RSI", TKChartRelativeStrengthIndex.self))
        self.indicators.append(("Accumulation distribution line", TKChartAccumulationDistributionLine.self))
        self.indicators.append(("True range", TKChartTrueRangeIndicator.self))
        self.indicators.append(("Average true range", TKChartAverageTrueRangeIndicator.self))
        self.indicators.append(("Commodity channel index", TKChartCommodityChannelIndex.self))
        self.indicators.append(("Fast stochastic indicator", TKChartFastStochasticIndicator.self))
        self.indicators.append(("Slow stochastic indicator", TKChartSlowStochasticIndicator.self))
        self.indicators.append(("Rate of change", TKChartRateOfChangeIndicator.self))
        self.indicators.append(("TRIX", TKChartTRIXIndicator.self))
        self.indicators.append(("Williams percent", TKChartWilliamsPercentIndicator.self))
        self.indicators.append(("Ease of movement", TKChartEaseOfMovementIndicator.self))
        self.indicators.append(("Detrended price oscillator", TKChartDetrendedPriceOscillator.self))
        self.indicators.append(("Force index", TKChartForceIndexIndicator.self))
        self.indicators.append(("Rapid adaptive variance", TKChartRapidAdaptiveVarianceIndicator.self))
        self.indicators.append(("Standard deviation", TKChartStandardDeviationIndicator.self))
        self.indicators.append(("Relative momentum index", TKChartRelativeMomentumIndex.self))
        self.indicators.append(("On balance volume", TKChartOnBalanceVolumeIndicator.self))
        self.indicators.append(("Price volume trend", TKChartPriceVolumeTrendIndicator.self))
        self.indicators.append(("Positive volume index", TKChartPositiveVolumeIndexIndicator.self))
        self.indicators.append(("Negative volume index", TKChartNegativeVolumeIndexIndicator.self))
        self.indicators.append(("Money flow index", TKChartMoneyFlowIndexIndicator.self))
        self.indicators.append(("Ultimate oscillator", TKChartUltimateOscillator.self))
        self.indicators.append(("Full stochastic indicator", TKChartFullStochasticIndicator.self))
        self.indicators.append(("Market facilitation index", TKChartMarketFacilitationIndex.self))
        self.indicators.append(("Chaikin oscillator", TKChartChaikinOscillator.self))
        
        for (title, _) in self.trendlines {
            self.addOption(title, selector: "addOverlayToChart", inSection: "Trendlines")
        }

        for (title, _) in self.indicators {
            self.addOption(title, selector: "addIndicatorToChart", inSection: "Indicators")
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exampleBounds = self.view.bounds;
        
        overlayChart.frame = CGRectMake(exampleBounds.origin.x, exampleBounds.origin.y, exampleBounds.size.width, exampleBounds.size.height / 1.5)
        overlayChart.gridStyle.verticalLinesHidden = false
        overlayChart.autoresizingMask = UIViewAutoresizing(rawValue: ~UIViewAutoresizing.None.rawValue)
        self.view.addSubview(overlayChart)
        
        let indicatorsOffset = exampleBounds.origin.y + overlayChart.bounds.size.height + 15
        indicatorsChart.frame = CGRectMake(exampleBounds.origin.x, indicatorsOffset, exampleBounds.size.width, self.view.bounds.size.height - indicatorsOffset)
        indicatorsChart.autoresizingMask = UIViewAutoresizing(rawValue: ~UIViewAutoresizing.None.rawValue)
        self.view.addSubview(indicatorsChart)
        
        series = TKChartCandlestickSeries(items: data)
        
        self.loadCharts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        super.didMoveToParentViewController(parent)
        if (parent == nil) {
            self.removePanZoomObservers()
        }
    }
    
    func loadCharts() {
        overlayChart.removeAllData()
        indicatorsChart.removeAllData()
        
        let yAxis = TKChartNumericAxis(minimum: 250, andMaximum: 750)
        yAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignment(rawValue:TKChartAxisLabelAlignment.Right.rawValue | TKChartAxisLabelAlignment.Bottom.rawValue)
        yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignment(rawValue:TKChartAxisLabelAlignment.Right.rawValue | TKChartAxisLabelAlignment.Top.rawValue)
        yAxis.allowZoom = true
        series!.yAxis = yAxis
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        let minDate = formatter.dateFromString("01/01/2011")!
        let maxDate = formatter.dateFromString("01/01/2013")!
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
        
        series!.xAxis!.addObserver(self, forKeyPath: "zoom", options: NSKeyValueObservingOptions.New, context: nil)
        series!.xAxis!.addObserver(self, forKeyPath: "pan", options: NSKeyValueObservingOptions.New, context: nil)
        
        self.addOverlayToChart()
        self.addIndicatorToChart()
    }
    
//MARK: - Events
    
    func addOverlayToChart() {
        let section = self.sections![0] as! TKExamplesSectionInfo
        let indicatorClass = self.trendlines[section.selectedOption].1 as! TKChartFinancialIndicator.Type
        let indicator = indicatorClass.init(series:self.series!)
        indicator.selectionMode = TKChartSeriesSelectionMode.Series

        overlayChart.removeAllData()
        overlayChart.addSeries(self.series!)
        overlayChart.addSeries(indicator)
    }
    
    func addIndicatorToChart() {
        let section = self.sections![1] as! TKExamplesSectionInfo
        let indicatorClass = self.indicators[section.selectedOption].1 as! TKChartFinancialIndicator.Type
        let indicator = indicatorClass.init(series:self.series!)
        indicator.selectionMode = TKChartSeriesSelectionMode.Series

        indicatorsChart.removeAllData()
        indicatorsChart.addSeries(indicator)

        let yAxis = indicatorsChart.yAxis as! TKChartNumericAxis!
        var max = ceil(yAxis.range.maximum!.floatValue)
        var min = floor(yAxis.range.minimum!.floatValue)
        if (max < 0) {
            max *= -1
            min *= -1
        }
        yAxis.range.minimum = min;
        yAxis.range.maximum = max;
        yAxis.majorTickInterval = (max - min) / 2.0;
        yAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignment(rawValue: TKChartAxisLabelAlignment.Right.rawValue | TKChartAxisLabelAlignment.Bottom.rawValue)
        yAxis.style.lineHidden = false
        
        let xAxis = indicatorsChart.xAxis as! TKChartDateTimeAxis
        xAxis.range = series!.xAxis!.range
        xAxis.style.labelStyle.textHidden = true
        xAxis.zoom = overlayChart.xAxis!.zoom
        xAxis.pan = overlayChart.xAxis!.pan
        xAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Years
        xAxis.majorTickInterval = 1
    }
    
    func removePanZoomObservers() {
        overlayChart.xAxis!.removeObserver(self, forKeyPath: "zoom")
        overlayChart.xAxis!.removeObserver(self, forKeyPath: "pan")
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "zoom" {
            self.indicatorsChart.xAxis!.zoom = overlayChart.xAxis!.zoom
        }
        else {
            indicatorsChart.xAxis!.pan = overlayChart.xAxis!.pan
        }
    }
}

