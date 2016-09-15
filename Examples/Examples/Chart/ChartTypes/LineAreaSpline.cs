using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("LineAreaSpline")]
	public class LineAreaSpline: XamarinExampleViewController
	{
		TKChart chart;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Line", ReloadChart);
			this.AddOption ("Spline", ReloadChart);
			this.AddOption ("Area", ReloadChart);
			this.AddOption ("Area Spline", ReloadChart);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			this.ReloadChart ();
		}

		public void ReloadChart()
		{
			chart.RemoveAllData ();

			Random r = new Random ();

			for (int i = 0; i < 3; i++) {

				List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
				for (int j = 0; j < 8; j++) {
					list.Add(new TKChartDataPoint(new NSNumber(j+1), new NSNumber(r.Next()%100)));
				}

				TKChartSeries series = null;
				switch (this.SelectedOption)
				{
					case 0:
						series = new TKChartLineSeries (list.ToArray ());
						break;
					case 1: 
						series = new TKChartSplineSeries (list.ToArray ());
						break;
					case 2:
						series = new TKChartAreaSeries (list.ToArray());
						break;
					case 3:
						series = new TKChartSplineAreaSeries (list.ToArray());
						break;
				}
				chart.AddSeries (series);

				// >> chart-selection-cs
				series.Selection = TKChartSeriesSelection.Series;
				// << chart-selection-cs
			}
		}
	}
}

