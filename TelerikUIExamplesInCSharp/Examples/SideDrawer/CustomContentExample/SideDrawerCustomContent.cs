using System;

using TelerikUI;

namespace Examples
{
	public class SideDrawerCustomContent : ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			SideDrawerCustomContentModalController contentController = new SideDrawerCustomContentModalController ();
			TKSideDrawerController sideDrawerController = new TKSideDrawerController (contentController);
			this.NavigationController.PresentViewController (sideDrawerController, true, delegate {
				this.NavigationController.PopViewController (false);
			});
		}
	}
}

