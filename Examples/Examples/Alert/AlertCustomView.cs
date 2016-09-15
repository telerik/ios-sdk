using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	[Register("AlertCustomView")]
	public class AlertCustomView : XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			UIButton_Circle.Button (this.View, "Show Alert", this, Show);
		}

		public void Show(Object sender, EventArgs e)
		{
			// >> alert-custom-content-cs
			TKAlert alert = new TKAlert ();
			alert.Style.HeaderHeight = 0;
			alert.TintColor = new UIColor (0.5f, 0.7f, 0.2f, 1f);
			alert.CustomFrame  = new CGRect ((this.View.Frame.Size.Width - 300) / 2, 100, 300, 250);
			AlertCustomContentView view = new AlertCustomContentView (new CGRect(0, 0, 300, 210));
			alert.ContentView.AddSubview (view);
			// << alert-custom-content-cs

			alert.AllowParallaxEffect = true;
			alert.Style.CenterFrame = true;

			// >> alert-animation-cs
			alert.Style.ShowAnimation = TKAlertAnimation.Scale;
			alert.Style.DismissAnimation = TKAlertAnimation.Scale;
			// << alert-animation-cs

			// >> alert-tint-dim-cs
			alert.Style.BackgroundDimAlpha = 0.5f;
			alert.Style.BackgroundTintColor = UIColor.LightGray;
			// << alert-tint-dim-cs

			// >> alert-anim-duration-cs
			alert.AnimationDuration = 0.5f;
			// << alert-anim-duration-cs

			alert.AddActionWithTitle("Done", (TKAlert al, TKAlertAction action) => true) ;
			alert.Show (true);
		}
	}
}

