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
			this.SideDrawerView.SideDrawer.Width = 200;
			this.SideDrawerView.SideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			this.SideDrawerView.SideDrawer.HeaderView = new SideDrawerHeader(false, this, new Selector("DismissSideDrawer"));
			MyTransition transition = new MyTransition (this.SideDrawerView.SideDrawer);
			this.SideDrawerView.SideDrawer.TransitionManager = transition;
		}
	}
}