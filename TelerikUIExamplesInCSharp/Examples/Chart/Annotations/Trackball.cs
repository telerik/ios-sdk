using System;
using System.Collections.Generic;
using System.Text;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using TelerikUI;


namespace Examples
{
	public class Trackball: ExampleViewController
	{
		TKChart chart;

		public Trackball ()
		{
			this.AddOption ("pin at top", top);
			this.AddOption ("pin at left", left);
			this.AddOption ("pin at right", right);
			this.AddOption ("pin at bottom", bottom);
			this.AddOption ("floating", floating);
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			Random r = new Random ();
			List<TKChartDataPoint> list1 = new List<TKChartDataPoint> ();
			List<TKChartDataPoint> list2 = new List<TKChartDataPoint> ();
			for (int i = 0; i < 26; i++) {
				list1.Add (new TKChartDataPoint(new NSNumber(i+1), new NSNumber(r.Next(100))));
				list2.Add (new TKChartDataPoint (new NSNumber (i + 1), new NSNumber (r.Next (60))));
			}

			TKChartNumericAxis xAxis = new TKChartNumericAxis(new NSNumber (1), new NSNumber (26));
			xAxis.Position = TKChartAxisPosition.Bottom;
			xAxis.MajorTickInterval = 5;
			chart.AddAxis (xAxis);

			TKChartAreaSeries series = new TKChartAreaSeries (list1.ToArray());
			series.XAxis = xAxis;
			chart.AddSeries (series);

			series = new TKChartAreaSeries (list2.ToArray());
			series.XAxis = xAxis;
			chart.AddSeries (series);

			chart.AllowTrackball = true;
			chart.Trackball.SnapMode = TKChartTrackballSnapMode.AllClosestPoints;
			chart.Delegate = new ChartDelegate ();
			chart.Trackball.Tooltip.Style.TextAlignment = UITextAlignment.Left;
		}

		public void left(object sender, EventArgs e)
		{
			chart.Trackball.Hide();
			chart.Trackball.Orientation = TKChartTrackballOrientation.Horizontal;
			chart.Trackball.Tooltip.PinPosition = TKChartTrackballPinPosition.Left;
			chart.Trackball.Line.Hidden = false;
			chart.Trackball.SnapMode = TKChartTrackballSnapMode.AllClosestPoints;
		}

		public void right(object sender, EventArgs e)
		{
			chart.Trackball.Hide();
			chart.Trackball.Orientation = TKChartTrackballOrientation.Horizontal;
			chart.Trackball.Tooltip.PinPosition = TKChartTrackballPinPosition.Right;
			chart.Trackball.Line.Hidden = false;
			chart.Trackball.SnapMode = TKChartTrackballSnapMode.AllClosestPoints;
		}

		public void top(object sender, EventArgs e)
		{
			chart.Trackball.Hide();
			chart.Trackball.Orientation = TKChartTrackballOrientation.Vertical;
			chart.Trackball.Tooltip.PinPosition = TKChartTrackballPinPosition.Top;
			chart.Trackball.Line.Hidden = false;
			chart.Trackball.SnapMode = TKChartTrackballSnapMode.AllClosestPoints;
		}

		public void bottom(object sender, EventArgs e)
		{
			chart.Trackball.Hide();
			chart.Trackball.Orientation = TKChartTrackballOrientation.Vertical;
			chart.Trackball.Tooltip.PinPosition = TKChartTrackballPinPosition.Bottom;
			chart.Trackball.Line.Hidden = false;
			chart.Trackball.SnapMode = TKChartTrackballSnapMode.AllClosestPoints;
		}

		public void floating(object sender, EventArgs e)
		{
			chart.Trackball.Hide();
			chart.Trackball.Orientation = TKChartTrackballOrientation.Vertical;
			chart.Trackball.Tooltip.PinPosition = TKChartTrackballPinPosition.None;
			chart.Trackball.Line.Hidden = true;
			chart.Trackball.SnapMode = TKChartTrackballSnapMode.ClosestPoint;
		}

		class ChartDelegate: TKChartDelegate
		{
			public override void TrackballDidTrackSelection (TKChart chart, TKChartSelectionInfo[] selection)
			{
				StringBuilder str = new StringBuilder();
				foreach (TKChartSelectionInfo info in selection) {
					var point = info.DataPoint as TKChartDataPoint;
					str.Append (string.Format ("Day {0} series {1} - {2}\n", point.DataXValue, info.Series.Index + 1, point.DataYValue));
				}
				chart.Trackball.Tooltip.Text = str.ToString();
			}
		}
	}
}

