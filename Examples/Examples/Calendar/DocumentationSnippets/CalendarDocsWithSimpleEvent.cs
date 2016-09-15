using System;
using System.Linq;
using Foundation;
using UIKit;
using System.Collections.Generic;

using TelerikUI;

namespace Examples
{
	[Register("CalendarDocsWithSimpleEvent")]
// >> getting-started-example-cs

	public class CalendarDocsWithSimpleEvent : XamarinExampleViewController
	{
		CalendarDelegate calendarDelegate;
		List<TKCalendarEvent> events;

		public TKCalendar CalendarView {
			get;
			set;
		}

		public TKCalendarEventProtocol[] EventsForDate {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
// >> getting-started-calendar-cs
			TKCalendar calendarView = new TKCalendar (this.View.Bounds);
			calendarView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (calendarView);
// << getting-started-calendar-cs

			calendarDelegate = new CalendarDelegate ();

// >> getting-started-assigndatasource-cs
			calendarView.DataSource = new CalendarDataSource (this);
// << getting-started-assigndatasource-cs

// >> getting-started-event-cs
			events = new List<TKCalendarEvent> ();
			NSCalendar calendar = new NSCalendar (NSCalendarType.Gregorian);
			NSDate date = NSDate.Now;

			Random r = new Random ();
			for (int i = 0; i < 3; i++) {
				TKCalendarEvent ev = new TKCalendarEvent ();
				ev.Title = "Sample event";
				NSDateComponents components = calendar.Components (NSCalendarUnit.Day | NSCalendarUnit.Month | NSCalendarUnit.Year, date);
				components.Day = r.Next () % 20;
				ev.StartDate = calendar.DateFromComponents (components);
				ev.EndDate = calendar.DateFromComponents (components);
				ev.EventColor = UIColor.Red;
				events.Add (ev);
			}
// << getting-started-event-cs

// >> getting-started-minmaxdate-cs
			calendarView.MinDate = TKCalendar.DateWithYear (2010, 1, 1, calendar);
			calendarView.MaxDate = TKCalendar.DateWithYear (2016, 12, 31, calendar);
// << getting-started-minmaxdate-cs

//			calendarDelegate.events = this.events;
			calendarView.Delegate = calendarDelegate;
	
// >> getting-started-navigatetodate-cs
			NSDateComponents newComponents = new NSDateComponents();
			newComponents.Year = 2015;
			newComponents.Month = 5;
			newComponents.Day = 1;
			NSDate newDate = calendarView.Calendar.DateFromComponents (newComponents);
// >> navigation-navigate-cs
			calendarView.NavigateToDate (newDate, true);
// << navigation-navigate-cs
// << getting-started-navigatetodate-cs

			calendarView.ReloadData();
		}

// >> getting-started-datasource-cs
		class CalendarDataSource : TKCalendarDataSource
// << getting-started-datasource-cs
		{
			CalendarDocsWithSimpleEvent main;
			public List<TKCalendarEvent> events;
			public CalendarDataSource(CalendarDocsWithSimpleEvent main)
			{
				this.main = main;
			}

// >> getting-started-eventsfordate-cs
			public TKCalendarEventProtocol[] EventsForDate (TKCalendar calendar, NSDate date)
			{
				NSDateComponents components = calendar.Calendar.Components (NSCalendarUnit.Day | NSCalendarUnit.Month | NSCalendarUnit.Year, date);
				components.Hour = 23;
				components.Minute = 59;
				components.Second = 59;
				NSDate endDate = calendar.Calendar.DateFromComponents (components);
				List<TKCalendarEventProtocol> filteredEvents = new List<TKCalendarEventProtocol> ();
					for (int i = 0; i < this.events.Count; i++) {
						TKCalendarEventProtocol ev = this.events[i];
						if (ev.StartDate.SecondsSinceReferenceDate <= endDate.SecondsSinceReferenceDate && 
							ev.EndDate.SecondsSinceReferenceDate >= date.SecondsSinceReferenceDate) {
							filteredEvents.Add (ev);
						}
				}
				return filteredEvents.ToArray ();
			}
// << getting-started-eventsfordate-cs
		}

// >> getting-started-didselectdate-cs
		class CalendarDelegate : TKCalendarDelegate
		{
			public override void DidSelectDate (TKCalendar calendar, NSDate date)
			{
				Console.WriteLine ("{0}", date);
			}
		}
// << getting-started-didselectdate-cs			
	
}

// << getting-started-example-cs


}

//// >> getting-started-datasource-cs	
//	class CalendarDelegate : TKCalendarDelegate
//// << getting-started-datasource-cs
//	{
//		public List<TKCalendarEvent> events;
//
//		public override void DidSelectDate (TKCalendar calendar, NSDate date)
//		{
//			Console.WriteLine ("{0}", date);
//		}
//
//		public TKCalendarEventProtocol[] EventsForDate (TKCalendar calendar, NSDate date)
//		{
//			NSDateComponents components = calendar.Calendar.Components (NSCalendarUnit.Day | NSCalendarUnit.Month | NSCalendarUnit.Year, date);
//			components.Hour = 23;
//			components.Minute = 59;
//			components.Second = 59;
//			NSDate endDate = calendar.Calendar.DateFromComponents (components);
//			List<TKCalendarEventProtocol> filteredEvents = new List<TKCalendarEventProtocol> ();
//				for (int i = 0; i < this.events.Count; i++) {
//				TKCalendarEventProtocol ev = this.events[i];
//				if (ev.StartDate.SecondsSinceReferenceDate <= endDate.SecondsSinceReferenceDate && 
//					ev.EndDate.SecondsSinceReferenceDate >= date.SecondsSinceReferenceDate) {
//					filteredEvents.Add (ev);
//				}
//			}
//			return filteredEvents.ToArray ();
//		}
//	}

