using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("ColumnAndBarChart")]
	public class ColumnAndBarChart: XamarinExampleViewController
	{
		TKChart chart;

		public override void ViewDidLoad ()
		{
			AddOption ("Column", ColumnSelected);
			AddOption ("Bar", BarSelected);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			this.ColumnSelected ();
		}

		public void ColumnSelected() 
		{
			chart.RemoveAllData ();

			// >> chart-column-cs
			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 8; i++) {
				list.Add(new TKChartDataPoint (new NSNumber (i+1), new NSNumber (r.Next () % 100)));
			}

			TKChartColumnSeries series = new TKChartColumnSeries (list.ToArray());
			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
			series.Selection = TKChartSeriesSelection.DataPoint;

			// >> chart-width-cl-cs
			series.MaxColumnWidth = 50;
			series.MinColumnWidth = 20;
			// << chart-width-cl-cs

			chart.AddSeries(series);
			// << chart-column-cs

			chart.ReloadData ();
		}

		public void BarSelected()
		{
			chart.RemoveAllData ();
			// >> chart-bar-cs
			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 8; i++) {
				list.Add (new TKChartDataPoint (new NSNumber (r.Next () % 100), new NSNumber (i + 1)));
			}

			TKChartBarSeries series = new TKChartBarSeries (list.ToArray());
			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
			series.Selection = TKChartSeriesSelection.DataPoint;
			chart.AddSeries (series);
			// << chart-bar-cs
			chart.ReloadData ();
		}
	}
}

