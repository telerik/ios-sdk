using System;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("CalendarViewModes")]
	public class CalendarViewModes : XamarinExampleViewController
	{
		CalendarDelegate calendarDelegate;

		public TKCalendar CalendarView {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			this.AddOption ("Year", SelectYear);
			this.AddOption ("Month", SelectMonth);
			this.AddOption ("Month Names", SelectMonthNames);
			this.AddOption ("Year Numbers", SelectYearNumbers);
			this.AddOption ("Flow", SelectFlow);
			this.AddOption ("Week view", SelectWeekView);

			base.ViewDidLoad ();

			NSCalendar calendar = new NSCalendar (NSCalendarType.Gregorian);
			calendar.FirstWeekDay = 2;
			NSDate date = NSDate.Now;
			NSDateComponents components = new NSDateComponents ();
			components.Year = -10;
			NSDate minDate = calendar.DateByAddingComponents (components, date, (NSCalendarOptions)0);
			components.Year = 10;
			NSDate maxDate = calendar.DateByAddingComponents (components, date, (NSCalendarOptions)0);

			this.CalendarView = new TKCalendar (this.View.Bounds);
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (this.CalendarView);

			this.calendarDelegate = new CalendarDelegate(this);

			this.CalendarView.Delegate = calendarDelegate;
			this.CalendarView.ViewMode = TKCalendarViewMode.Year;
			this.CalendarView.Calendar = calendar;
			this.CalendarView.MinDate = minDate;
			this.CalendarView.MaxDate = maxDate;
			this.CalendarView.NavigateToDate (date, false);
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();
			if (this.CalendarView.ViewMode == TKCalendarViewMode.Week) {
				this.CalendarView.Frame = new CGRect (0, 0, this.View.Bounds.Width, 100);
			} else {
				this.CalendarView.Frame = this.View.Bounds;
			}
		}

		public void SelectYear ()
		{
			this.CalendarView.ViewMode = TKCalendarViewMode.Year;
		}

		public void SelectMonth ()
		{
			this.CalendarView.ViewMode = TKCalendarViewMode.Month;
		}

		public void SelectMonthNames ()
		{
			this.CalendarView.ViewMode = TKCalendarViewMode.MonthNames;
		}

		public void SelectYearNumbers ()
		{
			this.CalendarView.ViewMode = TKCalendarViewMode.YearNumbers;
		}

		public void SelectFlow ()
		{
			this.CalendarView.ViewMode = TKCalendarViewMode.Flow;
		}

		public void SelectWeekView ()
		{
			this.CalendarView.ViewMode = TKCalendarViewMode.Week;
		}

		class CalendarDelegate : TKCalendarDelegate
		{
			CalendarViewModes main;
			public CalendarDelegate (CalendarViewModes main)
			{
				this.main = main;
			}

			public override void DidChangedViewModeFrom (TKCalendar calendar, TKCalendarViewMode previousViewMode, TKCalendarViewMode viewMode)
			{
				if (viewMode == TKCalendarViewMode.Week || previousViewMode == TKCalendarViewMode.Week) {
					this.main.View.SetNeedsLayout ();
				}
			}
		}
	}


}

