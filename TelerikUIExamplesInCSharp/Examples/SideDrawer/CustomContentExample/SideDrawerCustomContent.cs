using System;
using UIKit;
using Foundation;
using CoreGraphics;
using ObjCRuntime;
using TelerikUI;

namespace Examples
{
	[Register("SideDrawerCustomContent")]
	public class SideDrawerCustomContent : SideDrawerGettingStarted
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.NavItem.Title = "Custom Content";
			this.SideDrawerView.SideDrawers[0].Content = this.SetupContent ();
		}

		public UIView SetupContent()
		{
			UIView sideDrawerContent = new UIView ();
			sideDrawerContent.BackgroundColor = UIColor.Clear;
			UIImageView imageView = new UIImageView (UIImage.FromBundle ("logo.png"));
			imageView.Frame = new CGRect ((float)this.SideDrawerView.SideDrawers[0].Width / 2.0f - imageView.Frame.Size.Width / 2.0f, this.View.Frame.Size.Height / 2.0f - imageView.Frame.Size.Height, 
				imageView.Frame.Size.Width, imageView.Frame.Size.Height);
			sideDrawerContent.AddSubview (imageView);

			return sideDrawerContent;
		}
	}
}

