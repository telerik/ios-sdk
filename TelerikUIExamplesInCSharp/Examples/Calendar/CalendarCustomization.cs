using System;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("CalendarCustomization")]
	public class CalendarCustomization : XamarinExampleViewController
	{
		CalendarDelegate calendarDelegate = new CalendarDelegate();
		public TKCalendar CalendarView {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.CalendarView = new TKCalendar (new RectangleF ());
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.CalendarView.Delegate = calendarDelegate;
			this.View.AddSubview (this.CalendarView);

			NSDate date = NSDate.Now;
			NSDateComponents components = new NSDateComponents ();
			components.Year = -1;
			this.CalendarView.MinDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);
			components.Year = 1;
			this.CalendarView.MaxDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);

			UIImage img = UIImage.FromBundle ("calendar_header.png");
	    
			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)this.CalendarView.Presenter;
			presenter.Style.TitleCellHeight = 20;
			presenter.HeaderView.ContentMode = UIViewContentMode.ScaleToFill;
			presenter.HeaderView.BackgroundColor = UIColor.FromPatternImage (img);
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();
			nfloat width = (nfloat)Math.Min (this.View.Bounds.Width, this.View.Bounds.Height);
			this.CalendarView.Frame = new CGRect (0, 0, width, width);
		}

		class CalendarDelegate : TKCalendarDelegate
		{
			public override TKCalendarCell ViewForCellOfKind (TKCalendar calendar, TKCalendarCellType cellType)
			{
				if (cellType == TKCalendarCellType.Day) {
					return new CustomCell ();
				}

				return null;
			}
		}

	}
}

