using System;
using System.Collections;
using System.Collections.Generic;
using CoreGraphics;
using Foundation;
using UIKit;
using TelerikUI;

namespace Examples
{
	[Register("PieChartAnnotations")]
	public class PieChartAnnotations: XamarinExampleViewController
	{
		TKChart pieChart;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.pieChart = new TKChart(this.View.Bounds);
			this.pieChart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.pieChart.AllowAnimations = true;
			this.View.AddSubview(this.pieChart);

			List<TKChartDataPoint> array = new List<TKChartDataPoint>();
			array.Add(new TKChartDataPoint(new NSNumber(25.0), null, "Auto &\nTransport"));
			array.Add(new TKChartDataPoint(new NSNumber(25.0), null, "Food &\nDining"));
			array.Add(new TKChartDataPoint(new NSNumber(25.0), null, "Fees &\nCharges"));
			array.Add(new TKChartDataPoint(new NSNumber(12.5), null, "Business\nServices"));
			array.Add(new TKChartDataPoint(new NSNumber(12.5), null, "Personal\nCare"));

			var series = new TKChartPieSeries(array.ToArray());
			series.SelectionMode = TKChartSeriesSelectionMode.DataPoint;
			series.ExpandRadius = (nfloat)1.04;
			series.RotationAngle = (nfloat)(-(Math.PI/2.0f + Math.PI/4.0f));
			series.RadiusInset = 50;
			series.LabelDisplayMode = TKChartPieSeriesLabelDisplayMode.Inside;
			series.Style.PointLabelStyle.TextHidden = false;
			series.Style.PointLabelStyle.StringFormat = "%.0f%%";
			series.Style.PointLabelStyle.TextColor = UIColor.White;
			pieChart.AddSeries(series);

			foreach (TKChartDataPoint pt in series.Items) {
				var annotation = new TKChartBalloonAnnotation(pt.DataName, pt, series);
				annotation.Style.Fill = null;
				annotation.Style.Stroke = null;
				annotation.Style.DistanceFromPoint = 0;
				annotation.Style.TextColor = UIColor.Gray;
				pieChart.AddAnnotation(annotation);
			}
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);
			this.pieChart.Select(new TKChartSelectionInfo(this.pieChart.Series[0], 0));
		}
	}
}

