using System;
using TelerikUI;
using UIKit;
using CoreGraphics;

namespace Examples
{
	public class SimpleListViewCell : TKListViewCell
	{
		public SimpleListViewCell (IntPtr ptr) : base(ptr)
		{
			this.TextLabel.Font = UIFont.SystemFontOfSize (12);
			this.TextLabel.TextAlignment = UITextAlignment.Center;
		}

		public override void LayoutSubviews ()
		{
			base.LayoutSubviews ();
			CGSize desiredSize = this.TextLabel.SizeThatFits (this.Bounds.Size);
			this.TextLabel.Frame = new CGRect (1, this.Bounds.Size.Height - desiredSize.Height - 6, this.Bounds.Size.Width - 2, desiredSize.Height - 2);
			this.ImageView.Frame = new CGRect ((this.Bounds.Size.Width - 100.0f) / 2.0f, 5, 100, this.Bounds.Size.Height - (this.TextLabel.Bounds.Size.Height + 17));
		}
	}
}

