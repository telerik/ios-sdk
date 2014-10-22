using System;
using System.Drawing;
using MonoTouch.Foundation;
using MonoTouch.UIKit;
using MonoTouch.CoreAnimation;
using MonoTouch.CoreGraphics;
using TelerikUI;

namespace Examples
{
	public class SelectedPointLabel : CALayer
	{
		public TKChartPointLabelStyle LabelStyle {
			get;
			set;
		}

		public string Text {
			get;
			set;
		}

		public SelectedPointLabel()
		{
			this.NeedsDisplayOnBoundsChange = true;
			this.ContentsScale = UIScreen.MainScreen.Scale;
			this.DrawsAsynchronously = true;
		}

		public override void DrawInContext (CGContext ctx)
		{
			UIGraphics.PushContext (ctx);
			RectangleF bounds = this.Bounds;
			TKFill fill = this.LabelStyle.Fill;
			TKStroke stroke = new TKStroke (UIColor.Black);
			TKBalloonShape shape = new TKBalloonShape (TKBalloonShapeArrowPosition.Bottom, new SizeF(bounds.Size.Width - stroke.Width, bounds.Size.Height - stroke.Width));
			shape.DrawInContext (ctx, new PointF (bounds.GetMidX (), bounds.GetMidY ()), new TKDrawing[]{ fill, stroke });
			RectangleF textRect = new RectangleF (bounds.Left, bounds.Top - this.LabelStyle.Insets.Top, bounds.Size.Width, bounds.Size.Height + this.LabelStyle.Insets.Bottom);

			NSMutableParagraphStyle paragraphStyle = new NSMutableParagraphStyle ();
			paragraphStyle.Alignment = this.LabelStyle.TextAlignment;
			NSDictionary attributes = new NSDictionary (MonoTouch.UIKit.UIStringAttributeKey.Font, UIFont.SystemFontOfSize (18),
				MonoTouch.UIKit.UIStringAttributeKey.ForegroundColor, this.LabelStyle.TextColor, 
				MonoTouch.UIKit.UIStringAttributeKey.ParagraphStyle, paragraphStyle);

			NSString text = new NSString (this.Text);
			text.WeakDrawString (textRect, NSStringDrawingOptions.TruncatesLastVisibleLine | NSStringDrawingOptions.UsesLineFragmentOrigin, attributes, null);
			UIGraphics.PopContext ();
		}
	}
}

