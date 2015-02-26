using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class LineAreaSpline: ExampleViewController
	{
		TKChart chart;

		public LineAreaSpline ()
		{
			this.AddOption ("Line", reloadChart);
			this.AddOption ("Spline", reloadChart);
			this.AddOption ("Area", reloadChart);
			this.AddOption ("Area Spline", reloadChart);
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			this.reloadChart (this, EventArgs.Empty);
		}

		public void reloadChart(object sender, EventArgs e)
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
				series.SelectionMode = TKChartSeriesSelectionMode.Series;
				chart.AddSeries (series);
			}
		}
	}
}

