using System;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("LocalizedCalendar")]
	public class LocalizedCalendar : XamarinExampleViewController
	{
		public TKCalendar CalendarView {
			get;
			set;
		}
			
		public override void ViewDidLoad ()
		{
			this.AddOption ("Russian", SelectRussian);
			this.AddOption ("German", SelectGerman);
			this.AddOption ("Hebrew", SelectHebrew);
			this.AddOption ("Chinese", SelectChinese);
			this.AddOption ("Islamic", SelectIslamic);

			this.SelectedOption = 2;

			base.ViewDidLoad ();

			this.CalendarView = new TKCalendar (this.View.Bounds);
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			this.View.AddSubview (this.CalendarView);

			NSDate date = NSDate.Now;
			NSDateComponents components = new NSDateComponents ();
			components.Year = -1;
			this.CalendarView.MinDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);
			components.Year = 1;
			this.CalendarView.MaxDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);

			this.SelectHebrew ();
		}

		public void SelectRussian ()
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Gregorian);
			// >> localization-localeproperty-cs
			this.CalendarView.Locale = new NSLocale ("ru_RU");
			// << localization-localeproperty-cs
			this.CalendarView.ViewMode = TKCalendarViewMode.Month;
			((TKCalendarMonthPresenter)this.CalendarView.Presenter).Update (false);
		}

		public void SelectGerman ()
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Gregorian);
			this.CalendarView.Locale = new NSLocale ("de_DE");
			this.CalendarView.ViewMode = TKCalendarViewMode.Month;
			((TKCalendarMonthPresenter)this.CalendarView.Presenter).Update (false);
		}

		public void SelectHebrew ()
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Hebrew);
			this.CalendarView.Locale = new NSLocale ("he_IL");
			this.CalendarView.ViewMode = TKCalendarViewMode.Month;
			((TKCalendarMonthPresenter)this.CalendarView.Presenter).Update (false);
		}

		public void SelectChinese ()
		{
			// >> localization-chinesecalendar-cs
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Chinese);
			// << localization-chinesecalendar-cs
			this.CalendarView.Locale = new NSLocale ("zh_Hans_SG");
			this.CalendarView.ViewMode = TKCalendarViewMode.Month;
			((TKCalendarMonthPresenter)this.CalendarView.Presenter).Update (false);
		}

		public void SelectIslamic ()
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Islamic);
			this.CalendarView.Locale = new NSLocale ("ar-QA");
			this.CalendarView.ViewMode = TKCalendarViewMode.Month;
			// >> localization-update-cs
			((TKCalendarMonthPresenter)this.CalendarView.Presenter).Update (false);
			// << localization-update-cs
		}
	}
}