using System;

using ObjCRuntime;
using Foundation;
using UIKit;
using CoreAnimation;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class SideDrawerPositionsModalController : SideDrawerTransitionsModalController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.SideDrawer.Transition = TKSideDrawerTransitionType.Reveal;
			this.SideDrawer.Fill = new TKSolidFill (UIColor.Gray);
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
			this.SideDrawer.Position = TKSideDrawerPosition.Left;
			this.SideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			this.SideDrawer.Show ();
		}

		[Export ("RightSideDrawer")]
		private void RightSideDrawer()
		{
			this.SideDrawer.Position = TKSideDrawerPosition.Right;
			this.SideDrawer.HeaderView = new SideDrawerHeader (true, this, new Selector ("DismissSideDrawer"));
			this.SideDrawer.Show ();
		}

		[Export ("TopSideDrawer")]
		private void TopSideDrawer()
		{
			this.SideDrawer.Position = TKSideDrawerPosition.Top;
			this.SideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			TKSideDrawerTableView table = (TKSideDrawerTableView)this.SideDrawer.Content;
			table.TableView.SetContentOffset (CGPoint.Empty, false);
			this.SideDrawer.AllowScroll = true;
			this.SideDrawer.Show ();
		}

		[Export ("BottomSideDrawer")]
		private void BottomSideDrawer() 
		{
			this.SideDrawer.Position = TKSideDrawerPosition.Bottom;
			this.SideDrawer.HeaderView = new SideDrawerHeader (true, this, new Selector ("DismissSideDrawer"));
			TKSideDrawerTableView table = (TKSideDrawerTableView)this.SideDrawer.Content;
			table.TableView.SetContentOffset (CGPoint.Empty, false);
			this.SideDrawer.AllowScroll = true;
			this.SideDrawer.Show ();
		}
	}
}

