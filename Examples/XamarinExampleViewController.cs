using System;
using TelerikUI;
using UIKit;

namespace Examples
{
	public class XamarinExampleViewController: TKExamplesExampleViewController
	{
		public override void DidMoveToParentViewController (UIViewController parent)
		{
			base.DidMoveToParentViewController (parent);
			if (parent == null) {
				this.View.Dispose ();
				this.Dispose ();
				GC.Collect (GC.MaxGeneration, GCCollectionMode.Forced);
			}
		}
	}
}

