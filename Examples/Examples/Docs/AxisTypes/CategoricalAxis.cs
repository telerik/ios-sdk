using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("CategoricalAxis")]
	public class CategoricalAxis: XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			Random r = new Random ();

			// >> chart-category-axis-cs
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			string[] categories = new []{"Apple", "Google", "Microsoft", "Samsung"};
			for (int i = 0; i < categories.Length; i++) {
				list.Add(new TKChartDataPoint(new NSString(categories[i]), new NSNumber(r.Next() % 100))); 
			}

			TKChartColumnSeries series = new TKChartColumnSeries (list.ToArray());
			series.SelectionMode = TKChartSeriesSelectionMode.Series;

			// >> chart-add-axis-cs
			TKChartCategoryAxis xAxis = new TKChartCategoryAxis ();
			xAxis.Position = TKChartAxisPosition.Bottom;
			xAxis.PlotMode = TKChartAxisPlotMode.BetweenTicks;
			series.XAxis = xAxis;
			// << chart-add-axis-cs
			// << chart-category-axis-cs

			TKChartNumericAxis yAxis = new TKChartNumericAxis (new NSNumber (0), new NSNumber (100));
			yAxis.Position = TKChartAxisPosition.Left;
			chart.YAxis = yAxis;

			chart.AddSeries (series);

			// >> chart-title-cs
			xAxis.Title = "Vendors";
			xAxis.Style.TitleStyle.TextColor = UIColor.Gray;
			xAxis.Style.TitleStyle.Font = UIFont.BoldSystemFontOfSize (11);
			xAxis.Style.TitleStyle.Alignment = TKChartAxisTitleAlignment.RightOrBottom;
			chart.ReloadData ();
			// << chart-title-cs
		}
	}
}

