using System;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class MyPointLabel : TKChartPointLabel
	{
		public MyPointLabel(TKChartData dataPoint, TKChartSeries series, string text) : base(dataPoint, series, text)
		{
		}

		public override CGSize SizeThatFits (CGSize size)
		{
			NSMutableParagraphStyle paragraphStyle = new NSMutableParagraphStyle ();
			paragraphStyle.Alignment = this.Style.TextAlignment;
			NSDictionary attributes = new NSDictionary (UIStringAttributeKey.Font, UIFont.SystemFontOfSize (18),
				                          UIStringAttributeKey.ForegroundColor, this.Style.TextColor, 
				                          UIStringAttributeKey.ParagraphStyle, paragraphStyle);

			CGSize textSize = (new NSString (this.Text)).WeakGetSizeUsingAttributes (attributes);
			CGSize labelSize = new SizeF ((float)(textSize.Width - 1.5 * (this.Style.Insets.Left + this.Style.Insets.Right) + Math.Abs (this.Style.ShadowOffset.Width)), 
				                  (float)(textSize.Height - 1.5 * (this.Style.Insets.Top + this.Style.Insets.Bottom) + Math.Abs (this.Style.ShadowOffset.Height)));
			return labelSize;
		}

		public override void DrawInContext (CGContext context, CGRect bounds, TKChartVisualPoint visualPoint, UIColor color)
		{
			UIGraphics.PushContext (context);
			TKFill fill = this.Style.Fill;
			TKStroke stroke = new TKStroke (UIColor.Black);
			TKBalloonShape shape = new TKBalloonShape (TKBalloonShapeArrowPosition.Bottom, bounds.Size);
			shape.DrawInContext (context, new CGPoint (bounds.GetMidX (), bounds.GetMidY ()), new TKDrawing[]{ fill, stroke });
			CGRect textRect = new CGRect (bounds.Left, bounds.Top - this.Style.Insets.Top, bounds.Size.Width, bounds.Size.Height + this.Style.Insets.Bottom);

			NSMutableParagraphStyle paragraphStyle = new NSMutableParagraphStyle ();
			paragraphStyle.Alignment = this.Style.TextAlignment;
			NSDictionary attributes = new NSDictionary (UIStringAttributeKey.Font, UIFont.SystemFontOfSize (16),
				                          UIStringAttributeKey.ForegroundColor, this.Style.TextColor, 
				                          UIStringAttributeKey.ParagraphStyle, paragraphStyle);

			NSString text = new NSString (this.Text);
			text.WeakDrawString (textRect, NSStringDrawingOptions.TruncatesLastVisibleLine | NSStringDrawingOptions.UsesLineFragmentOrigin, attributes, null);
			UIGraphics.PopContext ();
		}
	}
}

