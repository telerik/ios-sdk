using System;
using System.Collections.Generic;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using TelerikUI;

namespace Examples
{
	public class NumericAxis: ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 12; i++) {
				list.Add (new TKChartDataPoint (new NSNumber (i), new NSNumber (r.Next () % 2000)));
			}

			TKChartLineSeries series = new TKChartLineSeries (list.ToArray());
			series.SelectionMode = TKChartSeriesSelectionMode.Series;

			TKChartNumericAxis xAxis = new TKChartNumericAxis ();
			xAxis.Range = new TKRange (new NSNumber (0), new NSNumber (11));
			xAxis.Position = TKChartAxisPosition.Bottom;
			xAxis.MajorTickInterval = 1;
			chart.XAxis = xAxis;

			TKChartNumericAxis yAxis = new TKChartNumericAxis ();
			yAxis.Range = new TKRange (new NSNumber (0), new NSNumber (2000));
			yAxis.Position = TKChartAxisPosition.Left;
			yAxis.MajorTickInterval = 400;
			chart.YAxis = yAxis;

			chart.AddSeries (series);
		}
	}
}

