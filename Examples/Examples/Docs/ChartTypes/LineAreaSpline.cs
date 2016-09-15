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

			// >> chart-line-cs
			// >> chart-spline-cs
			// >> chart-area-cs
			// >> chart-spline-area-cs
			for (int i = 0; i < 3; i++) {

				List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
				for (int j = 0; j < 8; j++) {
					list.Add(new TKChartDataPoint(new NSNumber(j+1), new NSNumber(r.Next()%100)));
				}

				TKChartSeries series = null;
				// << chart-area-cs
				// << chart-line-cs
				// << chart-spline-cs
				// << chart-spline-area-cs
				switch (this.SelectedOption)
				{
					case 0:
					// >> chart-line-cs
						series = new TKChartLineSeries (list.ToArray ());
					// << chart-line-cs
						break;
					case 1: 
					// >> chart-spline-cs
						series = new TKChartSplineSeries (list.ToArray ());
					// << chart-spline-cs
						break;
					case 2:
					// >> chart-area-cs
						series = new TKChartAreaSeries (list.ToArray());
					// << chart-area-cs
						break;
					case 3:
					// >> chart-spline-area-cs
						series = new TKChartSplineAreaSeries (list.ToArray());
					// << chart-spline-area-cs
						break;
					// >> chart-area-cs
					// >> chart-line-cs
					// >> chart-spline-cs
					// >> chart-spline-area-cs
				}
				chart.AddSeries (series);
				// << chart-area-cs
				// << chart-line-cs
				// << chart-spline-cs
				// << chart-spline-area-cs

				// >> chart-selection-cs
				series.SelectionMode = TKChartSeriesSelectionMode.Series;
				// << chart-selection-cs


			}
		}
	}
}

