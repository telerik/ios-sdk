using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class DefaultAnimation: ExampleViewController
	{
		TKChart chart;
		UIUserInterfaceIdiom idiom;

		public DefaultAnimation ()
		{
			idiom = UIDevice.CurrentDevice.UserInterfaceIdiom;

			this.AddOption ("Area Series", setupAreaSeries);
			this.AddOption ("Pie Series", setupPieChart);
			this.AddOption ("Line Series", setupLineSeries);
			this.AddOption ("Scatter Series", setupScatterSeries);
			this.AddOption ("Bar Series", setupBarSeries);
			this.AddOption ("Column Series", setupColumnSeries);
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.AllowAnimations = true;
			this.View.AddSubview (chart);

			this.setupAreaSeries (this, EventArgs.Empty);
		}

		public override void AddOption (string text, EventHandler func)
		{
			if (idiom == UIUserInterfaceIdiom.Pad)
				text += " Animation";
			base.AddOption (text, func);
		}

		public void setupLineSeries(object sender, EventArgs e)
		{
			chart.RemoveAllData ();

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				list.Add (new TKChartDataPoint(new NSNumber(i), new NSNumber(r.Next() % 100)));
			}

			chart.AddSeries (new TKChartLineSeries (list.ToArray()));
		}

		public void setupAreaSeries(object sender, EventArgs e)
		{
			chart.RemoveAllData ();

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				list.Add (new TKChartDataPoint(new NSNumber(i), new NSNumber(r.Next() % 100)));
			}

			TKChartAreaSeries areaSeries = new TKChartAreaSeries (list.ToArray());
			areaSeries.SelectionMode = TKChartSeriesSelectionMode.Series;
			chart.AddSeries (areaSeries);
		}

		public void setupPieChart(object sender, EventArgs e)
		{
			chart.RemoveAllData ();

			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			list.Add (new TKChartDataPoint(new NSNumber(20), null, "Google"));
			list.Add (new TKChartDataPoint(new NSNumber(30), null, "Apple"));
			list.Add (new TKChartDataPoint(new NSNumber(10), null, "Microsoft"));
			list.Add (new TKChartDataPoint(new NSNumber(5), null, "IBM"));
			list.Add (new TKChartDataPoint(new NSNumber(8), null, "Oracle"));
			TKChartPieSeries series = new TKChartPieSeries (list.ToArray());
			series.SelectionMode = TKChartSeriesSelectionMode.DataPoint;
			chart.AddSeries (series);
		}

		public void setupScatterSeries(object sender, EventArgs e)
		{
			chart.RemoveAllData ();

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 100; i++) {
				list.Add (new TKChartDataPoint(new NSNumber(r.Next() % 1450), new NSNumber(r.Next() % 150)));
			}

			TKChartScatterSeries scatterSeries = new TKChartScatterSeries (list.ToArray());
			scatterSeries.SelectionMode = TKChartSeriesSelectionMode.Series;
			chart.AddSeries (scatterSeries);
		}

		public void setupBarSeries(object sender, EventArgs e)
		{
			chart.RemoveAllData ();

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				list.Add (new TKChartDataPoint(new NSNumber(r.Next() % 100), new NSNumber(i)));
			}

			TKChartBarSeries barSeries = new TKChartBarSeries (list.ToArray());
			barSeries.SelectionMode = TKChartSeriesSelectionMode.Series;
			chart.AddSeries (barSeries);
		}

		public void setupColumnSeries(object sender, EventArgs e)
		{
			chart.RemoveAllData ();

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				list.Add (new TKChartDataPoint(new NSNumber(i), new NSNumber(r.Next() % 100)));
			}

			TKChartColumnSeries columnSeries = new TKChartColumnSeries (list.ToArray());
			columnSeries.SelectionMode = TKChartSeriesSelectionMode.Series;
			chart.AddSeries (columnSeries);
		}
	}
}

