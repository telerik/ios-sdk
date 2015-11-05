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
			
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.DataSource = new TKCalendarEventKitDataSource ();
			this.CalendarView = new TKCalendar (this.View.Bounds);
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.CalendarView.DataSource = this.DataSource;
			this.View.AddSubview (this.CalendarView);

			NSDate date = NSDate.Now;
			NSDateComponents components = new NSDateComponents ();
			components.Year = -1;
			this.CalendarView.MinDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);
			components.Year = 1;
			this.CalendarView.MaxDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);
		}
	}
}

