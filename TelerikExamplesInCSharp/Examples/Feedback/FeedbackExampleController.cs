
using System;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;
using TelerikUI;

namespace Examples
{
	public partial class FeedbackExampleController : ExampleViewController
	{
		[Outlet("DescriptionLabel")]
		public UILabel DescriptionLabel {
			get;
			set;
		}

		public FeedbackExampleController ()
		{
		}

		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();
			
			// Release any cached data, images, etc that aren't in use.
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.ShowDescription ();
		}
			
		[Action("SendFeedback:")]
		public void SendFeedback(UIButton sender)
		{
			TKFeedbackController feedbackController = (TKFeedbackController)this.View.Window.RootViewController;
			feedbackController.ShowFeedback();
		}

		public void ShowDescription () 
		{
			if (UIDevice.CurrentDevice.UserInterfaceIdiom != UIUserInterfaceIdiom.Phone) {
				return;
			}

			RectangleF bounds = UIScreen.MainScreen.Bounds;
			if (bounds.Size.Height <= 480) {
				this.DescriptionLabel.Font = UIFont.FromName ("HelveticaNeue-Thin", 12);
				return;
			}

			this.DescriptionLabel.Font = UIFont.FromName ("HelveticaNeue-Thin", 15);
		}
	}
}

