using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("FinancialChart")]
	public class FinancialChart: XamarinExampleViewController
	{
		TKChart chart;
		List<StockDataPoint> points;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Candlestick", ReloadChart);
			this.AddOption ("Ohlc", ReloadChart);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.GridStyle.VerticalLinesHidden = false;
			chart.GridStyle.HorizontalLinesHidden = false;
			this.View.AddSubview (chart);

			points = StockDataPoint.LoadStockPoints (42);

			this.ReloadChart ();
		}

		void ReloadChart()
		{
			chart.RemoveAllData ();

			TKChartSeries series = null;
			if (this.SelectedOption == 0) {
				series = new TKChartCandlestickSeries (points.ToArray ());
			} else {
				series = new TKChartOhlcSeries (points.ToArray ());
			}
			series.Selection = TKChartSeriesSelection.DataPoint;

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


			// >> chart-zoom-cs
			xAxis.AllowZoom = true;
			yAxis.AllowZoom = true;
			// << chart-zoom-cs

			// >> chart-pan-cs
			xAxis.AllowPan = true;
			yAxis.AllowPan = true;
			// << chart-pan-cs

			yAxis.Style.LabelStyle.TextAlignment = TKChartAxisLabelAlignment.Bottom | TKChartAxisLabelAlignment.Right;



			chart.ReloadData ();
		}
	}
}

