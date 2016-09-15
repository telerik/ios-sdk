using System;
using TelerikUI;
using System.Collections.Generic;
using Foundation;

namespace Examples
{
	public class ChartDocsSplineSeries
	{
		TKChart chart = new TKChart();

		void snippet1 ()
		{
			// >> chart-spline-cs
			var profitData = new List<TKChartDataPoint> ();
			var profitValues = new [] { 10, 45, 8, 27, 57 };
			var categories = new [] { "Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" };
			for (int i = 0; i < categories.Length; ++i) {
				profitData.Add(new TKChartDataPoint(new NSString(categories[i]), new NSNumber(profitValues[i])));
			}

			chart.AddSeries(new TKChartSplineSeries(profitData.ToArray()));
			// << chart-spline-cs
		}
	}
}

