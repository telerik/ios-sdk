using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;
using CoreAnimation;

using TelerikUI;

namespace Examples
{
	[Register("LayerAnnotation")]
	public class LayerAnnotation: XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			string[] months = new string[]{ "Jan", "Feb", "Mar", "Apr", "May", "Jun" };
			int[] values = new int[]{ 95, 40, 55, 30, 76, 34 };
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();

			for (int i = 0; i < months.Length; i++) {
				list.Add (new TKChartDataPoint(new NSString(months[i]), new NSNumber(values[i])));
			}
			chart.AddSeries (new TKChartAreaSeries (list.ToArray()));

			CALayer layer = new CALayer ();
			layer.Bounds = new RectangleF (0, 0, 100, 100);
			layer.BackgroundColor = new UIColor(1, 0, 0, 0.6f).CGColor;
			layer.ShadowRadius = 10;
			layer.ShadowColor = UIColor.Yellow.CGColor;
			layer.ShadowOpacity = 1;
			layer.CornerRadius = 10;

			TKChartLayerAnnotation a = new TKChartLayerAnnotation(layer, new NSString("Mar"), new NSNumber(80), chart.Series[0]);
			a.ZPosition = TKChartAnnotationZPosition.AboveSeries;
			chart.AddAnnotation(a);
		}
	}
}

