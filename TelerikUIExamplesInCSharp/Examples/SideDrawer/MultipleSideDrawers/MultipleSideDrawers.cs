using System;
using UIKit;
using Foundation;
using CoreGraphics;
using ObjCRuntime;
using TelerikUI;

namespace Examples
{
	[Register("MultipleSideDrawers")]
	public class MultipleSideDrawers : XamarinExampleViewController
	{
		private TKSideDrawerSection primarySection;
		private TKSideDrawerSection labelsSection;
		private TKSideDrawerSection inboxSection;
		private TKSideDrawerSection mobileSection;
		SideDrawerDelegate sideDrawerDelegate;

		public UINavigationItem NavItem {
			get;
			set;
		}

		public TKSideDrawerView SideDrawerView {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.SideDrawerView = new TKSideDrawerView (this.View.Bounds);
			this.SideDrawerView.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			this.View.AddSubview (this.SideDrawerView);

			UIImageView backgroundView = new UIImageView (this.SideDrawerView.MainView.Bounds);
			backgroundView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			backgroundView.Image = UIImage.FromBundle ("sdk-examples-bg.png");
			this.SideDrawerView.MainView.AddSubview (backgroundView);

			UINavigationBar navBar = new UINavigationBar (new CGRect (0, 0, this.SideDrawerView.MainView.Bounds.Width, 44));
			navBar.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			this.NavItem = new UINavigationItem ();

			UIBarButtonItem showLeftSideDrawer = new UIBarButtonItem (UIImage.FromBundle ("menu.png"), UIBarButtonItemStyle.Plain, this, new Selector ("ShowLeftSideDrawer"));
			this.NavItem.LeftBarButtonItem = showLeftSideDrawer;
			UIBarButtonItem showRightSideDrawer = new UIBarButtonItem (UIImage.FromBundle ("menu.png"), UIBarButtonItemStyle.Plain, this, new Selector ("ShowRightSideDrawer"));
			this.NavItem.RightBarButtonItem = showRightSideDrawer;

			navBar.Items = new UINavigationItem[] { this.NavItem };
			this.SideDrawerView.MainView.AddSubview (navBar);

			primarySection = new TKSideDrawerSection ("Primary");
			primarySection.AddItem ("Social");
			primarySection.AddItem ("Promotions");

			labelsSection = new TKSideDrawerSection ("Labels");
			labelsSection.AddItem ("Important");
			labelsSection.AddItem ("Starred");
			labelsSection.AddItem ("Sent Mail");
			labelsSection.AddItem ("Drafts");

			this.sideDrawerDelegate = new SideDrawerDelegate ();
			TKSideDrawer sideDrawerRight = this.SideDrawerView.AddSideDrawer (TKSideDrawerPosition.Right);
			sideDrawerRight.HeaderView = new SideDrawerHeader (true, this, new Selector ("DismissRightSideDrawer"));
			sideDrawerRight.AddSection (primarySection);
			sideDrawerRight.AddSection (labelsSection);
			sideDrawerRight.Delegate = this.sideDrawerDelegate;
			sideDrawerRight.Style.HeaderHeight = 44;

			inboxSection = new TKSideDrawerSection ("Inbox");
			inboxSection.AddItem ("Sent Items");
			inboxSection.AddItem ("Deleted Items");
			inboxSection.AddItem ("Outbox");

			mobileSection = new TKSideDrawerSection ("Mobile");
			mobileSection.AddItem ("iOS");
			mobileSection.AddItem ("Android");
			mobileSection.AddItem ("Windows Phone");

			this.sideDrawerDelegate = new SideDrawerDelegate ();
			TKSideDrawer sideDrawerLeft = this.SideDrawerView.SideDrawers[0];
			sideDrawerLeft.HeaderView = new SideDrawerHeader (true, this, new Selector ("DismissLeftSideDrawer"));
			sideDrawerLeft.AddSection (inboxSection);
			sideDrawerLeft.AddSection (mobileSection);
			sideDrawerLeft.Delegate = this.sideDrawerDelegate;
			sideDrawerLeft.Style.HeaderHeight = 44;
		}

		public override void ViewWillDisappear (bool animated)
		{
			base.ViewWillDisappear (animated);
			this.NavigationController.InteractivePopGestureRecognizer.Enabled = true;
		}

		[Export ("ShowLeftSideDrawer")]
		public void ShowLeftSideDrawer()
		{
			this.SideDrawerView.SideDrawers[0].Show();
		}

		[Export ("ShowRightSideDrawer")]
		public void ShowRightSideDrawer()
		{
			this.SideDrawerView.SideDrawers[1].Show();
		}

		[Export ("DismissLeftSideDrawer")]
		public void DismissLeftSideDrawer()
		{
			this.SideDrawerView.SideDrawers[0].Dismiss();
		}

		[Export ("DismissRightSideDrawer")]
		public void DismissRightSideDrawer()
		{
			this.SideDrawerView.SideDrawers[1].Dismiss();
		}

		class SideDrawerDelegate : TKSideDrawerDelegate
		{
			public override void UpdateVisualsForSection (TKSideDrawer sideDrawer, int sectionIndex)
			{
				TKSideDrawerSection section = sideDrawer.Sections[sectionIndex];
				section.Style.ContentInsets = new UIEdgeInsets (0, -15, 0, 0);
			}

			public override void UpdateVisualsForItem (TKSideDrawer sideDrawer, NSIndexPath indexPath)
			{
				TKSideDrawerItem item = sideDrawer.Sections[indexPath.Section].Items[indexPath.Item];
				item.Style.ContentInsets = new UIEdgeInsets (0, -5, 0, 0);
				item.Style.SeparatorColor = new TKSolidFill (UIColor.Clear);
			}
		}
	}
}

