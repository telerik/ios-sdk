using System;
using System.Drawing;
using System.Collections.Generic;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class IndicatorsChart: ExampleViewController
	{
		TKChart overlayChart;
		TKChart indicatorsChart;
		TKChartSeries series;
		List<StockDataPoint> data;
		IndicatorsTableView settings;
		ChartDelegate chartDelegate = new ChartDelegate ();

		public List<OptionInfo> Trendlines { get; set; }

		public List<OptionInfo> Indicators { get; set; }

		public int SelectedIndicator { get; set; }

		public int SelectedTrendLine { get; set; }

		public override void ViewDidLoad ()
		{
			Trendlines = new List<OptionInfo> ();
			Indicators = new List<OptionInfo> ();

			this.addTrendlineOption("Simple moving average", (object o, EventArgs e) => { addOverlayToChart(new TKChartSimpleMovingAverageIndicator(series)); });
			this.addTrendlineOption("Exponential moving average", (object o, EventArgs e) => { addOverlayToChart(new TKChartExponentialMovingAverageIndicator(series)); });
			this.addTrendlineOption("Weighted moving average", (object o, EventArgs e) => { addOverlayToChart(new TKChartWeightedMovingAverageIndicator(series)); });
			this.addTrendlineOption("Triangular moving average", (object o, EventArgs e) => { addOverlayToChart(new TKChartTriangularMovingAverageIndicator(series)); });
			this.addTrendlineOption("Bollinger bands indicator", (object o, EventArgs e) => { addOverlayToChart(new TKChartBollingerBandIndicator(series)); });
			this.addTrendlineOption("Moving average envelopes", (object o, EventArgs e) => { addOverlayToChart(new TKChartMovingAverageEnvelopesIndicator(series)); });
			this.addIndicatorOption("Percentage volume oscillator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartPercentageVolumeOscillator(series)); });
			this.addIndicatorOption("Percentage price oscillator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartPercentagePriceOscillator(series)); });
			this.addIndicatorOption("Absolute volume oscillator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartAbsoluteVolumeOscillator(series)); });
			this.addIndicatorOption("MACD indicator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartMACDIndicator(series)); });
			this.addIndicatorOption("RSI", (object o, EventArgs e) => { addIndicatorToChart(new TKChartRelativeStrengthIndex(series)); });
			this.addIndicatorOption("Accumulation distribution line", (object o, EventArgs e) => { addIndicatorToChart(new TKChartAccumulationDistributionLine(series)); });
			this.addIndicatorOption("True range", (object o, EventArgs e) => { addIndicatorToChart(new TKChartTrueRangeIndicator(series)); });
			this.addIndicatorOption("Average true range", (object o, EventArgs e) => { addIndicatorToChart(new TKChartAverageTrueRangeIndicator(series)); });
			this.addIndicatorOption("Commodity channel index", (object o, EventArgs e) => { addIndicatorToChart(new TKChartCommodityChannelIndex(series)); });
			this.addIndicatorOption("Fast stochastic indicator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartFastStochasticIndicator(series)); });
			this.addIndicatorOption("Slow stochastic indicator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartSlowStochasticIndicator(series)); });
			this.addIndicatorOption("Rate of change", (object o, EventArgs e) => { addIndicatorToChart(new TKChartRateOfChangeIndicator(series)); });
			this.addIndicatorOption("TRIX", (object o, EventArgs e) => { addIndicatorToChart(new TKChartTRIXIndicator(series)); });
			this.addIndicatorOption("Williams percent", (object o, EventArgs e) => { addIndicatorToChart(new TKChartWilliamsPercentIndicator(series)); });
			this.addTrendlineOption("Typical price", (object o, EventArgs e) => { addOverlayToChart(new TKChartTypicalPriceIndicator(series)); });
			this.addTrendlineOption("Weighted close", (object o, EventArgs e) => { addOverlayToChart(new TKChartWeightedCloseIndicator(series)); });
			this.addIndicatorOption("Ease of movement", (object o, EventArgs e) => { addIndicatorToChart(new TKChartEaseOfMovementIndicator(series)); });
			this.addTrendlineOption("Median price", (object o, EventArgs e) => { addIndicatorToChart(new TKChartMedianPriceIndicator(series)); });
			this.addIndicatorOption("Detrended price oscillator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartDetrendedPriceOscillator(series)); });
			this.addIndicatorOption("Force index", (object o, EventArgs e) => { addIndicatorToChart(new TKChartForceIndexIndicator(series)); });
			this.addIndicatorOption("Rapid adaptive variance", (object o, EventArgs e) => { addIndicatorToChart(new TKChartRapidAdaptiveVarianceIndicator(series)); });
			this.addTrendlineOption("Modified moving average", (object o, EventArgs e) => { addOverlayToChart(new TKChartModifiedMovingAverageIndicator(series)); });
			this.addTrendlineOption("Adaptive moving average", (object o, EventArgs e) => { addOverlayToChart(new TKChartAdaptiveMovingAverageIndicator(series)); });
			this.addIndicatorOption("Standard deviation", (object o, EventArgs e) => { addIndicatorToChart(new TKChartStandardDeviationIndicator(series)); });
			this.addIndicatorOption("Relative momentum index", (object o, EventArgs e) => { addIndicatorToChart(new TKChartRelativeMomentumIndex(series)); });
			this.addIndicatorOption("On balance volume", (object o, EventArgs e) => { addIndicatorToChart(new TKChartOnBalanceVolumeIndicator(series)); });
			this.addIndicatorOption("Price volume trend", (object o, EventArgs e) => { addIndicatorToChart(new TKChartPriceVolumeTrendIndicator(series)); });
			this.addIndicatorOption("Positive volume index", (object o, EventArgs e) => { addIndicatorToChart(new TKChartPositiveVolumeIndexIndicator(series)); });
			this.addIndicatorOption("Negative volume index", (object o, EventArgs e) => { addIndicatorToChart(new TKChartNegativeVolumeIndexIndicator(series)); });
			this.addIndicatorOption("Money flow index", (object o, EventArgs e) => { addIndicatorToChart(new TKChartMoneyFlowIndexIndicator(series)); });
			this.addIndicatorOption("Ultimate oscillator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartUltimateOscillator(series)); });
			this.addIndicatorOption("Full stochastic indicator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartFullStochasticIndicator(series)); });
			this.addIndicatorOption("Market facilitation index", (object o, EventArgs e) => { addIndicatorToChart(new TKChartMarketFacilitationIndex(series)); });
			this.addIndicatorOption("Chaikin oscillator", (object o, EventArgs e) => { addIndicatorToChart(new TKChartChaikinOscillator(series)); });

			base.ViewDidLoad ();

			CGRect exampleBounds = this.ExampleBounds;
			CGRect overlayChartBounds = new CGRect (exampleBounds.X, exampleBounds.Y, exampleBounds.Width, exampleBounds.Height/1.5f);
			CGRect indicatorsChartBounds = new CGRect (exampleBounds.X, overlayChartBounds.Height + 15, exampleBounds.Width, exampleBounds.Height / 3.0f);

			overlayChart = new TKChart (overlayChartBounds);
			overlayChart.GridStyle.VerticalLinesHidden = false;
			overlayChart.AutoresizingMask = ~UIViewAutoresizing.None;
			this.View.AddSubview (overlayChart);

			indicatorsChart = new TKChart (indicatorsChartBounds);
			indicatorsChart.AutoresizingMask = ~UIViewAutoresizing.None;
			this.View.AddSubview (indicatorsChart);

			data = StockDataPoint.LoadStockPoints(-1);
			settings = new IndicatorsTableView (this);

			SelectedIndicator = 0;
			SelectedTrendLine = 0;

			series = new TKChartCandlestickSeries (data.ToArray ());

			overlayChart.Delegate = chartDelegate;

			this.loadCharts ();
		}

		public override void settingsTouched (object sender, EventArgs e)
		{
			UIUserInterfaceIdiom idiom = UIDevice.CurrentDevice.UserInterfaceIdiom;
			if (idiom == UIUserInterfaceIdiom.Pad) {
				if (this.Popover != null && this.Popover.PopoverVisible) {
					this.Popover.Dismiss (true);
					return;
				}
				this.Popover = new UIPopoverController (settings);
				CGRect settingBounds = settings.View.Bounds;
				this.Popover.PopoverContentSize = new CGSize (320, settingBounds.Height);
				this.Popover.PresentFromBarButtonItem (this.SettingsButton, UIPopoverArrowDirection.Up, true);
			} else {
				this.NavigationController.PushViewController (settings, true);
			}
		}

		void addTrendlineOption(string text, EventHandler handler)
		{
			OptionInfo option = new OptionInfo (text, handler);
			Trendlines.Add (option);
			this.AddOption (option);
		}

		void addIndicatorOption(string text, EventHandler handler)
		{
			OptionInfo option = new OptionInfo (text, handler);
			Indicators.Add (option);
			this.AddOption (option);
		}

		void addOverlayToChart(TKChartFinancialIndicator indicator)
		{
			overlayChart.RemoveAllData ();
			overlayChart.AddSeries (series);
			indicator.SelectionMode = TKChartSeriesSelectionMode.Series;
			overlayChart.AddSeries (indicator);
			overlayChart.ReloadData ();
		}

		void addIndicatorToChart(TKChartFinancialIndicator indicator)
		{
			indicatorsChart.RemoveAllData ();
			indicator.SelectionMode = TKChartSeriesSelectionMode.Series;
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
			overlayChart.RemoveAllData ();
			indicatorsChart.RemoveAllData ();

			TKChartNumericAxis yAxis = new TKChartNumericAxis ();
			yAxis.Range = new TKRange (new NSNumber (250), new NSNumber (750));
			yAxis.Style.LabelStyle.TextAlignment = TKChartAxisLabelAlignment.Right | TKChartAxisLabelAlignment.Bottom;
			yAxis.Style.LabelStyle.FirstLabelTextAlignment = TKChartAxisLabelAlignment.Right | TKChartAxisLabelAlignment.Top;
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

			OptionInfo info = Trendlines [SelectedTrendLine];
			info.Handler (info, EventArgs.Empty);

			info = Indicators [SelectedIndicator];
			info.Handler (info, EventArgs.Empty);
		}

		class ChartDelegate: TKChartDelegate
		{
			public override void DidPan (TKChart chart)
			{
				chart.XAxis.Pan = chart.XAxis.Pan;
			}

			public override void DidZoom (TKChart chart)
			{
				chart.XAxis.Zoom = chart.XAxis.Zoom;
			}
		}
	}
}

