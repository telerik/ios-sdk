using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	[Register("AlertGettingStarted")]
	public partial class AlertGettingStarted : XamarinExampleViewController
	{
		UILabel TextLabel = new UILabel();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TextLabel.Frame = new CGRect (0, 100, this.View.Bounds.Size.Width, 44);
			TextLabel.TextAlignment = UITextAlignment.Center;
			TextLabel.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleBottomMargin;
			TextLabel.Text = "Please, answer the question";
			TextLabel.Font = UIFont.SystemFontOfSize (12);
			this.View.AddSubview (TextLabel);

			UIButton_Circle.Button (this.View, "Answer Me", this, Show);
		}
	
		public void Show(Object sender, EventArgs e)
		{
			// >> getting-started-alert-cs
			TKAlert alert = new TKAlert ();
			alert.Title = "Chicken or the egg";
			alert.Message = "Which came first, the chicken or the egg?";
			// << getting-started-alert-cs

			alert.Style.MaxWidth = 210;
		
			// >> getting-started-alert-action-cs
			alert.AddActionWithTitle("Egg",  (TKAlert al, TKAlertAction action) => {
				TextLabel.Text = "It was the egg!";
				return true;
			});
				
			alert.AddActionWithTitle("Chicken",  (TKAlert al, TKAlertAction action) => {
				TextLabel.Text = "It was the chicken!";
				return true;
			});
			// << getting-started-alert-action-cs

			// >> getting-started-alert-show-cs
			alert.Show (true);
			// << getting-started-alert-show-cs
		}
	}
}

