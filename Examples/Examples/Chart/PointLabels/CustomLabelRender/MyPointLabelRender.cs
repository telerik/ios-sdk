using System;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class MyPointLabelRender : TKChartPointLabelRender
	{
		SelectedPointLabel labelLayer;
		bool isSelectedPoint;

		public nint SelectedSeries {
			get;
			set;
		}

		public nint SelectedDataPoint {
			get;
			set;
		}

		public MyPointLabelRender (TKChartSeriesRender render, int dataIndex, int seriesIndex) : base (render)
		{
			this.SelectedDataPoint = dataIndex;
			this.SelectedSeries = seriesIndex;
		}

		public override void RenderPointLabels (TKChartSeries series, CGRect bounds, CGContext ctx)
		{
			if (labelLayer != null) {
				labelLayer.RemoveFromSuperLayer ();
			}

			for (int i = 0; i < series.Items.Length; i++) {
				TKChartData dataPoint = (TKChartData)series.Items [i];
				CGPoint location = base.LocationForDataPoint (dataPoint, series, bounds);
				if (!bounds.Contains(location)) {
					continue;
				}

				TKChartPointLabel label = this.LabelForDataPoint (dataPoint, series, (uint)i);
				CGRect labelRect;
				TKChartPointLabelStyle labelStyle = series.Style.PointLabelStyle;
				if (this.isSelectedPoint) {
					labelRect = new CGRect ((float)(location.X - 17.5), (float)(location.Y - 10 - 2.5 * Math.Abs (labelStyle.LabelOffset.Vertical)), 35, 30);
					if (labelRect.Y < bounds.Y) {
						this.labelLayer.IsOutsideBounds = true;
						labelRect.Y = (float)(location.Y + 10 + 2.5 * Math.Abs (labelStyle.LabelOffset.Vertical) - labelRect.Size.Height);
					} else {
						this.labelLayer.IsOutsideBounds = false;
					}

					this.labelLayer.Frame = labelRect;
					this.Render.AddSublayer (this.labelLayer);
					this.labelLayer.SetNeedsDisplay ();
				} else {
					CGSize labelSize = label.SizeThatFits (bounds.Size);
					labelRect = new CGRect ((float)(location.X - labelSize.Width / 2.0 + labelStyle.LabelOffset.Horizontal),
						(float)(location.Y - labelSize.Height / 2.0 + labelStyle.LabelOffset.Vertical), labelSize.Width, labelSize.Height);

					if (labelRect.Y < this.Render.Bounds.Y) {
						labelRect.Y = (float)(location.Y - labelSize.Height / 2.0 + Math.Abs (labelStyle.LabelOffset.Vertical));
					}

					label.DrawInContext (ctx, labelRect, new TKChartVisualPoint(new PointF(0, 0)), UIColor.White);
				}
			}
		}

		public override TKChartPointLabel LabelForDataPoint (TKChartData dataPoint, TKChartSeries series, nuint dataIndex)
		{
			TKChartDataPoint point = (TKChartDataPoint)dataPoint;
			if (series.Index == (nuint)this.SelectedSeries && dataIndex == (nuint)this.SelectedDataPoint) {
				if (this.labelLayer == null) {
					this.labelLayer = new SelectedPointLabel ();
				}

				this.labelLayer.LabelStyle = series.Style.PointLabelStyle;
				this.labelLayer.Text = String.Format ("{0}", point.DataYValue);
				this.isSelectedPoint = true;
				return null;
			}

			this.isSelectedPoint = false;
			return new TKChartPointLabel (dataPoint, series, String.Format ("{0}", point.DataYValue));
		}
	}
}

