using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("CrossLineAnnotation")]
	public class CrossLineAnnotation: XamarinExampleViewController
	{
		TKChart chart;

		public override void ViewDidLoad ()
		{
			this.AddOption ("cross lines", crossLines);
			this.AddOption ("horizontal line", horizontalLine);
			this.AddOption ("vertical line", verticalLine);
			this.AddOption ("disable lines", disableLines);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			Random r = new Random ();
			for (int i = 0; i < 2; i++) {
				List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
				for (int j = 0; j < 20; j++) {
					list.Add (new TKChartDataPoint(new NSNumber(r.Next() % 1450), new NSNumber(r.Next() % 150)));
				}
				chart.AddSeries (new TKChartScatterSeries (list.ToArray()));
			}

			// >> chart-line-stroke-cs
			chart.XAxis.Style.LineStroke = new TKStroke (UIColor.Black);
			// << chart-line-stroke-cs

			// >> chart-cross-annotation-cs
			chart.AddAnnotation (new TKChartCrossLineAnnotation(new NSNumber(900), new NSNumber(60), chart.Series[0]));
			// << chart-cross-annotation-cs
		}

		public void crossLines()
		{
			TKChartCrossLineAnnotation a = (TKChartCrossLineAnnotation)chart.Annotations [0];
			a.Style.VerticalLineStroke = new TKStroke (UIColor.Black);
			a.Style.HorizontalLineStroke = new TKStroke (UIColor.Black);
			a.Style.PointShape = new TKPredefinedShape(TKShapeType.Circle, new SizeF(4, 4));
			chart.UpdateAnnotations();
		}

		public void horizontalLine()
		{
			TKChartCrossLineAnnotation a = (TKChartCrossLineAnnotation)chart.Annotations [0];
			a.Style.VerticalLineStroke = null;
			a.Style.HorizontalLineStroke = new TKStroke (UIColor.Black);
			a.Style.PointShape = new TKPredefinedShape (TKShapeType.Circle, new SizeF (4, 4));
			chart.UpdateAnnotations ();
		}

		public void verticalLine()
		{
			TKChartCrossLineAnnotation a = (TKChartCrossLineAnnotation)chart.Annotations [0];
			a.Style.VerticalLineStroke = new TKStroke (UIColor.Black);
			a.Style.HorizontalLineStroke = null;
			a.Style.PointShape = new TKPredefinedShape (TKShapeType.Circle, new SizeF (4, 4));
			chart.UpdateAnnotations ();
		}

		public void disableLines()
		{
			TKChartCrossLineAnnotation a = (TKChartCrossLineAnnotation)chart.Annotations [0];
			a.Style.VerticalLineStroke = null;
			a.Style.HorizontalLineStroke = null;
			a.Style.PointShape = new TKPredefinedShape (TKShapeType.TriangleUp, new SizeF (20, 20));
			chart.UpdateAnnotations ();
		}
	}
}

