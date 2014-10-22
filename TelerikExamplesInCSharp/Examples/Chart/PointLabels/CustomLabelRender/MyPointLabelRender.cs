using System;
using TelerikUI;
using MonoTouch.Foundation;
using System.Drawing;

namespace Examples
{
	public class MyPointLabelRender : TKChartPointLabelRender
	{
		SelectedPointLabel labelLayer;
		bool isSelectedPoint;

		public int SelectedSeries {
			get;
			set;
		}

		public int SelectedDataPoint {
			get;
			set;
		}

		public MyPointLabelRender (TKChartSeriesRender render, int dataIndex, int seriesIndex) : base (render)
		{
			this.SelectedDataPoint = dataIndex;
			this.SelectedSeries = seriesIndex;
		}

		public override void RenderPointLabels (TKChartSeries series, System.Drawing.RectangleF bounds, MonoTouch.CoreGraphics.CGContext ctx)
		{
			if (labelLayer != null) {
				labelLayer.RemoveFromSuperLayer ();
			}

			for (int i = 0; i < series.Items.Length; i++) {
				TKChartData dataPoint = (TKChartData)series.Items [i];
				PointF location = base.LocationForDataPoint (dataPoint, series, bounds);
				if (!bounds.Contains(location)) {
					continue;
				}

				TKChartPointLabel label = this.LabelForDataPoint (dataPoint, series, (uint)i);
				RectangleF labelRect;
				TKChartPointLabelStyle labelStyle = series.Style.PointLabelStyle;
				if (this.isSelectedPoint) {
					labelRect = new RectangleF ((float)(location.X - 17.5), (float)(location.Y - 10 - 2.5 * Math.Abs (labelStyle.LabelOffset.Vertical)), 35, 30);
					this.labelLayer.Frame = labelRect;
					this.Render.AddSublayer (this.labelLayer);
					this.labelLayer.SetNeedsDisplay ();
				} else {
					SizeF labelSize = label.SizeThatFits (bounds.Size);
					labelRect = new RectangleF ((float)(location.X - labelSize.Width / 2.0 + labelStyle.LabelOffset.Horizontal),
						(float)(location.Y - labelSize.Height / 2.0 + labelStyle.LabelOffset.Vertical), labelSize.Width, labelSize.Height);
					label.DrawInContext (ctx, labelRect, new TKChartVisualPoint(new PointF(0, 0)));
				}
			}
		}

		public override TKChartPointLabel LabelForDataPoint (TKChartData dataPoint, TKChartSeries series, uint dataIndex)
		{
			TKChartDataPoint point = (TKChartDataPoint)dataPoint;
			if (series.Index == this.SelectedSeries && dataIndex == this.SelectedDataPoint) {
				if (this.labelLayer == null) {
					this.labelLayer = new SelectedPointLabel ();
				}

				this.labelLayer.LabelStyle = series.Style.PointLabelStyle;
				this.labelLayer.Text = String.Format ("{0}", point.DataYValue);
				this.isSelectedPoint = true;
				return null;
			}

			this.isSelectedPoint = false;
			return new TKChartPointLabel (dataPoint, series.Style.PointLabelStyle, String.Format ("{0}", point.DataYValue));
		}
	}
}

