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
			this.SideDrawerView.SideDrawer.Transition = TKSideDrawerTransitionType.Reveal;
			this.SideDrawerView.SideDrawer.Fill = new TKSolidFill (UIColor.Gray);
		}

		public override void AddButtons ()
		{
			this.CreateButton ("Left", this, new Selector ("LeftSideDrawer"), new CGPoint (15, 80));
			this.CreateButton ("Right", this, new Selector ("RightSideDrawer"), new CGPoint (15, 130));
			this.CreateButton ("Top", this, new Selector ("TopSideDrawer"), new CGPoint (15, 180));
			this.CreateButton ("Bottom", this, new Selector ("BottomSideDrawer"), new CGPoint (15, 230));
		}

		[Export ("LeftSideDrawer")]
		private void LeftSideDrawer()
		{
			this.SideDrawerView.SideDrawer.Position = TKSideDrawerPosition.Left;
			this.SideDrawerView.SideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			this.SideDrawerView.SideDrawer.Show ();
		}

		[Export ("RightSideDrawer")]
		private void RightSideDrawer()
		{
			this.SideDrawerView.SideDrawer.Position = TKSideDrawerPosition.Right;
			this.SideDrawerView.SideDrawer.HeaderView = new SideDrawerHeader (true, this, new Selector ("DismissSideDrawer"));
			this.SideDrawerView.SideDrawer.Show ();
		}

		[Export ("TopSideDrawer")]
		private void TopSideDrawer()
		{
			this.SideDrawerView.SideDrawer.Position = TKSideDrawerPosition.Top;
			this.SideDrawerView.SideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			TKSideDrawerTableView table = (TKSideDrawerTableView)this.SideDrawerView.SideDrawerContentView;
			table.SetContentOffset (CGPoint.Empty, false);
			this.SideDrawerView.SideDrawer.AllowScroll = true;
			this.SideDrawerView.SideDrawer.Show ();
		}

		[Export ("BottomSideDrawer")]
		private void BottomSideDrawer() 
		{
			this.SideDrawerView.SideDrawer.Position = TKSideDrawerPosition.Bottom;
			this.SideDrawerView.SideDrawer.HeaderView = new SideDrawerHeader (true, this, new Selector ("DismissSideDrawer"));
			TKSideDrawerTableView table = (TKSideDrawerTableView)this.SideDrawerView.SideDrawerContentView;
			table.SetContentOffset (CGPoint.Empty, false);
			this.SideDrawerView.SideDrawer.AllowScroll = true;
			this.SideDrawerView.SideDrawer.Show ();
		}
	}
}

