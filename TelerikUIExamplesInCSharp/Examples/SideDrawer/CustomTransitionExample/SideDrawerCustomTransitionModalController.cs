using System;

using ObjCRuntime;
using Foundation;
using UIKit;
using CoreAnimation;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class SideDrawerCustomTransitionModalController : SideDrawerGettingStartedModalController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.SideDrawer.Superview.BackgroundColor = UIColor.Gray;
			this.SideDrawer.Width = 200;
			this.SideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			this.SideDrawer.HeaderView = new SideDrawerHeader(false, this, new Selector("DismissSideDrawer"));
			ScaleContentTransition transition = new ScaleContentTransition (this.SideDrawer);
			this.SideDrawer.TransitionManager = transition;
		}
	}
}

