using System;

using TelerikUI;

namespace Examples
{
	public class SideDrawerPositions : ExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			SideDrawerPositionsModalController positionsController = new SideDrawerPositionsModalController ();
			TKSideDrawerController sideDrawerController = new TKSideDrawerController (positionsController);
			this.NavigationController.PresentViewController (sideDrawerController, true, delegate {
				this.NavigationController.PopViewController (false);
			});
		}
	}
}

