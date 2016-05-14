using System;

using Foundation;
using UIKit;
using CoreGraphics;
using CoreAnimation;

using TelerikUI;

namespace Examples
{
	public class CustomListCell: TKListViewCell
	{
		CAGradientLayer gradient;

		public CustomListCell (IntPtr ptr) : base(ptr)
		{
			this.ClipsToBounds = true;

			this.TextLabel.TextColor = new UIColor ((nfloat)0.2, (nfloat)0.2, (nfloat)0.2, (nfloat)1);
			this.TextLabel.Font = UIFont.FromName ("HelveticaNeue-Italic", (nfloat)13);

			this.DetailTextLabel.TextColor = new UIColor ((nfloat)0.2, (nfloat)0.2, (nfloat)0.2, (nfloat)1);
			this.DetailTextLabel.Font = UIFont.FromName ("HelveticaNeue-Italic", (nfloat)11);

			this.ImageView.ContentMode = UIViewContentMode.ScaleAspectFill;

			this.gradient = new CAGradientLayer ();
			this.gradient.Colors = new CGColor[] { UIColor.Clear.CGColor, new UIColor((nfloat)1, (nfloat)1, (nfloat)1, (nfloat)0.8).CGColor };
			this.gradient.Locations = new NSNumber[] { new NSNumber(0.0), new NSNumber(0.7) };
			this.ImageView.Layer.InsertSublayer(this.gradient, 0);

			((TKView)this.BackgroundView).Stroke.StrokeSides = 0;
		}
			
		public override void LayoutSubviews ()
		{
			base.LayoutSubviews ();

			this.TextLabel.Frame = new CGRect(14, this.Frame.Size.Height - 10 - 35, this.Frame.Size.Width - 28, 20);
			this.DetailTextLabel.Frame = new CGRect(14, this.Frame.Size.Height - 15 - 10, this.Frame.Size.Width - 28, 15);
			CATransaction.Begin ();
			CATransaction.DisableActions = true;
			this.gradient.Frame = new CGRect (-2, this.Frame.Size.Height / 2.0, this.Frame.Size.Width + 2, this.Frame.Size.Height - this.Frame.Size.Height / 2);
			CATransaction.Commit ();
			this.ImageView.Frame = this.Bounds;
		}
	}
}

