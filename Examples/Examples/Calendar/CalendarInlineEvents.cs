using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("CalendarInlineEvents")]
	public class CalendarInlineEvents : XamarinExampleViewController
	{
		CalendarDataSource calendarDataSource;

		public TKCalendarEventProtocol[] Events {
			get;
			set;
		}

		public TKCalendarEventProtocol[] EventsForDate {
			get;
			set;
		}
			
		public TKCalendar CalendarView {
			get;
			set;
		}

		public class MyInlineEventsView: TKCalendarInlineView 
		{
			[Export("tableView:didSelectRowAtIndexPath:")]
			public void DidSelectRow(UITableView tableView, NSIndexPath indexPath)
			{
				TKCalendarEvent e = (TKCalendarEvent)this.DayCell.Events [(int)indexPath.Row];
				UIAlertView alert = new UIAlertView ("Selected event", e.Title, null, "Done", null);
				alert.Show ();
			}
		}

		public override void ViewDidLoad ()
		{
			this.CreateEvents ();

			base.ViewDidLoad ();

			this.calendarDataSource = new CalendarDataSource (this);

			this.CalendarView = new TKCalendar (this.View.Bounds);
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.CalendarView.DataSource = this.calendarDataSource;
			this.View.AddSubview (this.CalendarView);

			NSDate date = NSDate.Now;
			NSDateComponents components = new NSDateComponents ();
			components.Year = -1;
			this.CalendarView.MinDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);
			components.Year = 1;
			this.CalendarView.MaxDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);

			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)this.CalendarView.Presenter;
			if (UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
				presenter.InlineEventsViewMode = TKCalendarInlineEventsViewMode.Popover;
			} else {
				presenter.InlineEventsViewMode = TKCalendarInlineEventsViewMode.Inline;
			}
			presenter.InlineEventsView = new MyInlineEventsView ();
			presenter.InlineEventsView.MaxHeight = 140;
			presenter.InlineEventsView.FixedHeight = false;
		}
			
		public void CreateEvents ()
		{
			List<TKCalendarEvent> eventsList = new List<TKCalendarEvent> ();
			string[] locations = new string[] { "Sofia", "London", "Paris", "New York", "San Francisco", "Home" };
			UIColor[] colors = new UIColor[] { 
				new UIColor (88f / 255f, 86f / 255f, 214f / 255f, 1f), 
				new UIColor (255f / 255f, 149f / 255f, 3f / 255f, 1f), 
				new UIColor (255f / 255, 45f / 255f, 85f / 255f, 1f), 
				new UIColor (76f / 255f, 217f / 255f, 100f / 255f, 1f), 
				new UIColor (255f / 255f, 204f / 255f, 3f / 255f, 1f)
			};

			string[] titles = new string[] {
				"Meeting with Jack",
				"Lunch with Peter",
				"Planning meeting",
				"Go shopping",
				"Very important meeting",
				"Another meeting",
				"Lorem ipsum"
			};

			Random r = new Random ();
			TKCalendarEvent calEvent = new TKCalendarEvent();
			calEvent.Title = "Two days event";
			calEvent.StartDate = this.DateWithOffset (1, 2);
			calEvent.EndDate = this.DateWithOffset (2, 4);
			calEvent.AllDay = true;
			calEvent.EventColor = colors [r.Next () % (colors.Length - 1)];
			eventsList.Add (calEvent);

			calEvent = new TKCalendarEvent ();
			calEvent.Title = "Three days event";
			calEvent.StartDate = this.DateWithOffset (2, 1);
			calEvent.EndDate = this.DateWithOffset (4, 2);
			calEvent.AllDay = true;
			calEvent.EventColor = colors [r.Next () % (colors.Length - 1)];
			eventsList.Add (calEvent);

			for (int i = 0; i < 3; i++) {
				calEvent = new TKCalendarEvent ();
				calEvent.Title = titles [r.Next () % (titles.Length - 1)];
				calEvent.StartDate = this.DateWithOffset (7, 1);
				calEvent.EndDate = this.DateWithOffset (7, 2);
				calEvent.AllDay = true;
				calEvent.EventColor = colors [r.Next () % (colors.Length - 1)];
				eventsList.Add (calEvent);
			}

			for (int i = 0; i < 5; i++) {
				int dayOffset = r.Next () % 20;
				if (dayOffset < 10) {
					dayOffset *= -1;
				} else {
					dayOffset -= 10;
				}

				int duration = r.Next () % 30;
				calEvent = new TKCalendarEvent ();
				calEvent.StartDate = this.DateWithOffset (dayOffset, 0);
				calEvent.EndDate = this.DateWithOffset (dayOffset + duration / 10, 3);
				calEvent.Location = locations [r.Next () % (locations.Length - 1)];
				calEvent.EventColor = colors [r.Next () % (colors.Length - 1)];
				calEvent.Title = titles [r.Next () % (titles.Length - 1)];
				eventsList.Add (calEvent);
			}

			this.Events = eventsList.ToArray ();
		}

		public NSDate DateWithOffset (int days, int hours)
		{
			NSCalendar calendar = NSCalendar.CurrentCalendar;
			NSDateComponents components = new NSDateComponents ();
			components.Day = days;
			components.Hour = hours;
			return calendar.DateByAddingComponents (components, NSDate.Now, (NSCalendarOptions)0);
		}

		class CalendarDataSource : TKCalendarDataSource
		{
			CalendarInlineEvents owner;

			public CalendarDataSource (CalendarInlineEvents owner)
			{
				this.owner = owner;
			}

			public override TKCalendarEventProtocol[] EventsForDate (TKCalendar calendar, NSDate date)
			{
				NSDateComponents components = calendar.Calendar.Components (NSCalendarUnit.Year | NSCalendarUnit.Month | NSCalendarUnit.Day, date);
				components.Hour = 23;
				components.Minute = 59;
				components.Second = 59;
				NSDate endDate = calendar.Calendar.DateFromComponents (components);
				List<TKCalendarEventProtocol> filteredEvents = new List<TKCalendarEventProtocol> ();
				for (int i = 0; i < this.owner.Events.Length; i++) {
					TKCalendarEvent ev = (TKCalendarEvent)this.owner.Events [i];
					if (ev.StartDate.SecondsSinceReferenceDate <= endDate.SecondsSinceReferenceDate && 
						ev.EndDate.SecondsSinceReferenceDate >= date.SecondsSinceReferenceDate) {
						filteredEvents.Add (ev);
					}
				}

				return filteredEvents.ToArray ();
			}
		}
	}
}

