using System;
using TelerikUI;
using System.Collections.Generic;
using Foundation;
using UIKit;

namespace Examples
{
	public class ChartDocsLineSeries : UIViewController
	{

		TKChart chart = new TKChart();
		List<TKChartDataPoint> profitData = null;

		public ChartDocsLineSeries ()
		{
		}

		void snippet1()
		{
			// >> getting-started-xamarin-1
			chart = new TKChart (this.View.Bounds);
			this.View.AddSubview (chart);
			// << getting-started-xamarin-1


			// >> chart-line-cs
			// >> getting-started-xamarin-2
			var expensesData = new List<TKChartDataPoint> ();
			var incomesData = new List<TKChartDataPoint> ();
			var profitData = new List<TKChartDataPoint> ();

			var categories = new [] { "Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" };
			var expensesValues = new [] { 60, 30, 50, 32, 31 };
			var incomesValues = new [] { 65, 75, 58, 59, 88 };
			var profitValues = new [] { 5, 45, 8, 27, 57 };

			for (int i = 0; i < categories.Length; ++i) {
				expensesData.Add (new TKChartDataPoint (new NSString (categories [i]), new NSNumber (expensesValues [i])));
				incomesData.Add (new TKChartDataPoint (new NSString (categories [i]), new NSNumber (incomesValues [i])));
				profitData.Add (new TKChartDataPoint (new NSString (categories [i]), new NSNumber (profitValues [i])));
			}
			// << getting-started-xamarin-2

			// >> getting-started-xamarin-3
			var seriesForExpenses = new TKChartLineSeries(expensesData.ToArray());
			seriesForExpenses.Title = "Expenses";
			chart.AddSeries(seriesForExpenses);

			var seriesForIncomes = new TKChartLineSeries(incomesData.ToArray());
			seriesForIncomes.Title = "Incomes";
			chart.AddSeries(seriesForIncomes);

			var seriesForProfit = new TKChartLineSeries(profitData.ToArray());
			seriesForProfit.Title = "Profit";
			chart.AddSeries(seriesForProfit);
			// << getting-started-xamarin-3
			chart.Legend.Hidden = false;
			// << chart-line-cs
		}

		void snippet2()
		{
			var seriesForProfit = new TKChartLineSeries (profitData.ToArray());
			seriesForProfit.Selection = TKChartSeriesSelection.Series;
			seriesForProfit.MarginForHitDetection = 30.0f;
			chart.AddSeries(seriesForProfit);
		}

		void snippet3()
		{
			// >> chart-line-series-stroke-cs
			var seriesForProfit = new TKChartLineSeries (profitData.ToArray());
			seriesForProfit.Style.Palette = new TKChartPalette ();
			var paletteItem = new TKChartPaletteItem ();
			paletteItem.Stroke = new TKStroke (UIColor.Green);
			seriesForProfit.Style.Palette.AddPaletteItem (paletteItem);
			chart.AddSeries (seriesForProfit);
			// << chart-line-series-stroke-cs
		}
	}
}

