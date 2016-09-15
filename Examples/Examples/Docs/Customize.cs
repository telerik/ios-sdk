using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("Customize")]
	public class Customize: XamarinExampleViewController
	{
		ChartDelegate chartDelegate = new ChartDelegate ();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart ();
			chart.Frame = this.View.Bounds;
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.Delegate = chartDelegate;
			this.View.AddSubview (chart);

			Random r = new Random ();
			List<TKChartDataPoint> list1 = new List<TKChartDataPoint> ();
			List<TKChartDataPoint> list2 = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				list1.Add (new TKChartDataPoint(new NSNumber(i), new NSNumber(r.Next() % 100)));
				list2.Add (new TKChartDataPoint(new NSNumber(i), new NSNumber(r.Next() % 100)));
			}

			TKChartColumnSeries columnSeries = new TKChartColumnSeries (list1.ToArray());
			columnSeries.SelectionMode = TKChartSeriesSelectionMode.Series;
			chart.AddSeries (columnSeries);

			TKChartAreaSeries areaSeries = new TKChartAreaSeries (list2.ToArray());
			areaSeries.Style.PointShape = new TKPredefinedShape (TKShapeType.Star, new SizeF(20, 20));
			areaSeries.Style.ShapeMode = TKChartSeriesStyleShapeMode.AlwaysShow;
			areaSeries.SelectionMode = TKChartSeriesSelectionMode.Series;
			chart.AddSeries (areaSeries);

			// >> chart-label-style-cs
			chart.YAxis.Style.LabelStyle.Font = UIFont.SystemFontOfSize (18);
			chart.YAxis.Style.LabelStyle.TextColor = UIColor.Black;
			// << chart-label-style-cs

			// >> chart-customize-axis-cs
			chart.XAxis.Style.LabelStyle.Font = UIFont.SystemFontOfSize (18);
			// << chart-customize-axis-cs

			chart.XAxis.Style.LabelStyle.TextColor = UIColor.Black;

			chart.GridStyle.HorizontalAlternateFill = new TKSolidFill (UIColor.FromWhiteAlpha (0.9f, 0.8f));
		}

		class ChartDelegate: TKChartDelegate 
		{
			public override TKChartPaletteItem PaletteItemForSeries (TKChart chart, TKChartSeries series, nint index)
			{
				TKChartPaletteItem item = null;

				if (series.Index == 1) {
					UIColor[] colors = new UIColor[] { 
						new UIColor(0f, 1f, 0f, 0.4f),
						new UIColor(1f, 0f, 0f, 0.4f),
						new UIColor(0f, 0f, 1f, 0.4f),
					};
					TKLinearGradientFill gradient = new TKLinearGradientFill(colors, new PointF (0.5f, 0.0f), new PointF (0.5f, 1.0f));
					item = new TKChartPaletteItem (gradient);
				} else {
					TKImageFill image = new TKImageFill(UIImage.FromBundle ("pattern1.png"), 5.0f);
					image.ResizingMode = TKImageFillResizingMode.Tile;
					TKStroke stroke = new TKStroke (UIColor.Black, 1.0f);
					stroke.CornerRadius = 5.0f;
					stroke.DashPattern = new NSNumber[] { new NSNumber(2), new NSNumber(2), new NSNumber(5), new NSNumber(2) };
					item = new TKChartPaletteItem (new NSObject[] { image, stroke });
				}

				return item;
			}
		}
	}
}

