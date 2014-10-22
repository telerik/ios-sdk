using System;
using System.Collections.Generic;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using TelerikUI;

namespace Examples
{
	public class CustomAnnotation: ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			string[] months = { "Jan", "Feb", "Mar", "Apr", "May", "Jun" };
			int[] values = { 95, 40, 55, 30, 76, 34 };
			List<TKChartDataPoint> array = new List<TKChartDataPoint> ();
			for (int i = 0; i < months.Length; i++) {
				array.Add (new TKChartDataPoint(new NSString(months[i]), new NSNumber(values[i])));
			}
			TKChartAreaSeries series = new TKChartAreaSeries (array.ToArray());
			series.Style.PointShape = new TKPredefinedShape (TKShapeType.Circle, new SizeF (10, 10));
			chart.AddSeries (series);

			TKPredefinedShape shape = new TKPredefinedShape (TKShapeType.Star, new SizeF (20, 20));
			MyAnnotation a = new MyAnnotation (shape, new NSString ("Mar"), new NSNumber (60), series);
			a.Fill = new TKSolidFill (UIColor.Blue);
			a.Stroke = new TKStroke (UIColor.Yellow, 3);
			chart.AddAnnotation (a);
		}
	}
}

