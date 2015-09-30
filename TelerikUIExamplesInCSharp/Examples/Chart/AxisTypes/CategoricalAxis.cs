using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class CategoricalAxis: ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			string[] categories = new []{"Apple", "Google", "Microsoft", "Samsung"};
			for (int i = 0; i < categories.Length; i++) {
				list.Add(new TKChartDataPoint(new NSString(categories[i]), new NSNumber(r.Next() % 100))); 
			}

			TKChartColumnSeries series = new TKChartColumnSeries (list.ToArray());
			series.SelectionMode = TKChartSeriesSelectionMode.Series;

			TKChartCategoryAxis xAxis = new TKChartCategoryAxis ();
			xAxis.Position = TKChartAxisPosition.Bottom;
			xAxis.PlotMode = TKChartAxisPlotMode.BetweenTicks;
			series.XAxis = xAxis;

			TKChartNumericAxis yAxis = new TKChartNumericAxis (new NSNumber (0), new NSNumber (100));
			yAxis.Position = TKChartAxisPosition.Left;
			chart.YAxis = yAxis;

			chart.AddSeries (series);
		}
	}
}

