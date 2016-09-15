using System;
using System.Drawing;

using Foundation;
using UIKit;
using ObjCRuntime;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("iOS7StyleCalendar")]
	public class iOS7StyleCalendar : XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			UIButton button = new UIButton (UIButtonType.System);
			button.SetTitle ("Tap to load iOS 7 style calendar", UIControlState.Normal);
			button.AddTarget (this, new Selector ("ButtonTouched"), UIControlEvent.TouchUpInside);
			button.Frame = new CGRect (0, this.View.Bounds.Size.Height / 2f - 20f, this.View.Bounds.Size.Width, 40f);
			button.AutoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleTopMargin |
			UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin;

			this.View.AddSubview (button);
		}

		[Export ("ButtonTouched")]
		public void ButtonTouched ()
		{
			this.Title = "Back";
			// >> localization-firstweekday-cs
			NSCalendar calendar = new NSCalendar (NSCalendarType.Gregorian);
			calendar.FirstWeekDay = 2;
			// << localization-firstweekday-cs

			// >> view-modes-viewcontroller-cs
			TKCalendarYearViewController controller = new TKCalendarYearViewController ();
			controller.ContentView.MinDate = TKCalendar.DateWithYear (2012, 1, 1, calendar);
			controller.ContentView.MaxDate = TKCalendar.DateWithYear (2018, 12, 31, calendar);
			controller.ContentView.NavigateToDate (NSDate.Now, false);
			this.NavigationController.PushViewController (controller, true);
			// << view-modes-viewcontroller-cs
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);

			this.Title = "iOS 7 style calendar";
			this.NavigationController.Delegate = null;
		}
	}
}

