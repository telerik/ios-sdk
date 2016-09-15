using System;
using TelerikUI;
using UIKit;
using Foundation;
using System.Collections.Generic;

namespace Examples
{
	public class ChartDocsCandleStick : UIViewController
	{
		TKChart chart;

		public ChartDocsCandleStick ()
		{
		}

		void snippet1()
		{
			// >> chart-candlestick-cs
			var openPrices = new [] { 100, 125, 69, 99, 140, 125 };
			var closePrices = new [] { 85, 65, 135, 120, 80, 136 };
			var lowPrices = new [] { 50, 60, 65, 55, 75, 90 };
			var highPrices = new [] { 129, 142, 141, 123, 150, 161 };
			var dateNow = NSDate.Now;
			var financialDataPoints = new List<TKChartFinancialDataPoint> ();

			for (int i = 0; i < openPrices.Length; ++i) {
				var date = dateNow.AddSeconds ((double)(60 * 60 * 24 * i));
				financialDataPoints.Add (new TKChartFinancialDataPoint (date, new NSNumber(openPrices [i]), new NSNumber(highPrices [i]), 
					new NSNumber(lowPrices [i]), new NSNumber(closePrices [i]), null));
			}

			var candlestickSeries = new TKChartCandlestickSeries (financialDataPoints.ToArray ());
			chart.AddSeries (candlestickSeries);

			var xAxis = chart.XAxis as TKChartDateTimeAxis;
			xAxis.MinorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days;
			xAxis.PlotMode = TKChartAxisPlotMode.BetweenTicks;
			xAxis.MajorTickInterval = 1.0;
			// << chart-candlestick-cs
		}

		class ChartDelegate: TKChartDelegate
		{
			// >> chart-candlestick-visual-cs
			public override TKChartPaletteItem PaletteItemForSeries (TKChart chart, TKChartSeries series, nint index)
			{
				var dataPoint = series.DataPointAtIndex ((uint)index);
				var stroke = new TKStroke (UIColor.Black);
				var fill = new TKSolidFill ();
				if (dataPoint.Close.DoubleValue < dataPoint.Open.DoubleValue) {
					fill.Color = UIColor.Red;
				} else {
					fill.Color = UIColor.Green;
				}
				var paletteItem = new TKChartPaletteItem (stroke, fill);
				return paletteItem;
			}
			// << chart-candlestick-visual-cs
		}
	}
}

