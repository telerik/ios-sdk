using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("NegativeValues")]
	public class NegativeValues: XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				float y = i*10.0f;
				list.Add (new TKChartDataPoint(new NSNumber(i), new NSNumber(i % 2==0 ? -y : y)));
			}

			TKChartNumericAxis xAxis = new TKChartNumericAxis (new NSNumber (0), new NSNumber (9));
			xAxis.Position = TKChartAxisPosition.Bottom;

			// >> chart-interval-set-cs
			xAxis.MajorTickInterval = 1;
			xAxis.MinorTickInterval = 1;
			// << chart-interval-set-cs

			xAxis.Style.LabelStyle.FirstLabelTextAlignment = TKChartAxisLabelAlignment.Right;
			chart.XAxis = xAxis;

			TKChartNumericAxis yAxis = new TKChartNumericAxis (new NSNumber (-100.0), new NSNumber (100.0));
			yAxis.Position = TKChartAxisPosition.Left;
			yAxis.MajorTickInterval = 20;
			yAxis.MinorTickInterval = 1;
			yAxis.Offset = 0;
			yAxis.Baseline = 0;

			// >> chart-fitmode-cs
			yAxis.Style.LabelStyle.FitMode = TKChartAxisLabelFitMode.Rotate;
			// << chart-fitmode-cs

			yAxis.Style.LabelStyle.FirstLabelTextAlignment = TKChartAxisLabelAlignment.Left;
			yAxis.Style.LineStroke = new TKStroke (UIColor.FromWhiteAlpha (0.85f, 1.0f), 2.0f);
			chart.YAxis = yAxis;

			TKChartSplineAreaSeries series = new TKChartSplineAreaSeries (list.ToArray ());

			float shapeSize = UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Phone ? 10 : 17;
			series.Style.PointShape = new TKPredefinedShape (TKShapeType.Circle, new SizeF (shapeSize, shapeSize));
			series.Selection = TKChartSeriesSelection.Series;
			chart.AddSeries (series);
		}
	}
}

