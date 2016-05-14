using System;
using TelerikUI;
using CoreGraphics;
using UIKit;
using Foundation;

namespace Examples
{
	public class CustomCardListViewCell : TKListViewCell
	{
		public CustomCardListViewCell (IntPtr ptr) : base(ptr)
		{
		}

		public override void LayoutSubviews ()
		{
			base.LayoutSubviews ();

			float width = (float)this.Frame.Size.Height - 20f;
			this.ImageView.Frame = new CGRect (0, 10, width, width);
			CGSize desiredSize = this.TextLabel.SizeThatFits (this.Bounds.Size);
			float x = (float)this.ImageView.Frame.X + (float)this.ImageView.Bounds.Size.Width + 10f;
			this.TextLabel.Frame = new CGRect (x, 10, desiredSize.Width, desiredSize.Height);
			float height = (float)this.ContentView.Bounds.Size.Height - (float)this.TextLabel.Frame.Size.Height - 30f;
			desiredSize = this.DetailTextLabel.SizeThatFits (new CGSize (this.ContentView.Bounds.Size.Width - x - 10, height));
			this.DetailTextLabel.Frame = new CGRect (x, 10 + this.TextLabel.Frame.Y + this.TextLabel.Frame.Size.Height, 
				this.ContentView.Bounds.Size.Width - x - 10, (float)Math.Min (desiredSize.Height, height));
		}
	}
}

