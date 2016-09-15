using System;
using System.Drawing;
using System.Collections.Generic;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("IndicatorsChart")]
	public class IndicatorsChart: XamarinExampleViewController
	{
		TKChart overlayChart;
		TKChart indicatorsChart;
		TKChartSeries series;
		List<StockDataPoint> data;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Simple moving average", "Trendlines", () => AddTrendline (new TKChartSimpleMovingAverageIndicator (this.series)));
			this.AddOption ("Exponential moving average", "Trendlines", () => AddTrendline (new TKChartExponentialMovingAverageIndicator(this.series)));
			this.AddOption ("Weighted moving average", "Trendlines", () => AddTrendline (new TKChartWeightedMovingAverageIndicator(this.series)));
			this.AddOption ("Triangular moving average", "Trendlines", () => AddTrendline (new TKChartTriangularMovingAverageIndicator(this.series)));
			this.AddOption ("Bollinger bands indicator", "Trendlines", () => AddTrendline (new TKChartBollingerBandIndicator(this.series)));
			this.AddOption ("Moving average envelopes", "Trendlines", () => AddTrendline (new TKChartMovingAverageEnvelopesIndicator(this.series)));
			this.AddOption ("Typical price", "Trendlines", () => AddTrendline (new TKChartTypicalPriceIndicator(this.series)));
			this.AddOption ("Weighted close", "Trendlines", () => AddTrendline (new TKChartWeightedCloseIndicator(this.series)));
			this.AddOption ("Median price", "Trendlines", () => AddTrendline (new TKChartMedianPriceIndicator(this.series)));
			this.AddOption ("Modified moving average", "Trendlines", () => AddTrendline (new TKChartModifiedMovingAverageIndicator(this.series)));
			this.AddOption ("Adaptive moving average", "Trendlines", () => AddTrendline (new TKChartAdaptiveMovingAverageIndicator(this.series)));

			this.AddOption ("Percentage volume oscillator", "Indicators", () => AddIndicator (new TKChartPercentageVolumeOscillator (this.series)));
			this.AddOption ("Percentage price oscillator", "Indicators", () => AddIndicator (new TKChartPercentagePriceOscillator(this.series)));
			this.AddOption ("Absolute volume oscillator", "Indicators", () => AddIndicator (new TKChartAbsoluteVolumeOscillator(this.series)));
			this.AddOption ("MACD indicator", "Indicators", () => AddIndicator (new TKChartMACDIndicator(this.series)));
			this.AddOption ("RSI", "Indicators", () => AddIndicator (new TKChartRelativeStrengthIndex(this.series)));
			this.AddOption ("Accumulation distribution line", "Indicators", () => AddIndicator (new TKChartAccumulationDistributionLine(this.series)));
			this.AddOption ("True range", "Indicators", () => AddIndicator (new TKChartTrueRangeIndicator(this.series)));
			this.AddOption ("Average true range", "Indicators", () => AddIndicator (new TKChartAverageTrueRangeIndicator(this.series)));
			this.AddOption ("Commodity channel index", "Indicators", () => AddIndicator (new TKChartCommodityChannelIndex(this.series)));
			this.AddOption ("Fast stochastic indicator", "Indicators", () => AddIndicator (new TKChartFastStochasticIndicator(this.series)));
			this.AddOption ("Slow stochastic indicator", "Indicators", () => AddIndicator (new TKChartSlowStochasticIndicator(this.series)));
			this.AddOption ("Rate of change", "Indicators", () => AddIndicator (new TKChartRateOfChangeIndicator(this.series)));
			this.AddOption ("TRIX", "Indicators", () => AddIndicator (new TKChartTRIXIndicator(this.series)));
			this.AddOption ("Williams percent", "Indicators", () => AddIndicator (new TKChartWilliamsPercentIndicator(this.series)));
			this.AddOption ("Ease of movement", "Indicators", () => AddIndicator (new TKChartEaseOfMovementIndicator(this.series)));
			this.AddOption ("Detrended price oscillator", "Indicators", () => AddIndicator (new TKChartDetrendedPriceOscillator(this.series)));
			this.AddOption ("Force index", "Indicators", () => AddIndicator (new TKChartForceIndexIndicator(this.series)));
			this.AddOption ("Rapid adaptive variance", "Indicators", () => AddIndicator (new TKChartRapidAdaptiveVarianceIndicator(this.series)));
			this.AddOption ("Standard deviation", "Indicators", () => AddIndicator (new TKChartStandardDeviationIndicator(this.series)));
			this.AddOption ("Relative momentum index", "Indicators", () => AddIndicator (new TKChartRelativeMomentumIndex(this.series)));
			this.AddOption ("On balance volume", "Indicators", () => AddIndicator (new TKChartOnBalanceVolumeIndicator(this.series)));
			this.AddOption ("Price volume trend", "Indicators", () => AddIndicator (new TKChartPriceVolumeTrendIndicator(this.series)));
			this.AddOption ("Positive volume index", "Indicators", () => AddIndicator (new TKChartPositiveVolumeIndexIndicator(this.series)));
			this.AddOption ("Negative volume index", "Indicators", () => AddIndicator (new TKChartNegativeVolumeIndexIndicator(this.series)));
			this.AddOption ("Money flow index", "Indicators", () => AddIndicator (new TKChartMoneyFlowIndexIndicator(this.series)));
			this.AddOption ("Ultimate oscillator", "Indicators", () => AddIndicator (new TKChartUltimateOscillator(this.series)));
			this.AddOption ("Full stochastic indicator", "Indicators", () => AddIndicator (new TKChartFullStochasticIndicator(this.series)));
			this.AddOption ("Market facilitation index", "Indicators", () => AddIndicator (new TKChartMarketFacilitationIndex(this.series)));
			this.AddOption ("Chaikin oscillator", "Indicators", () => AddIndicator (new TKChartChaikinOscillator(this.series)));

			base.ViewDidLoad ();

			CGRect exampleBounds = this.View.Bounds;
			CGRect overlayChartBounds = new CGRect (exampleBounds.X, exampleBounds.Y, exampleBounds.Width, exampleBounds.Height/1.5f);
			nfloat indicatorsOffset = exampleBounds.Y + overlayChartBounds.Height + 15;
			CGRect indicatorsChartBounds = new CGRect (exampleBounds.X, indicatorsOffset, exampleBounds.Width, exampleBounds.Height - indicatorsOffset);

			overlayChart = new TKChart (overlayChartBounds);
			overlayChart.GridStyle.VerticalLinesHidden = false;
			overlayChart.AutoresizingMask = ~UIViewAutoresizing.None;
			this.View.AddSubview (overlayChart);

			indicatorsChart = new TKChart (indicatorsChartBounds);
			indicatorsChart.AutoresizingMask = ~UIViewAutoresizing.None;
			this.View.AddSubview (indicatorsChart);

			data = StockDataPoint.LoadStockPoints(-1);
			series = new TKChartCandlestickSeries (data.ToArray ());

			this.loadCharts ();
		}

		void AddTrendline(TKChartFinancialIndicator indicator)
		{
			indicator.SelectionMode = TKChartSeriesSelectionMode.Series;
			overlayChart.RemoveAllData ();
			overlayChart.AddSeries (series);
			overlayChart.AddSeries (indicator);
		}

		void AddIndicator(TKChartFinancialIndicator indicator)
		{
			indicatorsChart.RemoveAllData ();
			indicatorsChart.AddSeries (indicator);

			TKChartNumericAxis yAxis = (TKChartNumericAxis)indicatorsChart.YAxis;

			int max = (int)Math.Ceiling (((NSNumber)yAxis.Range.Maximum).FloatValue);
			int min = (int)Math.Floor (((NSNumber)yAxis.Range.Minimum).FloatValue);
			if (max < 0) {
				max *= -1;
				min *= -1;
			}

			yAxis.Range.Minimum = new NSNumber (min);
			yAxis.Range.Maximum = new NSNumber (max);
			yAxis.MajorTickInterval = new NSNumber ((max - min)/2.0);
			yAxis.Style.LabelStyle.TextAlignment = TKChartAxisLabelAlignment.Right | TKChartAxisLabelAlignment.Bottom;
			yAxis.Style.LineHidden = false;

			TKChartDateTimeAxis xAxis = (TKChartDateTimeAxis)indicatorsChart.XAxis;
			xAxis.Range = series.XAxis.Range;
			xAxis.Style.LabelStyle.TextHidden = true;
			xAxis.Zoom = overlayChart.XAxis.Zoom;
			xAxis.Pan = overlayChart.XAxis.Pan;
			xAxis.MajorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Years;
			xAxis.MajorTickInterval = 1;
		}

		void loadCharts()
		{
			TKChartNumericAxis yAxis = new TKChartNumericAxis ();
			yAxis.Range = new TKRange (new NSNumber (250), new NSNumber (750));

			// >> chart-text-align-cs
			yAxis.Style.LabelStyle.TextAlignment = TKChartAxisLabelAlignment.Right | TKChartAxisLabelAlignment.Bottom;
			yAxis.Style.LabelStyle.FirstLabelTextAlignment = TKChartAxisLabelAlignment.Right | TKChartAxisLabelAlignment.Top;
			yAxis.Style.LabelStyle.TextOffset = new UIOffset (0, 0);
			yAxis.Style.LabelStyle.FirstLabelTextOffset = new UIOffset (0, 0);
			// << chart-text-align-cs

			yAxis.AllowZoom = true;
			yAxis.AllowPan = true;
			series.YAxis = yAxis;

			NSDateFormatter formatter = new NSDateFormatter ();
			formatter.DateFormat = "MM/dd/yyyy";

			NSDate minDate = formatter.Parse ("01/01/2011");
			NSDate maxDate = formatter.Parse ("01/01/2013");
			TKChartDateTimeAxis xAxis = new TKChartDateTimeAxis ();
			xAxis.Range = new TKRange (minDate, maxDate);
			xAxis.MinorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days;
			xAxis.MajorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Years;
			xAxis.MajorTickInterval = 1;
			xAxis.Style.MajorTickStyle.TicksHidden = false;
			xAxis.Style.MajorTickStyle.TicksOffset = -3;
			xAxis.Style.MajorTickStyle.TicksWidth = 1.5f;
			xAxis.Style.MajorTickStyle.MaxTickClippingMode = TKChartAxisClippingMode.Visible;
			xAxis.Style.MajorTickStyle.TicksFill = new TKSolidFill (UIColor.FromRGB(203/255.0f, 203/255.0f, 203/255.0f));
			xAxis.AllowZoom = true;
			xAxis.AllowPan = true;
			series.XAxis = xAxis;

			AddTrendline (new TKChartSimpleMovingAverageIndicator (this.series));
			AddIndicator (new TKChartPercentageVolumeOscillator (this.series));
		}
	}
}

