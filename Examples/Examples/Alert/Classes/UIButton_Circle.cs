using System;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	public class UIButton_Circle : UIButton
	{
		public static UIButton Button(UIView View, String Title, Object Target, EventHandler handler)
		{
			UIButton btn = new UIButton (UIButtonType.Custom);
			btn.BackgroundColor = new UIColor (0.5f, 0.7f, 0.2f, 1f);
			btn.SetTitleColor (new UIColor (1f, 1f, 1f, 1f), UIControlState.Normal);
			btn.SetTitle (Title, UIControlState.Normal);
			btn.TitleLabel.Font = UIFont.SystemFontOfSize (12);
			btn.Layer.CornerRadius = 40;
			btn.ClipsToBounds = true;
			btn.Frame = new CGRect ((View.Frame.Size.Width - 80)/2, View.Frame.Size.Height - 180, 80, 80);
			btn.AutoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleLeftMargin;
			btn.AddTarget(handler, UIControlEvent.TouchUpInside);
			View.AddSubview (btn);
			return btn;
		}
	}
}

