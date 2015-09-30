using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;


namespace Examples
{
	public class DateTimeCategoryAxis: ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			var xAxis = new TKChartDateTimeCategoryAxis ();
			var formatter = new NSDateFormatter ();
			formatter.DateFormat = "d MMM";
			xAxis.LabelFormatter = formatter;
			xAxis.Style.MajorTickStyle.TicksOffset = -3;
			xAxis.Style.MajorTickStyle.TicksHidden = false;
			xAxis.Style.MajorTickStyle.TicksWidth = 1.5f;
			xAxis.Style.MajorTickStyle.TicksFill = new TKSolidFill (new UIColor (203 / 255.0f, 203 / 255.0f, 203 / 255.0f, 1f));
			xAxis.Style.MajorTickStyle.MaxTickClippingMode = TKChartAxisClippingMode.Visible;
			xAxis.PlotMode = TKChartAxisPlotMode.BetweenTicks;

			var yAxis = new TKChartNumericAxis (new NSNumber(320), new NSNumber(360));
			yAxis.MajorTickInterval = 20;

			var series = new TKChartCandlestickSeries(StockDataPoint.LoadStockPoints(10).ToArray());
			series.GapLength = 0.6f;
			series.XAxis = xAxis;
			chart.YAxis = yAxis;

			chart.AddSeries (series);
		}
	}
}

