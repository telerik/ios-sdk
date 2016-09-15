using System;
using TelerikUI;
using Foundation;
using System.Collections.Generic;

namespace Examples
{
	public class ChartDocsPie
	{
		TKChart chart = new TKChart();
		TKChartPieSeries series = null;

		public ChartDocsPie ()
		{
		}

		void snippet1 ()
		{
			// >> chart-pie-cs
			var pointsWithValueAndName = new List<TKChartDataPoint> ();
			pointsWithValueAndName.Add (new TKChartDataPoint (new NSNumber (20), null, "Google"));
			pointsWithValueAndName.Add(new TKChartDataPoint(new NSNumber(30), null, "Apple"));
			pointsWithValueAndName.Add (new TKChartDataPoint (new NSNumber (10), null, "Microsoft"));
			pointsWithValueAndName.Add (new TKChartDataPoint (new NSNumber (5), null, "IBM"));
			pointsWithValueAndName.Add (new TKChartDataPoint (new NSNumber (8), null, "Oracle"));

			var series = new TKChartPieSeries (pointsWithValueAndName.ToArray());
			series.Style.PointLabelStyle.TextHidden = false;

			chart.AddSeries (series);
			chart.Legend.Hidden = false;
			chart.Legend.Style.Position = TKChartLegendPosition.Right;
			// << chart-pie-cs
		}

		void snippet2 ()
		{
			// >> chart-pie-format-cs
			series.LabelDisplayMode = TKChartPieSeriesLabelDisplayMode.Inside;

			var numberFormatter = new NSNumberFormatter ();
			numberFormatter.NumberStyle = NSNumberFormatterStyle.SpellOut;
			series.Style.PointLabelStyle.Formatter = numberFormatter;
			// << chart-pie-format-cs
		}

		void snippet3()
		{
			// >> chart-pie-format-percent-cs
			series.Style.PointLabelStyle.StringFormat = "%.0f %%";
			// << chart-pie-format-percent-cs
		}

		void snippet4()
		{
			// >> chart-pie-angle-cs
			series.StartAngle = (float)(-Math.PI/4.0/2.0);
			series.EndAngle = (float)(Math.PI/4.0/2.0);
			series.RotationAngle = (float)Math.PI;
			// << chart-pie-angle-cs
		}

		void snippet5()
		{
			// >> chart-pie-select-cs
			series.Selection = TKChartSeriesSelection.DataPoint;
			chart.Select(new TKChartSelectionInfo(series, 1));
			// << chart-pie-select-cs
		}
	}
}

