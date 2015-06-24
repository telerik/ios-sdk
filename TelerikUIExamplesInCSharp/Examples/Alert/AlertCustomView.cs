using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	public class AlertCustomView : ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			UIButton_Circle.Button (this.View, "Show Alert", this, Show);
		}

		public void Show(Object sender, EventArgs e)
		{
			TKAlert alert = new TKAlert ();

			alert.Style.HeaderHeight = 0;
			alert.TintColor = new UIColor (0.5f, 0.7f, 0.2f, 1f);
			alert.CustomFrame  = new CGRect ((this.View.Frame.Size.Width - 300) / 2, 100, 300, 250);
			alert.AllowParallaxEffect = true;
			alert.Style.CenterFrame = true;

			AlertCustomContentView view = new AlertCustomContentView (new CGRect(0, 0, 300, 210));
			alert.ContentView.AddSubview (view);
			alert.AddActionWithTitle("Done", (TKAlert al, TKAlertAction action) => true) ;

			alert.Show (true);
		}
	}
}

