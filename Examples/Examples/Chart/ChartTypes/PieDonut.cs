using System;
using System.Drawing;
using System.Collections.Generic;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("PieDonut")]
	public class PieDonut: XamarinExampleViewController
	{
		TKChart chart;
		TKChart donutChart;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			chart = new TKChart ();
			donutChart = new TKChart ();

			CGRect bounds = this.View.Bounds;
			chart.Frame = new CGRect(this.View.Bounds.X, this.View.Bounds.Y, this.View.Bounds.Width - 10, this.View.Bounds.Height / 2 - 10);
			chart.AutoresizingMask = ~UIViewAutoresizing.None;
			chart.AllowAnimations = true;

			// >> chart-legend-cs
			chart.Legend.Hidden = false;
			// << chart-legend-cs

			// >> chart-legend-position-cs
			chart.Legend.Style.Position = TKChartLegendPosition.Right;
			// << chart-legend-position-cs

			this.View.AddSubview (chart);

			donutChart.Frame = new CGRect(this.View.Bounds.X, this.View.Bounds.Y + this.View.Bounds.Height/2, this.View.Bounds.Width - 10, this.View.Bounds.Height / 2 - 10);
			donutChart.AutoresizingMask = ~UIViewAutoresizing.None;
			donutChart.AllowAnimations = true;
			donutChart.Legend.Hidden = false;
			donutChart.Legend.Style.Position = TKChartLegendPosition.Right;
			this.View.AddSubview (donutChart);

			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			list.Add (new TKChartDataPoint(new NSNumber(20), null, "Google"));
			list.Add (new TKChartDataPoint(new NSNumber(30), null, "Apple"));
			list.Add (new TKChartDataPoint(new NSNumber(10), null, "Microsoft"));
			list.Add (new TKChartDataPoint(new NSNumber(5), null, "IBM"));
			list.Add (new TKChartDataPoint(new NSNumber(8), null, "Oracle"));

			TKChartPieSeries series = new TKChartPieSeries (list.ToArray());
			series.Selection = TKChartSeriesSelection.DataPoint;
			series.SelectionAngle = -Math.PI / 2.0;
			series.ExpandRadius = 1.2f;
			series.LabelDisplayMode = TKChartPieSeriesLabelDisplayMode.Inside;
			chart.AddSeries (series);

			TKChartDonutSeries donutSeries = new TKChartDonutSeries (list.ToArray ());
			donutSeries.Selection = TKChartSeriesSelection.DataPoint;
			donutSeries.InnerRadius = 0.6f;
			donutSeries.ExpandRadius = 1.1f;
			donutSeries.LabelDisplayMode = TKChartPieSeriesLabelDisplayMode.Inside;
			donutChart.AddSeries (donutSeries);
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);
			chart.Select (new TKChartSelectionInfo (chart.Series [0], 0));
		}
	}
}

