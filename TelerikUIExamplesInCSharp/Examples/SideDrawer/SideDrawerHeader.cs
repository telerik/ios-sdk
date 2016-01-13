using System;

using ObjCRuntime;
using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class SideDrawerHeader : UIView
	{
		TKSideDrawerHeader sideDrawerHeader;

		public SideDrawerHeader (bool addButton, NSObject target, Selector selector)
		{
			sideDrawerHeader = new TKSideDrawerHeader ("Navigation Menu");
			sideDrawerHeader.ContentInsets = new UIEdgeInsets (0, 0, 0, 0);
			if (addButton) {
				UIButton button = UIButton.FromType (UIButtonType.System);
				button.SetImage (UIImage.FromBundle ("menu.png"), UIControlState.Normal);
				button.AddTarget (target, selector, UIControlEvent.TouchUpInside);
				sideDrawerHeader.ActionButton = button;
				sideDrawerHeader.ContentInsets = new UIEdgeInsets (0, -20, 0, 0);
				sideDrawerHeader.ButtonPosition = TKSideDrawerHeaderButtonPosition.Left;
			}

			this.AddSubview (sideDrawerHeader);
		}
			
		public override void LayoutSubviews ()
		{
			sideDrawerHeader.Frame = this.Bounds;
		}
	}
}

