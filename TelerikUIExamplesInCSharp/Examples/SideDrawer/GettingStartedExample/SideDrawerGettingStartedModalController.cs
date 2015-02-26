using System;

using ObjCRuntime;
using Foundation;
using UIKit;
using CoreAnimation;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class SideDrawerGettingStartedModalController : UIViewController
	{
		private TKSideDrawerSection primarySection;
		private TKSideDrawerSection labelsSection;

		public TKSideDrawer SideDrawer {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			UIImageView backgroundView = new UIImageView (this.View.Bounds);
			backgroundView.Image = new UIImage ("sdk-examples-bg.png");
			this.View.AddSubview (backgroundView);

			UINavigationBar navBar = new UINavigationBar (new CGRect (0, 0, this.View.Frame.Size.Width, 64));
			UINavigationItem navItem = new UINavigationItem ("SideDrawer Examples");
			UIBarButtonItem closeButton = new UIBarButtonItem ("Close", UIBarButtonItemStyle.Done, this, new Selector ("Dismiss"));
			UIBarButtonItem showSideDrawer = new UIBarButtonItem (new UIImage ("menu.png"), UIBarButtonItemStyle.Plain, this, new Selector ("ShowSideDrawer"));
			navItem.RightBarButtonItem = closeButton;
			navItem.LeftBarButtonItem = showSideDrawer;
			navBar.Items = new UINavigationItem[] { navItem };
			this.View.AddSubview (navBar);

			primarySection = new TKSideDrawerSection ("Primary");
			primarySection.AddItem ("Social");
			primarySection.AddItem ("Promotions");

			labelsSection = new TKSideDrawerSection ("Labels");
			labelsSection.AddItem ("Important");
			labelsSection.AddItem ("Starred");
			labelsSection.AddItem ("Sent Mail");
			labelsSection.AddItem ("Drafts");

			SideDrawer = TKSideDrawer.FindSideDrawer (this);
			SideDrawer.HeaderView = new SideDrawerHeader (true, this, new Selector ("DismissSideDrawer"));
			SideDrawer.AddSection (primarySection);
			SideDrawer.AddSection (labelsSection);
			SideDrawer.Delegate = new SideDrawerDelegate();
			SideDrawer.Style.HeaderHeight = 64;
		}

		[Export ("Dismiss")]
		public void Dismiss()
		{
			this.PresentingViewController.DismissViewController(true, null);
		}

		[Export ("ShowSideDrawer")]
		public void ShowSideDrawer()
		{
			SideDrawer.Show();
		}

		[Export ("DismissSideDrawer")]
		public void DismissSideDrawer()
		{
			SideDrawer.Dismiss();
		}

		class SideDrawerDelegate : TKSideDrawerDelegate
		{
			public override void UpdateVisualsForSection (TKSideDrawer sideDrawer, int sectionIndex)
			{
				TKSideDrawerSection section = sideDrawer.Sections[sectionIndex];
				section.Style.ContentInsets = new UIEdgeInsets (0, -15, 0, 0);
			}

			public override void UpdateVisualsForItem (TKSideDrawer sideDrawer, int itemIndex, int sectionIndex)
			{
				TKSideDrawerItem item = sideDrawer.Sections[sectionIndex].Items[itemIndex];
				item.Style.ContentInsets = new UIEdgeInsets (0, -5, 0, 0);
				item.Style.SeparatorColor = new TKSolidFill (UIColor.Clear);
			}
		}
	}
}

