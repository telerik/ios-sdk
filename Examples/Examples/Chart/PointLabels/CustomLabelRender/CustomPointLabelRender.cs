using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("CustomPointLabelRender")]
	public class CustomPointLabelRender : XamarinExampleViewController
	{
		TKChart chart;
		ChartDelegate chartDelegate = new ChartDelegate (0, 3);

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			chart.Delegate = chartDelegate;
			this.View.AddSubview (chart);

			Random r = new Random ();
			List<TKChartDataPoint> dataPoints = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				TKChartDataPoint point = new TKChartDataPoint (new NSNumber (i), new NSNumber (r.Next () % 100));
				dataPoints.Add (point);
			}

			TKChartColumnSeries columnSeries = new TKChartColumnSeries (dataPoints.ToArray ());
			columnSeries.Selection = TKChartSeriesSelection.DataPoint;
			columnSeries.Style.PointLabelStyle.TextHidden = false;
			columnSeries.Style.PointLabelStyle.LayoutMode = TKChartPointLabelLayoutMode.Manual;
			columnSeries.Style.PointLabelStyle.LabelOffset = new UIOffset (0, -10);
			columnSeries.Style.PointLabelStyle.Insets = new UIEdgeInsets (-1, -5, -1, -5);
			columnSeries.Style.PointLabelStyle.Font = UIFont.SystemFontOfSize (10);
			columnSeries.Style.PointLabelStyle.TextAlignment = UITextAlignment.Center;
			columnSeries.Style.PointLabelStyle.ClipMode = TKChartPointLabelClipMode.Visible;
			columnSeries.Style.PointLabelStyle.TextColor = UIColor.White;
			columnSeries.Style.PointLabelStyle.Fill = new TKSolidFill (new UIColor ((float)(108 / 255.0), (float)(181 / 255.0), (float)(250 / 255.0), (float)1.0));

			chart.AddSeries (columnSeries);
			chart.Select (new TKChartSelectionInfo (chart.Series [0], 3));
		}

		class ChartDelegate : TKChartDelegate
		{
			int selectedSeriesIndex;
			int selectedDataPointIndex;
			MyPointLabelRender labelRender;

			public ChartDelegate(int selectedSeriesIndex, int selectedDataPointIndex)
			{
				this.selectedSeriesIndex = selectedSeriesIndex;
				this.selectedDataPointIndex = selectedDataPointIndex;
			}

			public override TKChartPointLabelRender PointLabelRenderForSeries (TKChart chart, TKChartSeries series, TKChartSeriesRender render)
			{
				if (this.labelRender == null) {
					labelRender = new MyPointLabelRender (render, this.selectedDataPointIndex, this.selectedSeriesIndex);
				}

				if (series.Index == 0) {
					return this.labelRender;
				}

				return null;
			}

			public override void PointSelected (TKChart chart, TKChartData point, TKChartSeries series, nint index)
			{
				if (this.labelRender != null) {
					this.labelRender.SelectedSeries = (int)series.Index;
					this.labelRender.SelectedDataPoint = index;
				}
			}

			public override void PointDeselected (TKChart chart, TKChartData point, TKChartSeries series, nint index)
			{
				if (this.labelRender != null) {
					this.labelRender.SelectedDataPoint = -1;
				}
			}

			public override TKChartPaletteItem PaletteItemForPoint (TKChart chart, nuint index, TKChartSeries series)
			{
				if (series.Index == (nuint)this.selectedSeriesIndex && index == (nuint)this.selectedDataPointIndex) {
					return new TKChartPaletteItem (new TKStroke (UIColor.Black, (float)2.0), new TKSolidFill (UIColor.White));
				}

				if (series.Index == 0) {
					return new TKChartPaletteItem (new TKSolidFill (new UIColor ((float)(108 / 255.0), (float)(181 / 255.0), (float)(250 / 255.0), (float)1.0)));
				}

				return new TKChartPaletteItem (new TKSolidFill (new UIColor ((float)(241 / 255.0), (float)(140 / 255.0), (float)(133 / 255.0), (float)1.0)));
			}
		}
	}
}

