using System;

using TelerikUI;

namespace Examples
{
	public class SideDrawerCustomTransition : ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			SideDrawerCustomTransitionModalController transitionController = new SideDrawerCustomTransitionModalController ();
			TKSideDrawerController sideDrawerController = new TKSideDrawerController (transitionController);
			this.NavigationController.PresentViewController (sideDrawerController, true, delegate {
				this.NavigationController.PopViewController (false);
			});
		}
	}
}

