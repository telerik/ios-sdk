using System;
using System.Collections.Generic;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using TelerikUI;

namespace Examples
{
	public class ColumnAndBarChart: ExampleViewController
	{
		TKChart chart;

		public ColumnAndBarChart ()
		{
			AddOption ("Column", columnSelected);
			AddOption ("Bar", barSelected);
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			this.columnSelected (this, EventArgs.Empty);
		}

		public void columnSelected(object sender, EventArgs e) 
		{
			chart.RemoveAllData ();

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 8; i++) {
				list.Add(new TKChartDataPoint (new NSNumber (i+1), new NSNumber (r.Next () % 100)));
			}

			TKChartColumnSeries series = new TKChartColumnSeries (list.ToArray());
			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
			series.SelectionMode = TKChartSeriesSelectionMode.DataPoint;

			chart.AddSeries(series);

			chart.ReloadData ();
		}

		public void barSelected(object sender, EventArgs e)
		{
			chart.RemoveAllData ();

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 8; i++) {
				list.Add (new TKChartDataPoint (new NSNumber (r.Next () % 100), new NSNumber (i + 1)));
			}

			TKChartBarSeries series = new TKChartBarSeries (list.ToArray());
			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
			series.SelectionMode = TKChartSeriesSelectionMode.DataPoint;
			chart.AddSeries (series);

			chart.ReloadData ();
		}
	}
}

