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
			// >> view-modes-pinchzoom-cs
			this.CalendarView.AllowPinchZoom = false;
			// << view-modes-pinchzoom-cs
			this.CalendarView.NavigateToDate (date, false);

			// >> view-modes-presenter-cs
			TKCalendarYearPresenter presenter = (TKCalendarYearPresenter)this.CalendarView.Presenter;
			presenter.Columns = 3;
			// << view-modes-presenter-cs
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
			// >> getting-started-viewmodeyear-cs
			this.CalendarView.ViewMode = TKCalendarViewMode.Year;
			// << getting-started-viewmodeyear-cs
		}

		public void SelectMonth ()
		{
			// >> view-modes-month-cs
			this.CalendarView.ViewMode = TKCalendarViewMode.Month;
			// << view-modes-month-cs
		}

		public void SelectMonthNames ()
		{
			// >> view-modes-monthnames-cs
			this.CalendarView.ViewMode = TKCalendarViewMode.MonthNames;
			// << view-modes-monthnames-cs
		}

		public void SelectYearNumbers ()
		{
			// >> view-modes-yearnumber-cs
			this.CalendarView.ViewMode = TKCalendarViewMode.YearNumbers;
			// << view-modes-yearnumber-cs
		}

		public void SelectFlow ()
		{
			// >> view-modes-flow-cs
			this.CalendarView.ViewMode = TKCalendarViewMode.Flow;
			// << view-modes-flow-cs
		}

		public void SelectWeekView ()
		{
			// >> view-modes-week-cs
			this.CalendarView.ViewMode = TKCalendarViewMode.Week;
			// << view-modes-week-cs
		}

		class CalendarDelegate : TKCalendarDelegate
		{
			CalendarViewModes main;
			public CalendarDelegate (CalendarViewModes main)
			{
				this.main = main;
			}
			// >> view-modes-changeviewmode-cs
			public override void DidChangedViewModeFrom (TKCalendar calendar, TKCalendarViewMode previousViewMode, TKCalendarViewMode viewMode)
			{
				if (viewMode == TKCalendarViewMode.Week || previousViewMode == TKCalendarViewMode.Week) {
					this.main.View.SetNeedsLayout ();
				}
			}
			// << view-modes-changeviewmode-cs
		}
	}


}

