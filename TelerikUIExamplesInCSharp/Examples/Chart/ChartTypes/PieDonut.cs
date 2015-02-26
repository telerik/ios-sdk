using System;
using System.Drawing;
using System.Collections.Generic;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class PieDonut: ExampleViewController
	{
		TKChart pieChart;
		TKChart donutChart;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			pieChart = new TKChart ();
			donutChart = new TKChart ();

			CGRect bounds = this.View.Bounds;
			pieChart.Frame = CGRect.Inflate (new CGRect (this.ExampleBounds.X, this.ExampleBounds.Y, this.ExampleBounds.Width, this.ExampleBounds.Height / 2), 10, 10);
			pieChart.AutoresizingMask = ~UIViewAutoresizing.None;
			pieChart.AllowAnimations = true;
			pieChart.Legend.Hidden = false;
			pieChart.Legend.Style.Position = TKChartLegendPosition.Right;
			this.View.AddSubview (pieChart);

			donutChart.Frame = CGRect.Inflate(new CGRect (this.ExampleBounds.X, this.ExampleBounds.Y + this.ExampleBounds.Height/2, 
				this.ExampleBounds.Width, this.ExampleBounds.Height/2), 10, 10);
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
			series.SelectionMode = TKChartSeriesSelectionMode.DataPoint;
			series.SelectionAngle = -Math.PI / 2.0;
			series.ExpandRadius = 1.2f;
			series.LabelDisplayMode = TKChartPieSeriesLabelDisplayMode.Inside;
			pieChart.AddSeries (series);

			TKChartDonutSeries donutSeries = new TKChartDonutSeries (list.ToArray ());
			donutSeries.SelectionMode = TKChartSeriesSelectionMode.DataPoint;
			donutSeries.InnerRadius = 0.6f;
			donutSeries.ExpandRadius = 1.1f;
			donutSeries.LabelDisplayMode = TKChartPieSeriesLabelDisplayMode.Inside;
			donutChart.AddSeries (donutSeries);
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);
			pieChart.Select (new TKChartSelectionInfo (pieChart.Series [0], 0));
		}
	}
}

