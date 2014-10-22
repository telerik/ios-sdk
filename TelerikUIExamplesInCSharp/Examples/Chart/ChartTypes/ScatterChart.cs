using System;
using System.Collections.Generic;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using TelerikUI;

namespace Examples
{
	public class ScatterChart: ExampleViewController
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

					list.Add(new TKChartDataPoint (new NSNumber (r.Next() % 1450), new NSNumber (r.Next () % 150)));
				}

				TKChartScatterSeries series = new TKChartScatterSeries (list.ToArray());
				series.Title = string.Format ("Series: {0}", list);
				if (2 == i) {
					series.SelectionMode = TKChartSeriesSelectionMode.DataPoint;
				} else {
					series.SelectionMode = TKChartSeriesSelectionMode.Series;
				}
				series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
				series.MarginForHitDetection = 300;
				chart.AddSeries (series);
			}
			chart.EndUpdates ();
			chart.XAxis.AllowZoom = true;
			chart.YAxis.AllowZoom = true;
		}
	}
}

