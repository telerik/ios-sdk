using System;
using UIKit;
using Foundation;
using CoreGraphics;
using ObjCRuntime;
using TelerikUI;

namespace Examples
{
	public class SideDrawerPositions : SideDrawerTransitions
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.NavItem.Title = "Positions";
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.TransitionType = TKSideDrawerTransitionType.Reveal;
			sideDrawer.Fill = new TKSolidFill (UIColor.Gray);
		}

		public override void AddButtons ()
		{
			this.CreateButton ("Left", this, new Selector ("LeftSideDrawer"));
			this.CreateButton ("Right", this, new Selector ("RightSideDrawer"));
			this.CreateButton ("Top", this, new Selector ("TopSideDrawer"));
			this.CreateButton ("Bottom", this, new Selector ("BottomSideDrawer"));
		}

		[Export ("LeftSideDrawer")]
		private void LeftSideDrawer()
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.Position = TKSideDrawerPosition.Left;
			sideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			sideDrawer.Show ();
		}

		[Export ("RightSideDrawer")]
		private void RightSideDrawer()
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.Position = TKSideDrawerPosition.Right;
			sideDrawer.HeaderView = new SideDrawerHeader (true, this, new Selector ("DismissSideDrawer"));
			sideDrawer.Show ();
		}

		[Export ("TopSideDrawer")]
		private void TopSideDrawer()
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.Position = TKSideDrawerPosition.Top;
			sideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			TKSideDrawerTableView table = (TKSideDrawerTableView)sideDrawer.Content;
			table.SetContentOffset (CGPoint.Empty, false);
			sideDrawer.AllowScroll = true;
			sideDrawer.Show ();
		}

		[Export ("BottomSideDrawer")]
		private void BottomSideDrawer() 
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.Position = TKSideDrawerPosition.Bottom;
			sideDrawer.HeaderView = new SideDrawerHeader (true, this, new Selector ("DismissSideDrawer"));
			TKSideDrawerTableView table = (TKSideDrawerTableView)sideDrawer.Content;
			table.SetContentOffset (CGPoint.Empty, false);
			sideDrawer.AllowScroll = true;
			sideDrawer.Show ();
		}
	}
}

