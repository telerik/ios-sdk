using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("PointLabels")]
	public class PointLabels : XamarinExampleViewController
	{
		TKChart chart;
		ChartDelegate chartDelegate = new ChartDelegate (); 
		List<TKChartDataPoint> columnData;
		List<TKChartDataPoint> barData;
		List<TKChartDataPoint> lineData;
		List<TKChartDataPoint> pieDonutData;
		List<TKChartFinancialDataPoint> ohlcData;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Bar Series", LoadBarSeries);
			this.AddOption ("Column Series", LoadColumnSeries);
			this.AddOption ("Line Series", LoadLineSeries);
			this.AddOption ("Pie Series", LoadPieSeries);
			this.AddOption ("Ohlc Series", LoadFinancialSeries);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			chart.AllowAnimations = true;
			chart.Delegate = chartDelegate;
			this.View.AddSubview (chart);

			Random r = new Random ();
			columnData = new List<TKChartDataPoint> ();
			barData = new List<TKChartDataPoint> ();
			string[] categories = new string[] { "Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" };
			for (int i = 0; i < categories.Length; i++) {
				TKChartDataPoint columnPoint = new TKChartDataPoint (new NSString (categories [i]), new NSNumber (r.Next () % 100));
				TKChartDataPoint barPoint = new TKChartDataPoint (new NSNumber (r.Next () % 100), NSObject.FromObject(categories[i]));
				columnData.Add (columnPoint);
				barData.Add (barPoint);
			}

			lineData = new List<TKChartDataPoint> ();
			int[] lineValues = new int[] { 82, 68, 83, 46, 32, 75, 8, 54, 47, 51 };
			for (int i = 0; i < lineValues.Length; i++) {
				TKChartDataPoint point = new TKChartDataPoint (new NSNumber (i), new NSNumber (lineValues [i]));
				lineData.Add (point);
			}

			pieDonutData = new List<TKChartDataPoint> ();
			pieDonutData.Add (new TKChartDataPoint (new NSNumber (20), null, "Google"));
			pieDonutData.Add (new TKChartDataPoint (new NSNumber (30), null, "Apple"));
			pieDonutData.Add (new TKChartDataPoint (new NSNumber (10), null, "Microsoft"));
			pieDonutData.Add (new TKChartDataPoint (new NSNumber (5), null, "IBM"));
			pieDonutData.Add (new TKChartDataPoint (new NSNumber (8), null, "Oracle"));

			int[] openPrices = new int[] { 100, 125, 69, 99, 140, 125 };
			int[] closePrices = new int[] { 85, 65, 135, 120, 80, 136 };
			int[] lowPrices = new int[] { 50, 60, 65, 55, 75, 90 };
			int[] highPrices = new int[] { 129, 142, 141, 123, 150, 161 };
			ohlcData = new List<TKChartFinancialDataPoint> ();
			for (int i = 0; i < openPrices.Length; i++) {
				NSDate date = NSDate.FromTimeIntervalSinceNow (60 * 60 * 24 * i);
				NSNumber open = new NSNumber (openPrices [i]);
				NSNumber high = new NSNumber (highPrices [i]);
				NSNumber low = new NSNumber (lowPrices [i]);
				NSNumber close = new NSNumber (closePrices [i]);
				TKChartFinancialDataPoint point = TKChartFinancialDataPoint.DataPoint(date, open, high, low, close);
				ohlcData.Add (point);
			}

			this.LoadBarSeries ();
		}

		void LoadBarSeries()
		{
			chart.RemoveAllData ();
			TKChartBarSeries barSeries = new TKChartBarSeries (barData.ToArray ());

			// >> chart-labels-overview-cs
			barSeries.Style.PointLabelStyle.TextHidden = false;
			barSeries.Style.PointLabelStyle.LabelOffset = new UIOffset (15, 0);
			// << chart-labels-overview-cs

			chart.AddSeries (barSeries);
			chart.ReloadData ();
		}

		void LoadColumnSeries()
		{
			chart.RemoveAllData ();
			TKChartColumnSeries columnSeries = new TKChartColumnSeries (columnData.ToArray ());
			columnSeries.Style.PointLabelStyle.TextHidden = false;
			columnSeries.Style.PointLabelStyle.LabelOffset = new UIOffset (0, -15);
			chart.AddSeries (columnSeries);
			chart.ReloadData ();
		}

		void LoadLineSeries()
		{
			chart.RemoveAllData ();
			TKChartLineSeries lineSeries = new TKChartLineSeries (lineData.ToArray ());
			lineSeries.Style.PointLabelStyle.TextHidden = false;
			lineSeries.Style.PointLabelStyle.LabelOffset = new UIOffset (0, 15);
			lineSeries.Style.PointLabelStyle.Font = UIFont.SystemFontOfSize (9);
			chart.AddSeries (lineSeries);
			chart.ReloadData ();
		}

		void LoadPieSeries()
		{
			chart.RemoveAllData ();
			TKChartPieSeries pieSeries = new TKChartPieSeries (pieDonutData.ToArray ());
			pieSeries.Style.PointLabelStyle.TextHidden = false;
			pieSeries.Style.PointLabelStyle.TextColor = UIColor.White;
			chart.AddSeries (pieSeries);
			chart.ReloadData ();
		}

		void LoadFinancialSeries()
		{
			chart.RemoveAllData ();
			TKChartOhlcSeries ohlcSeries = new TKChartOhlcSeries (ohlcData.ToArray ());
			ohlcSeries.Style.PointLabelStyle.TextHidden = false;
			ohlcSeries.Style.PointLabelStyle.LabelOffset = new UIOffset (0, -40);
			ohlcSeries.Style.PointLabelStyle.TextAlignment = UITextAlignment.Justified;
			chart.AddSeries (ohlcSeries);
			TKChartDateTimeAxis xAxis = (TKChartDateTimeAxis)chart.XAxis;
			xAxis.MinorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days;
			xAxis.PlotMode = TKChartAxisPlotMode.BetweenTicks;
			xAxis.MajorTickInterval = 1;
			xAxis.MajorTickCount = 6;
			chart.Update ();
		}

		class ChartDelegate : TKChartDelegate
		{
			public override string TextForLabelAtPoint (TKChart chart, TKChartData dataPoint, TKChartSeries series, nuint dataIndex)
			{
				if (series is TKChartPieSeries) {
					TKChartDataPoint point = (TKChartDataPoint)dataPoint;
					return point.DataName;
				}
				else if (series is TKChartBarSeries) {
					TKChartDataPoint point = (TKChartDataPoint)dataPoint;
					return String.Format ("{0}", point.DataXValue);
				}
				else if (series is TKChartOhlcSeries) {
					TKChartFinancialDataPoint point = (TKChartFinancialDataPoint)dataPoint;
					return String.Format ("O:{0}\nH:{1}\nL:{2}\nC:{3}", point.Open, point.High, point.Low, point.Close);
				}

				return String.Format ("{0}", ((TKChartDataPoint)dataPoint).DataYValue);
			}
		}
	}
}

