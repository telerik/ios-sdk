using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;


namespace Examples
{
	public class BandAndLineAnnotations: ExampleViewController
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
				chart.AddSeries (new TKChartScatterSeries (list.ToArray()));
			}

			chart.AddAnnotation (new TKChartGridLineAnnotation(new NSNumber(80), chart.YAxis, new TKStroke(UIColor.Red)));
			chart.AddAnnotation (new TKChartGridLineAnnotation(new NSNumber(600), chart.XAxis));
			chart.AddAnnotation (new TKChartBandAnnotation(new TKRange(new NSNumber(10), new NSNumber(40)), chart.YAxis, new TKSolidFill(new UIColor (1, 0, 0, 0.4f)), null)); 

			TKChartBandAnnotation a = new TKChartBandAnnotation(new TKRange (new NSNumber(900), new NSNumber(1500)), chart.XAxis);
			a.Style.Fill = new TKSolidFill (new UIColor (0, 1, 0, 0.3f));
			chart.AddAnnotation (a);
		}
	}
}

