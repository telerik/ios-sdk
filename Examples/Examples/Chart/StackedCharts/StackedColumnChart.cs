using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("StackedColumnChart")]
	public class StackedColumnChart: XamarinExampleViewController
	{
		TKChart chart;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Stacked", ReloadData);
			this.AddOption ("Stacked 100", ReloadData);
			this.AddOption ("No Stacking", ReloadData);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			this.ReloadData ();
		}

		void ReloadData() 
		{
			chart.RemoveAllData ();

			TKChartStackInfo stackInfo = null;
			if (this.SelectedOption < 2) {
				stackInfo = new TKChartStackInfo (new NSNumber(1), this.SelectedOption == 0 ? TKChartStackMode.Stack : TKChartStackMode.Stack100);
			}

			// >> chart-column-cls-cs
			Random r = new Random();
			for (int i = 0; i < 4; i++) {
				List<TKChartDataPoint> list = new List<TKChartDataPoint>();
				for (int j = 0; j < 8; j++) {
					list.Add(new TKChartDataPoint(new NSNumber(j), new NSNumber(r.Next() % 100)));
				}

				TKChartColumnSeries series = new TKChartColumnSeries (list.ToArray ());
				series.Title = String.Format ("Series %d", i);
				series.StackInfo = stackInfo;
				series.Selection = TKChartSeriesSelection.Series;
				chart.AddSeries (series);
			}
			// << chart-column-cls-cs
		}
	}
}

