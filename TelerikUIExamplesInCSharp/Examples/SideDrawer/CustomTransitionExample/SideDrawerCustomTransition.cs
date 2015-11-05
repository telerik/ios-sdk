using System;
using UIKit;
using Foundation;
using CoreGraphics;
using ObjCRuntime;
using TelerikUI;

namespace Examples
{
	public class SideDrawerCustomTransition : SideDrawerGettingStarted
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.NavItem.Title = "Custom Transition";
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.Width = 200;
			sideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			sideDrawer.HeaderView = new SideDrawerHeader(false, this, new Selector("DismissSideDrawer"));
			MyTransition transition = new MyTransition (sideDrawer);
			sideDrawer.TransitionManager = transition;
		}
	}
}