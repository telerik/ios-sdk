using System;
using System.Drawing;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class CalendarEventKitDataBinding : ExampleViewController
	{
		public TKCalendar CalendarView {
			get;
			set;
		}

		public TKCalendarEventKitDataSource DataSource {
			get;
			set;
		}

		public CalendarEventKitDataBinding ()
		{

		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.DataSource = new TKCalendarEventKitDataSource ();
			this.CalendarView = new TKCalendar (this.View.Bounds);
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.CalendarView.DataSource = this.DataSource;
			this.View.AddSubview (this.CalendarView);
		}
	}
}

