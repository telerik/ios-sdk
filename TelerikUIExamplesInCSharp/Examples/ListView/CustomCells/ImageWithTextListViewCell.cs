using System;
using TelerikUI;
using UIKit;
using CoreGraphics;

namespace Examples
{
	public class ImageWithTextListViewCell : TKListViewCell
	{
		public ImageWithTextListViewCell(IntPtr ptr) : base(ptr)
		{
			this.ContentView.BackgroundColor = new UIColor (0.91f, 0.91f, 0.91f, 1.0f);
			this.TextLabel.BackgroundColor = new UIColor (0.91f, 0.91f, 0.91f, 1.0f);
			this.TextLabel.Lines = 0;
			this.TextLabel.LineBreakMode = UILineBreakMode.WordWrap;
			this.TextLabel.TextAlignment = UITextAlignment.Center;
			this.TextLabel.Font = UIFont.FromName ("Optima-Regular", 16);
			this.TextLabel.Layer.CornerRadius = 3;
			this.TextLabel.Layer.MasksToBounds = true;
		}

		public override void LayoutSubviews ()
		{
			base.LayoutSubviews ();
			this.ImageView.Frame = new CGRect (15, 0, 120, 150);
			this.TextLabel.Frame = new CGRect (0, this.ImageView.Frame.Size.Height, this.Frame.Size.Width, 60);
		}
	}
}

