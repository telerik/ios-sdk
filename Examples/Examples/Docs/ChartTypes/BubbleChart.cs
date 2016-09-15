using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("BubbleChart")]
	public class BubbleChart: XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);
			// >> chart-bubble-cs
			Random r = new Random ();
			for (int i = 0; i < 2; i++) {
				List<TKChartBubbleDataPoint> list = new List<TKChartBubbleDataPoint> ();
				for (int j = 0; j < 20; j++) {
					list.Add (new TKChartBubbleDataPoint (new NSNumber (r.Next () % 1450), new NSNumber (r.Next () % 150), new NSNumber (r.Next () % 200)));
				}

				TKChartBubbleSeries series = new TKChartBubbleSeries (list.ToArray());
				// << chart-bubble-cs
				series.Title = string.Format("Series {0}", i+1);
				series.Scale = 1.5;
				series.MarginForHitDetection = 2f;
				if (i == 0) {
					series.SelectionMode = TKChartSeriesSelectionMode.DataPoint;
				} else {
					series.SelectionMode = TKChartSeriesSelectionMode.Series;
				}
				chart.AddSeries (series);
			}
		}
	}
}

