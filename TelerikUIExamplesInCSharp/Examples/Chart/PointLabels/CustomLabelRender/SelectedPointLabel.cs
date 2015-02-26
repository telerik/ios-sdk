using System;
using System.Drawing;

using Foundation;
using UIKit;
using CoreAnimation;
using CoreGraphics;

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

		public bool IsOutsideBounds {
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
			CGRect bounds = this.Bounds;
			TKFill fill = this.LabelStyle.Fill;
			TKStroke stroke = new TKStroke (UIColor.Black);
			TKBalloonShape shape = new TKBalloonShape (TKBalloonShapeArrowPosition.Bottom ,new CGSize(bounds.Size.Width - stroke.Width, bounds.Size.Height - stroke.Width));
			CGRect textRect;
			if (this.IsOutsideBounds == true) {
				shape.ArrowPosition = TKBalloonShapeArrowPosition.Top;
				textRect = new CGRect (bounds.Left, bounds.Top - this.LabelStyle.Insets.Top + shape.ArrowSize.Height, bounds.Size.Width, bounds.Size.Height + this.LabelStyle.Insets.Bottom);
			} else {
				textRect = new CGRect (bounds.Left, bounds.Top - this.LabelStyle.Insets.Top, bounds.Size.Width, bounds.Size.Height + this.LabelStyle.Insets.Bottom);
			}

			shape.DrawInContext (ctx, new CGPoint (bounds.GetMidX (), bounds.GetMidY ()), new TKDrawing[]{ fill, stroke });
			NSMutableParagraphStyle paragraphStyle = new NSMutableParagraphStyle ();
			paragraphStyle.Alignment = this.LabelStyle.TextAlignment;
			NSDictionary attributes = new NSDictionary (UIStringAttributeKey.Font, UIFont.SystemFontOfSize (18),
				UIStringAttributeKey.ForegroundColor, this.LabelStyle.TextColor, 
				UIStringAttributeKey.ParagraphStyle, paragraphStyle);

			NSString text = new NSString (this.Text);
			text.WeakDrawString (textRect, NSStringDrawingOptions.TruncatesLastVisibleLine | NSStringDrawingOptions.UsesLineFragmentOrigin, attributes, null);
			UIGraphics.PopContext ();
		}
	}
}

