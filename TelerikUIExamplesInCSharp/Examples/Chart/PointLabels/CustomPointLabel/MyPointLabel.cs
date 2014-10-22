using System;
using TelerikUI;
using MonoTouch.Foundation;
using MonoTouch.UIKit;
using MonoTouch.CoreGraphics;
using System.Drawing;

namespace Examples
{
	public class MyPointLabel : TKChartPointLabel
	{
		public MyPointLabel(TKChartData dataPoint, TKChartPointLabelStyle style, string text) : base(dataPoint, style, text)
		{
		}

		public override SizeF SizeThatFits (SizeF size)
		{
			NSMutableParagraphStyle paragraphStyle = new NSMutableParagraphStyle ();
			paragraphStyle.Alignment = this.Style.TextAlignment;
			NSDictionary attributes = new NSDictionary (MonoTouch.UIKit.UIStringAttributeKey.Font, UIFont.SystemFontOfSize (18),
				                          MonoTouch.UIKit.UIStringAttributeKey.ForegroundColor, this.Style.TextColor, 
				                          MonoTouch.UIKit.UIStringAttributeKey.ParagraphStyle, paragraphStyle);

			SizeF textSize = (new NSString (this.Text)).WeakGetSizeUsingAttributes (attributes);
			SizeF labelSize = new SizeF ((float)(textSize.Width - 1.5 * (this.Style.Insets.Left + this.Style.Insets.Right) + Math.Abs (this.Style.ShadowOffset.Width)), 
				                  (float)(textSize.Height - 1.5 * (this.Style.Insets.Top + this.Style.Insets.Bottom) + Math.Abs (this.Style.ShadowOffset.Height)));
			return labelSize;
		}

		public override void DrawInContext (CGContext context, RectangleF bounds, TKChartVisualPoint visualPoint)
		{
			UIGraphics.PushContext (context);
			TKFill fill = this.Style.Fill;
			TKStroke stroke = new TKStroke (UIColor.Black);
			TKBalloonShape shape = new TKBalloonShape (TKBalloonShapeArrowPosition.Bottom, bounds.Size);
			shape.DrawInContext (context, new PointF (bounds.GetMidX (), bounds.GetMidY ()), new TKDrawing[]{ fill, stroke });
			RectangleF textRect = new RectangleF (bounds.Left, bounds.Top - this.Style.Insets.Top, bounds.Size.Width, bounds.Size.Height + this.Style.Insets.Bottom);

			NSMutableParagraphStyle paragraphStyle = new NSMutableParagraphStyle ();
			paragraphStyle.Alignment = this.Style.TextAlignment;
			NSDictionary attributes = new NSDictionary (MonoTouch.UIKit.UIStringAttributeKey.Font, UIFont.SystemFontOfSize (18),
				                          MonoTouch.UIKit.UIStringAttributeKey.ForegroundColor, this.Style.TextColor, 
				                          MonoTouch.UIKit.UIStringAttributeKey.ParagraphStyle, paragraphStyle);

			NSString text = new NSString (this.Text);
			text.WeakDrawString (textRect, NSStringDrawingOptions.TruncatesLastVisibleLine | NSStringDrawingOptions.UsesLineFragmentOrigin, attributes, null);
			UIGraphics.PopContext ();
		}
	}
}

