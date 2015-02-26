using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class StackedColumnChart: ExampleViewController
	{
		TKChart chart;

		public StackedColumnChart ()
		{
			this.AddOption ("Stacked", reloadData);
			this.AddOption ("Stacked 100", reloadData);
			this.AddOption ("No Stacking", reloadData);
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			this.reloadData (this, EventArgs.Empty);
		}

		void reloadData(object sender, EventArgs e) 
		{
			chart.RemoveAllData ();

			TKChartStackInfo stackInfo = null;
			if (this.SelectedOption < 2) {
				stackInfo = new TKChartStackInfo (new NSNumber(1), this.SelectedOption == 0 ? TKChartStackMode.Stack : TKChartStackMode.Stack100);
			}

			Random r = new Random();
			for (int i = 0; i < 4; i++) {
				List<TKChartDataPoint> list = new List<TKChartDataPoint>();
				for (int j = 0; j < 8; j++) {
					list.Add(new TKChartDataPoint(new NSNumber(j), new NSNumber(r.Next() % 100)));
				}

				TKChartColumnSeries series = new TKChartColumnSeries (list.ToArray ());
				series.Title = String.Format ("Series %d", i);
				series.StackInfo = stackInfo;
				series.SelectionMode = TKChartSeriesSelectionMode.Series;
				chart.AddSeries (series);
			}
		}
	}
}

