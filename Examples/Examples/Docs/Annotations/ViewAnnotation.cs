using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("ViewAnnotation")]
	public class ViewAnnotation: XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
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

			// >> chart-layer-annotation-cs
			UIImageView imageView = new UIImageView ();
			imageView.Image = UIImage.FromBundle ("logo.png");
			imageView.Bounds = new CGRect (0, 0, imageView.Image.Size.Width, imageView.Image.Size.Height);
			imageView.Alpha = 0.7f;
			chart.AddAnnotation (new TKChartViewAnnotation(imageView, new NSNumber(550), new NSNumber(90), chart.Series[0]));
			// << chart-layer-annotation-cs
		}
	}
}

