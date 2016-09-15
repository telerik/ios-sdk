using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("NumericAxis")]
	public class NumericAxis: XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			// >> chart-getting-started-cs
			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);
			// << chart-getting-started-cs

			// >> chart-getting-started-cus-cs
			chart.Title.Hidden = false;
			chart.Title.Text = "This is a chart demo";
			chart.Legend.Hidden = false;
			chart.AllowAnimations = true;
			// << chart-getting-started-cus-cs

			// >> chart-getting-started-data-cs
			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 12; i++) {
				list.Add (new TKChartDataPoint (new NSNumber (i), new NSNumber (r.Next () % 2000)));
			}
			// << chart-getting-started-data-cs

			// >> chart-getting-started-series-cs
			TKChartLineSeries series = new TKChartLineSeries (list.ToArray());

			series.Selection = TKChartSeriesSelection.Series;
			chart.AddSeries (series);

			// << chart-getting-started-series-cs

			TKChartNumericAxis xAxis = new TKChartNumericAxis ();
			xAxis.Range = new TKRange (new NSNumber (0), new NSNumber (11));
			xAxis.Position = TKChartAxisPosition.Bottom;
			xAxis.MajorTickInterval = 1;
			chart.XAxis = xAxis;

			// >> chart-axis-numeric-cs
			TKChartNumericAxis yAxis = new TKChartNumericAxis ();
			yAxis.Range = new TKRange (new NSNumber (0), new NSNumber (2000));
			yAxis.Position = TKChartAxisPosition.Left;
			yAxis.MajorTickInterval = 400;
			yAxis.LabelDisplayMode = TKChartNumericAxisLabelDisplayMode.Percentage;
			chart.YAxis = yAxis;
			// << chart-axis-numeric-cs

		}
	}
}

