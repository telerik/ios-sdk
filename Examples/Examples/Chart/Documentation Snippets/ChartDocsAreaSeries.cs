using System;
using TelerikUI;
using Foundation;
using System.Collections.Generic;
using UIKit;
using CoreGraphics;

namespace Examples
{
	public class ChartDocsAreaSeries : UIViewController
	{
		TKChart chart;
		List<TKChartDataPoint> pointsWithCategoriesAndValues = null;
		List<TKChartDataPoint> pointsWithCategoriesAndValues2 = null;

		void snippet1 ()
		{	

			// >> chart-area-cs
			var pointsWithCategoriesAndValues = new List<TKChartDataPoint> ();
			var pointsWithCategoriesAndValues2 = new List<TKChartDataPoint> ();

			var categories = new [] { "Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" };
			var values = new [] { 70, 75, 58, 59, 88 };

			for (int i = 0; i < categories.Length; ++i) {
				pointsWithCategoriesAndValues.Add (new TKChartDataPoint (new NSString (categories [i]), new NSNumber (values [i])));
			}

			var values2 = new [] { 40, 80, 32, 69, 95 };
			for (int i = 0; i < categories.Length; ++i) {
				pointsWithCategoriesAndValues2.Add (new TKChartDataPoint (new NSString (categories [i]), new NSNumber (values2 [i])));
			}

			// >> getting-started-xamarin-4
			chart.AddSeries (new TKChartAreaSeries (pointsWithCategoriesAndValues.ToArray ()));
			chart.AddSeries (new TKChartAreaSeries (pointsWithCategoriesAndValues2.ToArray ()));
			// << getting-started-xamarin-4

			// << chart-area-cs
		}

		void snippet2 ()
		{
			// >> chart-stack-area-cs
			var stackInfo = new TKChartStackInfo (new NSNumber (1), TKChartStackMode.Stack);

			var seriesForIncome = new TKChartAreaSeries (pointsWithCategoriesAndValues.ToArray ());
			seriesForIncome.StackInfo = stackInfo;

			var seriesForExpenses = new TKChartAreaSeries (pointsWithCategoriesAndValues2.ToArray ());
			seriesForExpenses.StackInfo = stackInfo;

			chart.BeginUpdates ();
			chart.AddSeries (seriesForIncome);
			chart.AddSeries (seriesForExpenses);
			chart.EndUpdates ();
			// << chart-stack-area-cs
		}

		void snippet3 ()
		{
			// >> chart-stack-area-100-cs
			var stackInfo = new TKChartStackInfo (new NSNumber (1), TKChartStackMode.Stack100);

			var seriesForIncome = new TKChartAreaSeries (pointsWithCategoriesAndValues.ToArray ());
			seriesForIncome.StackInfo = stackInfo;

			var seriesForExpenses = new TKChartAreaSeries (pointsWithCategoriesAndValues2.ToArray ());
			seriesForExpenses.StackInfo = stackInfo;

			chart.BeginUpdates ();
			chart.AddSeries (seriesForIncome);
			chart.AddSeries (seriesForExpenses);
			chart.EndUpdates ();
			// << chart-stack-area-100-cs
		}

		void snippet4 ()
		{
			// >> chart-style-fill-cs
			var seriesForAnnualRevenue = new TKChartAreaSeries (pointsWithCategoriesAndValues.ToArray());
			seriesForAnnualRevenue.Style.Palette = new TKChartPalette ();
			var paletteItem = new TKChartPaletteItem ();
			paletteItem.Stroke = new TKStroke (UIColor.Brown);
			paletteItem.Fill = new TKSolidFill(UIColor.Red);
			seriesForAnnualRevenue.Style.Palette.AddPaletteItem(paletteItem);
			chart.AddSeries(seriesForAnnualRevenue);
			// << chart-style-fill-cs
		}
	}
}

