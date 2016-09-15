using System;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("FeedbackExampleController")]
	public partial class FeedbackExampleController : XamarinExampleViewController
	{
		[Outlet("DescriptionLabel")]
		public UILabel DescriptionLabel {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			if (UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
				CGRect bounds = UIScreen.MainScreen.Bounds;
				if (bounds.Size.Height <= 480) {
					this.DescriptionLabel.Font = UIFont.FromName ("HelveticaNeue-Thin", 12);
				} else {
					this.DescriptionLabel.Font = UIFont.FromName ("HelveticaNeue-Thin", 15);
				}
			}

			// >> feedback-initialize-cs
			TKFeedback.SetDataSource(new TKPlatformFeedbackSource ("58cb0070-f612-11e3-b9fc-55b0b983d3be", "iosteam@telerik.com"));
			// << feedback-initialize-cs
		}

		// >> feedback-motion-cs
		public override void MotionEnded (UIEventSubtype motion, UIEvent evt)
		{
			// >> feedback-initialize-cs
			TKFeedback.ShowFeedback ();
			// << feedback-initialize-cs
		}
		// << feedback-motion-cs
			
		[Action("SendFeedback:")]
		public void SendFeedback(UIButton sender)
		{
			TKFeedback.ShowFeedback ();
		}
	}
}

