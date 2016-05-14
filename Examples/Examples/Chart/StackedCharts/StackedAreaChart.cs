using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("StackedAreaChart")]
	public class StackedAreaChart: XamarinExampleViewController
	{
		TKChart chart;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Stacked", reloadData);
			this.AddOption ("Stacked 100", reloadData);
			this.AddOption ("No Stacking", reloadData);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			this.reloadData ();
		}

		void reloadData()
		{
			chart.RemoveAllData ();

			TKChartStackInfo stackInfo = null;

			if (this.SelectedOption == 0) 
				stackInfo = new TKChartStackInfo (new NSNumber (1), TKChartStackMode.Stack);
			else if (this.SelectedOption == 1)
				stackInfo = new TKChartStackInfo (new NSNumber (1), TKChartStackMode.Stack100);

			Random r = new Random ();
			for (int i = 0; i < 3; i++) {
				List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
				for (int j = 0; j < 8; j++) {
					list.Add(new TKChartDataPoint(new NSNumber(j+1), new NSNumber(r.Next() % 100)));
				}
				TKChartAreaSeries series = new TKChartAreaSeries (list.ToArray());
				series.SelectionMode = TKChartSeriesSelectionMode.Series;
				series.StackInfo = stackInfo;
				chart.AddSeries (series);
			}
		}
	}
}

