using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("ScatterChart")]
	public class ScatterChart: XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			Random r = new Random ();
			for (int i = 0; i < 2; i++) {
				// >> chart-scatter-cs
				List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
				for (int j = 0; j < 20; j++) {

					list.Add(new TKChartDataPoint (new NSNumber (r.Next() % 1450), new NSNumber (r.Next () % 150)));
				}

				TKChartScatterSeries series = new TKChartScatterSeries (list.ToArray());
				// << chart-scatter-cs
				series.Title = string.Format ("Series: {0}", i + 1);
				if (2 == i) {
					series.SelectionMode = TKChartSeriesSelectionMode.DataPoint;
				} else {
					series.SelectionMode = TKChartSeriesSelectionMode.Series;
				}
				series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
				series.MarginForHitDetection = 300;
				chart.AddSeries (series);
			}

			chart.XAxis.AllowZoom = true;
			chart.YAxis.AllowZoom = true;
		}
	}
}

