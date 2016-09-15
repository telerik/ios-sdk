using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("LogarithmicAxis")]
	public class LogarithmicAxis : XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.Legend.Hidden = false;
			this.View.AddSubview (chart);

			TKDataSource datasource = new TKDataSource ("electricity", ".json", "data");
			datasource.SortWithKey ("year", true);

			datasource.ItemSource = NSArray.FromObjects(
				new TKDataSourceGroup (datasource.Items, "nuclear", "year"),
				new TKDataSourceGroup (datasource.Items, "hydro", "year"),
				new TKDataSourceGroup (datasource.Items, "solar", "year")
			);



			List<UIColor> colors = new List<UIColor> {
				new UIColor(0.318f, 0.384f,0.737f,1.00f),
				new UIColor(0.039f, 0.631f,0.933f,1.00f),
				new UIColor(0.271f, 0.678f,0.373f,1.00f)
			};

			datasource.Settings.Chart.CreateSeries((TKDataSourceGroup group) => {
				TKChartAreaSeries areaSeries = new TKChartAreaSeries();
				areaSeries.Title = group.ValueKey.ToUpper();
				for (int i = 0; i < datasource.Items.Length; i++) {
					TKDataSourceGroup current = (TKDataSourceGroup)datasource.Items[i];
					if (current.ValueKey == group.ValueKey){
						areaSeries.Style.Fill = new TKSolidFill(colors[i]);
					}
				} 
				return areaSeries;
			});

			// >> chart-axis-logarithmic-cs
			TKChartLogarithmicAxis yAxis = new TKChartLogarithmicAxis();
			yAxis.LogarithmBase = 2;
			chart.YAxis = yAxis;
			// << chart-axis-logarithmic-cs

			chart.DataSource = datasource;
		}
	}
}

