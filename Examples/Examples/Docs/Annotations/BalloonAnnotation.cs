using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("BalloonAnnotation")]
	public class BalloonAnnotation: XamarinExampleViewController
	{	
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			string[] months = new string[]{ "Jan", "Feb", "Mar", "Apr", "May", "Jun" };
			int[] values = new int[]{ 95, 40, 55, 30, 76, 34 };
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();

			for (int i = 0; i < months.Length; i++) {
				list.Add (new TKChartDataPoint(new NSString(months[i]), new NSNumber(values[i])));
			}

			TKChartLineSeries series = new TKChartLineSeries (list.ToArray());

			// >> chart-point-shape-cs
			series.Style.PointShape = new TKPredefinedShape (TKShapeType.Circle, new SizeF (10, 10));
			// << chart-point-shape-cs

			// >> chart-point-pallete-cs
			var paletteItem = new TKChartPaletteItem ();
			paletteItem.Fill = new TKSolidFill (UIColor.Red);
			var palette = new TKChartPalette ();
			palette.AddPaletteItem (paletteItem);
			series.Style.ShapePalette = palette;
			// << chart-point-pallete-cs

			chart.AddSeries (series);
			// >> chart-balloon-annotation-cs
			NSMutableParagraphStyle paragraphStyle = (NSMutableParagraphStyle)new NSParagraphStyle ().MutableCopy();
			paragraphStyle.Alignment = UITextAlignment.Center;
			NSMutableDictionary attributes = new NSMutableDictionary ();
			attributes.Add (UIStringAttributeKey.ForegroundColor, UIColor.White);
			attributes.Add (UIStringAttributeKey.ParagraphStyle, paragraphStyle);
			NSMutableAttributedString attributedText = new NSMutableAttributedString ("Important milestone:\n $55000", attributes);

			attributedText.AddAttribute (UIStringAttributeKey.ForegroundColor, UIColor.Yellow, new NSRange (22, 6));

			TKChartBalloonAnnotation balloon = new TKChartBalloonAnnotation (new NSString("Mar"), new NSNumber(55), series);
			balloon.AttributedText = attributedText;
			balloon.Style.DistanceFromPoint = 20;
			balloon.Style.ArrowSize = new Size (10, 10);
			chart.AddAnnotation (balloon);
			// << chart-balloon-annotation-cs

			balloon = new TKChartBalloonAnnotation ("The lowest value:\n $30000", new NSString("Apr"), new NSNumber(30), series);
			balloon.Style.VerticalAlign = TKChartBalloonVerticalAlignment.Bottom;
			chart.AddAnnotation (balloon);
		}
	}
}

