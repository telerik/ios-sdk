using System;
using System.Collections.Generic;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using TelerikUI;


namespace Examples
{
	public class ViewAnnotation: ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			Random r = new Random ();
			for (int i = 0; i < 2; i++) {
				List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
				for (int j = 0; j < 20; j++) {
					list.Add(new TKChartDataPoint(new NSNumber(r.Next() % 1450), new NSNumber(r.Next() % 150)));
				}
				chart.AddSeries(new TKChartScatterSeries (list.ToArray()));
			}

			UIImageView imageView = new UIImageView ();
			imageView.Image = new UIImage ("logo.png");
			imageView.Bounds = new RectangleF (0, 0, imageView.Image.Size.Width, imageView.Image.Size.Height);
			imageView.Alpha = 0.7f;
			chart.AddAnnotation (new TKChartViewAnnotation(imageView, new NSNumber(550), new NSNumber(90), chart.Series[0]));
		}
	}
}

