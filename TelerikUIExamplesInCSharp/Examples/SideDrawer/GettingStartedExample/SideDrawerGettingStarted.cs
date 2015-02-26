using System;

using TelerikUI;

namespace Examples
{
	public class SideDrawerGettingStarted : ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			SideDrawerGettingStartedModalController contentController = new SideDrawerGettingStartedModalController ();
			TKSideDrawerController sideDrawerController = new TKSideDrawerController (contentController);
			this.NavigationController.PresentViewController (sideDrawerController, true, new Action (delegate {
				this.NavigationController.PopViewController (false);
			}));
		}
	}
}

