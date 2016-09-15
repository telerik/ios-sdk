using System;
using TelerikUI;
using Foundation;
using System.Collections.Generic;
using UIKit;

namespace Examples
{
	public class ChartDocsRangeColumn : UIViewController
	{
		TKChart chart;

		public ChartDocsRangeColumn ()
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			// >> chart-range-col-cluster-cs
			var lowValues = new NSNumber[] {
				new NSNumber (33), new NSNumber (29),
				new NSNumber (55), new NSNumber (21),
				new NSNumber (10), new NSNumber (39),
				new NSNumber (40), new NSNumber (11)
			};

			var highValues = new NSNumber[] {
				new NSNumber (47), new NSNumber (61),
				new NSNumber (64), new NSNumber (40),
				new NSNumber (33), new NSNumber (90),
				new NSNumber (87), new NSNumber (69)
			};

			var lowValues2 = new NSNumber[] {
				new NSNumber (31), new NSNumber (32),
				new NSNumber (57), new NSNumber (18),
				new NSNumber (12), new NSNumber (31),
				new NSNumber (45), new NSNumber (14)
			};

			var highValues2 = new NSNumber[] {
				new NSNumber (43), new NSNumber (66),
				new NSNumber (61), new NSNumber (49),
				new NSNumber (31), new NSNumber (80),
				new NSNumber (82), new NSNumber (78)
			};

			List<TKChartRangeDataPoint> list = new List<TKChartRangeDataPoint> ();
			List<TKChartRangeDataPoint> list2 = new List<TKChartRangeDataPoint> ();
			for (int i = 0; i < 8; i++) {
				list.Add(TKChartRangeDataPoint.RangeColumnDataPoint(new NSNumber(i), lowValues[i], highValues[i]));
				list2.Add(TKChartRangeDataPoint.RangeColumnDataPoint(new NSNumber(i), lowValues2[i], highValues2[i]));
			}

			TKChartRangeColumnSeries series = new TKChartRangeColumnSeries (list.ToArray());
			TKChartRangeColumnSeries series2 = new TKChartRangeColumnSeries (list2.ToArray());
			chart.AddSeries(series);
			chart.AddSeries(series2);
			// << chart-range-col-cluster-cs

			// >> chart-range-col-visual-cs
			series.Style.Palette = new TKChartPalette();
			var paletteItem = new TKChartPaletteItem ();
			paletteItem.Fill = new TKSolidFill (UIColor.Red);
			paletteItem.Stroke = new TKStroke (UIColor.Black);
			series.Style.Palette.AddPaletteItem (paletteItem);
			// << chart-range-col-visual-cs

			// >> chart-range-col-gap-cs
			series.GapLength = 0.5f;
			// << chart-range-col-gap-cs

			// >> chart-range-col-width-cs
			series.MinColumnWidth = 20;
			series.MaxColumnWidth = 50;
			// << chart-range-col-width-cs
		}


	}
}

