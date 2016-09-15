using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("GapsLineSplineAreaChart")]
	public class GapsLineSplineAreaChart: XamarinExampleViewController
	{
		TKChart chart;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Line", reloadChart);
			this.AddOption ("Spline", reloadChart);
			this.AddOption ("Area", reloadChart);
			this.AddOption ("Area Spline", reloadChart);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			this.reloadChart ();
		}
			
		public void reloadChart()
		{
			chart.RemoveAllData ();

			List<TKChartDataPoint> array = new List<TKChartDataPoint> ();

			string[] categories = new []{ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" };
			int[] values = new []{ 65, 56, 65, 38, 56, 78, 62, 89, 78, 65 };

			for ( int i = 0; i<categories.Length; i++ ) {
				if (i == 4 || i == 5) {
					array.Add (new TKChartDataPoint (new NSString (categories [i]), null));
				}	
				else {
					array.Add(new TKChartDataPoint(new NSString(categories[i]), new NSNumber(values[i])));
				}
			}

			TKChartLineSeries series = null;

			switch (this.SelectedOption)
			{
			case 0:
				series = new TKChartLineSeries (array.ToArray ());
				break;
			case 1: 
				series = new TKChartSplineSeries (array.ToArray ());
				break;
			case 2:
				series = new TKChartAreaSeries (array.ToArray());
				break;
			case 3:
				series = new TKChartSplineAreaSeries (array.ToArray());
				break;
			}

			series.Selection = TKChartSeriesSelection.Series;
			series.DisplayNilValuesAsGaps = true;
			chart.AddSeries (series);
		}
	}
}

