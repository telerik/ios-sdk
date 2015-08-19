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
			this.AddOption ("Islamic", SelectIslamic);

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
			this.CalendarView.Presenter.Update (false);
		}

		public void SelectGerman (object sender, EventArgs e)
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Gregorian);
			this.CalendarView.Locale = new NSLocale ("de_DE");
			this.CalendarView.Presenter.Update (false);
		}

		public void SelectHebrew (object sender, EventArgs e)
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Hebrew);
			this.CalendarView.Locale = new NSLocale ("he_IL");
			this.CalendarView.Presenter.Update (false);
		}

		public void SelectChinese (object sender, EventArgs e)
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Chinese);
			this.CalendarView.Locale = new NSLocale ("zh_Hans_SG");
			this.CalendarView.Presenter.Update (false);
		}

		public void SelectIslamic (object sender, EventArgs e)
		{
			this.CalendarView.Calendar = new NSCalendar (NSCalendarType.Islamic);
			this.CalendarView.Locale = new NSLocale ("ar-QA");
			this.CalendarView.Presenter.Update (false);
		}
	}
}