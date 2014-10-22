using System;
using TelerikUI;
using System.Collections.Generic;
using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace Examples
{
	public class CustomPointLabelRender : ExampleViewController
	{
		TKChart chart;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			chart = new TKChart (this.ExampleBounds);
			chart.AutoresizingMask = MonoTouch.UIKit.UIViewAutoresizing.FlexibleHeight | MonoTouch.UIKit.UIViewAutoresizing.FlexibleWidth;
			chart.Delegate = new ChartDelegate (0, 3);
			this.View.AddSubview (chart);

			Random r = new Random ();
			List<TKChartDataPoint> dataPoints = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				TKChartDataPoint point = new TKChartDataPoint (new NSNumber (i), new NSNumber (r.Next () % 80));
				dataPoints.Add (point);
			}

			TKChartColumnSeries columnSeries = new TKChartColumnSeries (dataPoints.ToArray ());
			columnSeries.SelectionMode = TKChartSeriesSelectionMode.DataPoint;
			columnSeries.Style.PointLabelStyle.TextHidden = false;
			columnSeries.Style.PointLabelStyle.LayoutMode = TKChartPointLabelLayoutMode.Manual;
			columnSeries.Style.PointLabelStyle.LabelOffset = new UIOffset (0, -10);
			columnSeries.Style.PointLabelStyle.Insets = new UIEdgeInsets (-1, -5, -1, -5);
			columnSeries.Style.PointLabelStyle.Font = UIFont.SystemFontOfSize (10);
			columnSeries.Style.PointLabelStyle.TextAlignment = UITextAlignment.Center;
			columnSeries.Style.PointLabelStyle.ClipMode = TKChartPointLabelClipMode.Hidden;
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

			public override void PointSelected (TKChart chart, TKChartData point, TKChartSeries series, int index)
			{
				if (this.labelRender != null) {
					this.labelRender.SelectedSeries = (int)series.Index;
					this.labelRender.SelectedDataPoint = index;
				}
			}

			public override void PointDeselected (TKChart chart, TKChartData point, TKChartSeries series, int index)
			{
				if (this.labelRender != null) {
					this.labelRender.SelectedDataPoint = -1;
				}
			}

			public override TKChartPaletteItem PaletteItemForPoint (TKChart chart, uint index, TKChartSeries series)
			{
				if (series.Index == this.selectedSeriesIndex && index == this.selectedDataPointIndex) {
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

