using System;

using ObjCRuntime;
using Foundation;
using UIKit;
using CoreAnimation;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class SideDrawerCustomContentModalController : SideDrawerGettingStartedModalController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.SideDrawer.Content = this.SetupContent ();
		}

		public UIView SetupContent()
		{
			UIView sideDrawerContent = new UIView ();
			sideDrawerContent.BackgroundColor = UIColor.Clear;
			UIImageView imageView = new UIImageView (new UIImage ("logo"));
			imageView.Frame = new CGRect ((float)this.SideDrawer.Width / 2.0f - imageView.Frame.Size.Width / 2.0f, this.View.Frame.Size.Height / 2.0f - imageView.Frame.Size.Height, 
				imageView.Frame.Size.Width, imageView.Frame.Size.Height);
			sideDrawerContent.AddSubview (imageView);

			return sideDrawerContent;
		}
	}
}

