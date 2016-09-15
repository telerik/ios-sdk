using System;
using UIKit;
using TelerikUI;
using Foundation;
using System.Collections.Generic;

namespace Examples
{
	public class ChartDocsScatter
	{
		TKChart chart = new TKChart();
		List<TKChartDataPoint> scatterPoints = null;

		public ChartDocsScatter ()
		{
		}

		void snippet1 ()
		{
			var xValues = new [] { 460, 510, 600, 640, 700, 760, 800, 890, 920, 1000, 1060, 1120, 1200, 1342, 1440 };
			var yValues = new [] { 7, 9, 12, 17, 19, 25, 32, 42, 50, 16, 56, 77, 24, 80, 90 };
			var scatterPoints = new List<TKChartDataPoint> ();
			for (int i = 0; i < xValues.Length; ++i) {
				scatterPoints.Add (new TKChartDataPoint (new NSNumber (xValues [i]), new NSNumber (yValues [i])));
			}
			chart.AddSeries (new TKChartScatterSeries (scatterPoints.ToArray ()));
		}

		void snippet2()
		{
			// >> chart-scatter-visual-cs
			var series = new TKChartScatterSeries (scatterPoints.ToArray());
			var paletteItem = new TKChartPaletteItem();
			paletteItem.Fill = new TKSolidFill (UIColor.Red);
			series.Style.Palette = new TKChartPalette();
			series.Style.Palette.AddPaletteItem (paletteItem);
			chart.AddSeries (series);
			// << chart-scatter-visual-cs
		}

		void snippet3()
		{
			// >> chart-scatter-selection-cs
			var series = new TKChartScatterSeries (scatterPoints.ToArray());
			series.Selection = TKChartSeriesSelection.DataPoint;
			series.MarginForHitDetection = 30.0f;
			chart.AddSeries (series);
			// << chart-scatter-selection-cs
		}
	}
}

