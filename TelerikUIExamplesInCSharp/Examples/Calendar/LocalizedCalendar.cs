using System;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class LocalizedCalendar : ExampleViewController
	{
		public TKCalendar CalendarView {
			get;
			set;
		}

		public LocalizedCalendar ()
		{
			this.AddOption ("Russian", SelectRussian);
			this.AddOption ("German", SelectGerman);
			this.AddOption ("Hebrew", SelectHebrew);
			this.AddOption ("Chinese", SelectChinese);
			this.SelectedOption = 2;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.CalendarView = new TKCalendar (this.View.Bounds);
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			this.View.AddSubview (this.CalendarView);
			this.SelectHebrew (this, EventArgs.Empty);
		}

		public void SelectRussian (object sender, EventArgs e)
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Gregorian);
			this.CalendarView.Locale = new NSLocale ("ru_RU");
			UpdateCalendar ();
		}

		public void SelectGerman (object sender, EventArgs e)
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Gregorian);
			this.CalendarView.Locale = new NSLocale ("de_DE");
			UpdateCalendar ();
		}

		public void SelectHebrew (object sender, EventArgs e)
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Hebrew);
			this.CalendarView.Locale = new NSLocale ("he_IL");
			UpdateCalendar ();
		}

		public void SelectChinese (object sender, EventArgs e)
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Chinese);
			this.CalendarView.Locale = new NSLocale ("zh_Hans_SG");
			UpdateCalendar ();
		}

		void UpdateCalendar()
		{
			if (this.CalendarView.Presenter.GetType () == typeof(TKCalendarMonthPresenter)) {
				((TKCalendarMonthPresenter)this.CalendarView.Presenter).Update (false);
			} else if (this.CalendarView.Presenter.GetType () == typeof(TKCalendarYearNumbersPresenter)) {
				((TKCalendarYearNumbersPresenter)this.CalendarView.Presenter).Update (false);
			} else {
				((TKCalendarMonthNamesPresenter)this.CalendarView.Presenter).Update (false);
			}
		}
	}
}