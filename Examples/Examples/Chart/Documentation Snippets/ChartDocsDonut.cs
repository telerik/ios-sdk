using System;
using TelerikUI;
using System.Collections.Generic;
using Foundation;

namespace Examples
{
	public class ChartDocsDonut
	{
		TKChart chart = new TKChart();

		void snippet1 ()
		{
			// >> chart-dnt-cs
			var pointsWithValueAndName = new List<TKChartDataPoint> ();
			pointsWithValueAndName.Add (new TKChartDataPoint (new NSNumber (20), NSObject.FromObject ("Google")));
			pointsWithValueAndName.Add (new TKChartDataPoint (new NSNumber (30), NSObject.FromObject ("Apple")));
			pointsWithValueAndName.Add (new TKChartDataPoint (new NSNumber (10), NSObject.FromObject ("Microsoft")));
			pointsWithValueAndName.Add (new TKChartDataPoint (new NSNumber (5), NSObject.FromObject ("IBM")));
			pointsWithValueAndName.Add (new TKChartDataPoint (new NSNumber (8), NSObject.FromObject ("Oracle")));

			var series = new TKChartDonutSeries(pointsWithValueAndName.ToArray());
			series.InnerRadius = 0.5f;

			chart.AddSeries(series);
			chart.Legend.Hidden = false;
			chart.Legend.Style.Position = TKChartLegendPosition.Right;
			// << chart-dnt-cs
		}
	}
}

