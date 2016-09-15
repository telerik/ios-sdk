using System;
using TelerikUI;
using Foundation;
using System.Collections.Generic;

namespace Examples
{
	public class ChartDocsSplineAreaSeries
	{
		TKChart chart = new TKChart();

		void snippet1 ()
		{
			// >> chart-spline-area-cs
			var categories = new [] { "Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" };
			var values = new [] { 70, 75, 58, 59, 88 };
			var pointsWithCategoriesAndValues = new List<TKChartDataPoint> ();
			for (int i = 0; i < categories.Length; ++i) {
				pointsWithCategoriesAndValues.Add (new TKChartDataPoint (new NSString (categories [i]), new NSNumber (values [i])));
			}
			chart.AddSeries (new TKChartSplineAreaSeries (pointsWithCategoriesAndValues.ToArray ()));
			// << chart-spline-area-cs
		}
	}
}

