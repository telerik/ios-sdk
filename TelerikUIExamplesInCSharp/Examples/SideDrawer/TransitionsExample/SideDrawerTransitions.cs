using System;

using TelerikUI;

namespace Examples
{
	public class SideDrawerTransitions : ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			SideDrawerTransitionsModalController transitionsController = new SideDrawerTransitionsModalController ();
			TKSideDrawerController sideDrawercontroller = new TKSideDrawerController (transitionsController);
			this.NavigationController.PresentViewController (sideDrawercontroller, true, delegate {
				this.NavigationController.PopViewController (false);
			});
		}
	}
}

