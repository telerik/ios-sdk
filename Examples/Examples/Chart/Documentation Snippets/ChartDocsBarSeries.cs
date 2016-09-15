using System;
using Foundation;
using UIKit;
using TelerikUI;
using System.Collections.Generic;

namespace Examples
{
	public class ChartDocsBarSeries : UIViewController
	{
		public ChartDocsBarSeries ()
		{
		}

		TKChart chart = new TKChart();
		List<TKChartDataPoint> pointsWithCategoriesAndValues = new List<TKChartDataPoint> ();
		List<TKChartDataPoint> pointsWithCategoriesAndValues2 = new List<TKChartDataPoint> ();

		void snippet1()
		{
			var pointsWithCategoriesAndValues = new List<TKChartDataPoint> ();
			var categories = new [] { "Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" };
			var values = new [] { 70, 75, 58, 59, 88 };
			for (int i = 0; i < categories.Length; ++i) {
				pointsWithCategoriesAndValues.Add (new TKChartDataPoint (new NSNumber(values [i]), NSObject.FromObject(categories [i])));
			}

			// >> chart-bar-width-cs
			var series = new TKChartBarSeries (pointsWithCategoriesAndValues.ToArray ());
			series.MinBarHeight = 20;
			series.MaxBarHeight = 50;
			chart.AddSeries (series);
			// << chart-bar-width-cs
		}

		void snippet2()
		{
			// >> chart-bar-cls-cs
			var pointsWithCategoriesAndValues = new List<TKChartDataPoint> ();
			var pointsWithCategoriesAndValues2 = new List<TKChartDataPoint>();
			var categories = new [] { "Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" };
			var values = new [] { 70, 75, 58, 59, 88 };

			for (int i = 0; i < categories.Length; ++i) {
				pointsWithCategoriesAndValues.Add (new TKChartDataPoint (new NSNumber (values [i]), NSObject.FromObject (categories [i])));
			}

			var values2 = new [] { 40, 80, 32, 69, 95 };
			for (int i = 0; i < categories.Length; ++i) {
				pointsWithCategoriesAndValues2.Add (new TKChartDataPoint (new NSNumber(values2 [i]), NSObject.FromObject(categories [i])));
			}

			List<NSObject> objectCategories = new List<NSObject> ();
			for (int i = 0; i < categories.Length; i++) {
				objectCategories.Add (new NSString (categories [i]));
			}
			var categoryAxis = new TKChartCategoryAxis (objectCategories.ToArray());
			chart.YAxis = categoryAxis;

			var series1 = new TKChartBarSeries(pointsWithCategoriesAndValues.ToArray());
			series1.YAxis = categoryAxis;

			var series2 = new TKChartBarSeries(pointsWithCategoriesAndValues2.ToArray());
			series2.YAxis = categoryAxis;

			chart.BeginUpdates();
			chart.AddSeries(series1);
			chart.AddSeries(series2);
			chart.EndUpdates();
			// << chart-bar-cls-cs
		}

		void snippet3()
		{
			// >> chart-bar-stack-cs
			var stackInfo = new TKChartStackInfo(new NSNumber(1), TKChartStackMode.Stack);

			var series1 = new TKChartBarSeries(pointsWithCategoriesAndValues.ToArray());
			series1.StackInfo = stackInfo;

			var series2 = new TKChartBarSeries(pointsWithCategoriesAndValues2.ToArray());
			series2.StackInfo = stackInfo;

			chart.BeginUpdates();
			chart.AddSeries(series1);
			chart.AddSeries(series2);
			chart.EndUpdates();
			// << chart-bar-stack-cs
		}

		void snippet4()
		{
			// >> chart-bar-stack-100-cs
			var stackInfo = new TKChartStackInfo(new NSNumber(1), TKChartStackMode.Stack100);

			var series1 = new TKChartBarSeries(pointsWithCategoriesAndValues.ToArray());
			series1.StackInfo = stackInfo;

			var series2 = new TKChartBarSeries(pointsWithCategoriesAndValues2.ToArray());
			series2.StackInfo = stackInfo;

			chart.BeginUpdates();
			chart.AddSeries(series1);
			chart.AddSeries(series2);
			chart.EndUpdates();
			// << chart-bar-stack-100-cs
		}

		void snippet5()
		{
			// >> chart-bar-visual-cs
			var series = new TKChartBarSeries (pointsWithCategoriesAndValues.ToArray());
			// >> chart-column-visual-cs
			series.Style.Palette = new TKChartPalette ();

			var paletteItem = new TKChartPaletteItem ();
			paletteItem.Fill = new TKSolidFill (UIColor.Red);
			paletteItem.Stroke = new TKStroke (UIColor.Black);
			series.Style.Palette.AddPaletteItem (paletteItem);
			chart.AddSeries (series);
			// << chart-column-visual-cs
			// << chart-bar-visual-cs
		}

		void snippet6()
		{
			// >> chart-bar-gap-cs
			var series = new TKChartBarSeries (pointsWithCategoriesAndValues.ToArray ());
			series.GapLength = 0.5f;
			chart.AddSeries (series);
			// << chart-bar-gap-cs
		}
		 
		void barRange()
		{
			// >> chart-range-bar-cs
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
				list.Add(TKChartRangeDataPoint.RangeBarDataPoint(new NSNumber(i), lowValues[i], highValues[i]));
				list2.Add(TKChartRangeDataPoint.RangeBarDataPoint(new NSNumber(i), lowValues2[i], highValues2[i]));
			}

			TKChartRangeBarSeries series = new TKChartRangeBarSeries (list.ToArray());
			TKChartRangeBarSeries series2 = new TKChartRangeBarSeries (list2.ToArray());
			chart.AddSeries(series);
			chart.AddSeries(series2);
			// << chart-range-bar-cs

			// >> chart-range-bar-visual-cs
			series.Style.Palette = new TKChartPalette();
			var paletteItem = new TKChartPaletteItem ();
			paletteItem.Fill = new TKSolidFill (UIColor.Red);
			paletteItem.Stroke = new TKStroke (UIColor.Black);
			series.Style.Palette.AddPaletteItem (paletteItem);
			chart.AddSeries(series);
			// << chart-range-bar-visual-cs

			// >> chart-range-bar-gap-cs
			series.GapLength = 0.5f;
			// << chart-range-bar-gap-cs

			// >> chart-range-bar-height-cs
			series.MinBarHeight = 20;
			series.MaxBarHeight = 50;
			// << chart-range-bar-height-cs
		}
			
	}
}

