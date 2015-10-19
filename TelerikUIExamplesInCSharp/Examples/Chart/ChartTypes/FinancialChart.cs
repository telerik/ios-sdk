using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class FinancialChart: ExampleViewController
	{
		TKChart chart;
		List<StockDataPoint> points;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Candlestick", reloadChart);
			this.AddOption ("Ohlc", reloadChart);

			base.ViewDidLoad ();

			chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.GridStyle.VerticalLinesHidden = false;
			chart.GridStyle.HorizontalLinesHidden = false;
			this.View.AddSubview (chart);

			points = StockDataPoint.LoadStockPoints (42);

			this.reloadChart (this, EventArgs.Empty);
		}

		void reloadChart(object sender, EventArgs e)
		{
			chart.RemoveAllData ();

			TKChartSeries series = null;
			if (this.SelectedOption == 0) {
				series = new TKChartCandlestickSeries (points.ToArray ());
			} else {
				series = new TKChartOhlcSeries (points.ToArray ());
			}
			series.SelectionMode = TKChartSeriesSelectionMode.DataPoint;

			TKChartNumericAxis yAxis = new TKChartNumericAxis (new NSNumber (300), new NSNumber (380));
			yAxis.MajorTickInterval = 20;
			chart.YAxis = yAxis;

			chart.AddSeries (series);

			TKChartDateTimeAxis xAxis = (TKChartDateTimeAxis)chart.XAxis;
			xAxis.MinorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days;
			xAxis.Style.MajorTickStyle.TicksOffset = -3;
			xAxis.Style.MajorTickStyle.TicksHidden = false;
			xAxis.Style.MajorTickStyle.TicksWidth = 1.5f;
			xAxis.Style.MajorTickStyle.TicksFill = new TKSolidFill (UIColor.FromRGB (203, 203, 203));
			xAxis.Style.MajorTickStyle.MaxTickClippingMode = TKChartAxisClippingMode.Visible;
			xAxis.AllowPan = true;
			xAxis.AllowZoom = true;

			yAxis.Style.LabelStyle.TextAlignment = TKChartAxisLabelAlignment.Bottom | TKChartAxisLabelAlignment.Right;
			yAxis.AllowPan = true;
			yAxis.AllowZoom = true;

			chart.ReloadData ();
		}
	}
}

