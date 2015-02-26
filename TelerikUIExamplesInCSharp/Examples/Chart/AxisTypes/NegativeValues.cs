using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class NegativeValues: ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				float y = i*10.0f;
				list.Add (new TKChartDataPoint(new NSNumber(i), new NSNumber(i % 2==0 ? -y : y)));
			}

			TKChartNumericAxis xAxis = new TKChartNumericAxis (new NSNumber (0), new NSNumber (9));
			xAxis.Position = TKChartAxisPosition.Bottom;
			xAxis.MajorTickInterval = 1;
			xAxis.MinorTickInterval = 1;
			xAxis.Style.LabelStyle.FirstLabelTextAlignment = TKChartAxisLabelAlignment.Right;
			chart.XAxis = xAxis;

			TKChartNumericAxis yAxis = new TKChartNumericAxis (new NSNumber (-100.0), new NSNumber (100.0));
			yAxis.Position = TKChartAxisPosition.Left;
			yAxis.MajorTickInterval = 20;
			yAxis.MinorTickInterval = 1;
			yAxis.Offset = 0;
			yAxis.Baseline = 0;
			yAxis.Style.LabelStyle.FitMode = TKChartAxisLabelFitMode.Rotate;
			yAxis.Style.LabelStyle.FirstLabelTextAlignment = TKChartAxisLabelAlignment.Left;
			chart.YAxis = yAxis;

			TKChartSplineAreaSeries series = new TKChartSplineAreaSeries (list.ToArray ());

			float shapeSize = UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Phone ? 10 : 17;
			series.Style.PointShape = new TKPredefinedShape (TKShapeType.Circle, new SizeF (shapeSize, shapeSize));
			series.SelectionMode = TKChartSeriesSelectionMode.Series;
			chart.AddSeries (series);
		}
	}
}

