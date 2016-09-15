using System;
using System.Collections.Generic;
using Foundation;
using UIKit;
using TelerikUI;

namespace Examples
{
	[Register("RangeBarColumnChart")]
	public class RangeBarColumnChart : XamarinExampleViewController
	{
		TKChart chart;
		NSNumber[] lowValues;
		NSNumber[] highValues;

		public override void ViewDidLoad ()
		{
			AddOption ("Range Column", rangeColumnSelected);
			AddOption ("Range Bar", rangeBarSelected);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			lowValues = new NSNumber[] {
				new NSNumber (33), new NSNumber (29),
				new NSNumber (55), new NSNumber (21),
				new NSNumber (10), new NSNumber (39),
				new NSNumber (40), new NSNumber (11)
			};

			highValues = new NSNumber[] {
				new NSNumber (47), new NSNumber (61),
				new NSNumber (64), new NSNumber (40),
				new NSNumber (33), new NSNumber (90),
				new NSNumber (87), new NSNumber (69)
			};

			this.rangeColumnSelected ();
		}
			
		public void rangeColumnSelected() 
		{
			chart.RemoveAllData ();

			List<TKChartRangeDataPoint> list = new List<TKChartRangeDataPoint> ();
			for (int i = 0; i < 8; i++) {
				list.Add(TKChartRangeDataPoint.RangeColumnDataPoint(new NSNumber(i), lowValues[i], highValues[i]));
			}

			TKChartRangeColumnSeries series = new TKChartRangeColumnSeries (list.ToArray());
			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
			series.Selection = TKChartSeriesSelection.DataPoint;
			chart.AddSeries(series);
			chart.ReloadData ();
		}

		public void rangeBarSelected()
		{
			chart.RemoveAllData ();
			List<TKChartRangeDataPoint> list = new List<TKChartRangeDataPoint> ();
			for (int i = 0; i < 8; i++) {
				list.Add(TKChartRangeDataPoint.RangeBarDataPoint(new NSNumber(i), lowValues[i], highValues[i]));
			}

			TKChartRangeBarSeries series = new TKChartRangeBarSeries (list.ToArray());
			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
			series.Selection = TKChartSeriesSelection.DataPoint;
			chart.AddSeries(series);
			chart.ReloadData ();
		}
	}
}

