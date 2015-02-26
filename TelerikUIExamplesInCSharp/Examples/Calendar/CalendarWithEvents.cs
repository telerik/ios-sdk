using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class CalendarWithEvents : ExampleViewController
	{
		public TKCalendarEventProtocol[] Events {
			get;
			set;
		}

		public TKCalendarEventProtocol[] EventsForDate {
			get;
			set;
		}

		public UITableView TableView {
			get;
			set;
		}

		public TKCalendar CalendarView {
			get;
			set;
		}

		public CalendarWithEvents ()
		{
			this.CreateEvents ();
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.TableView = new UITableView (new RectangleF ());
			this.TableView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin;
			this.TableView.RegisterClassForCellReuse (typeof(UITableViewCell), new NSString("cell"));
			this.TableView.DataSource = new TableViewDataSource (this);
			this.View.AddSubview (this.TableView);

			NSCalendar calendar = new NSCalendar (NSCalendarType.Gregorian);
			calendar.FirstWeekDay = 2;

			NSDateComponents components = new NSDateComponents ();
			components.Year = -10;
			NSDate minDate = calendar.DateByAddingComponents (components, NSDate.Now, (NSCalendarOptions)0);
			components.Year = 10;
			NSDate maxDate = calendar.DateByAddingComponents (components, NSDate.Now, (NSCalendarOptions)0);

			this.CalendarView = new TKCalendar (new RectangleF());
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.CalendarView.Calendar = calendar;
			this.CalendarView.Delegate = new CalendarDelegate (this);
			this.CalendarView.DataSource = new CalendarDataSource (this);
			this.CalendarView.MinDate = minDate;
			this.CalendarView.MaxDate = maxDate;
			this.CalendarView.AllowPinchZoom = true;

			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)this.CalendarView.Presenter;
			presenter.Style.TitleCellHeight = 40;
			presenter.HeaderIsSticky = true;

			if (UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
				presenter.WeekNumbersHidden = true;
				this.CalendarView.Theme = new TKCalendarIPadTheme ();
				((TKCalendarMonthPresenter)this.CalendarView.Presenter).Update (true);
			} else {
				presenter.WeekNumbersHidden = false;
			}

			this.View.AddSubview (this.CalendarView);
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();

			if (this.CalendarView.Theme is TKCalendarIPadTheme ||
			    this.InterfaceOrientation == UIInterfaceOrientation.LandscapeLeft ||
			    this.InterfaceOrientation == UIInterfaceOrientation.LandscapeRight) {
				this.TableView.Frame = new RectangleF ();
				this.CalendarView.Frame = this.View.Bounds;
			} else {
				nfloat height = this.View.Bounds.Height;
				this.TableView.Frame = new CGRect (0f, height - height / 3.6f, this.View.Bounds.Size.Width, height / 3.6f);
				this.CalendarView.Frame = new CGRect (2f, 0f, this.View.Bounds.Size.Width - 4f, height - height / 3.6f);
			}
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

		class TableViewDataSource : UITableViewDataSource
		{
			CalendarWithEvents main;
			public TableViewDataSource (CalendarWithEvents main)
			{
				this.main = main;
			}

			public override nint NumberOfSections (UITableView tableView)
			{
				return 1;
			}

			public override nint RowsInSection (UITableView tableView, nint section)
			{
				if (this.main.EventsForDate == null) {
					return 0;
				}

				return this.main.EventsForDate.Length;
			}

			public override UITableViewCell GetCell (UITableView tableView, NSIndexPath indexPath)
			{
				UITableViewCell cell = tableView.DequeueReusableCell ("cell");
				TKCalendarEvent ev = (TKCalendarEvent)this.main.EventsForDate [indexPath.Row];
				cell.TextLabel.Text = ev.Title;
				return cell;
			}
		}

		class CalendarDelegate : TKCalendarDelegate
		{
			CalendarWithEvents main;

			public CalendarDelegate(CalendarWithEvents main)
			{
				this.main = main;
			}

			public override void DidSelectDate (TKCalendar calendar, NSDate date)
			{
				main.EventsForDate = calendar.EventsForDate (date);
				main.TableView.ReloadData ();
			}
		}

		class CalendarDataSource : TKCalendarDataSource
		{
			CalendarWithEvents main;

			public CalendarDataSource (CalendarWithEvents main)
			{
				this.main = main;
			}

			public override TKCalendarEventProtocol[] EventsForDate (TKCalendar calendar, NSDate date)
			{
				NSDateComponents components = calendar.Calendar.Components (NSCalendarUnit.Year | NSCalendarUnit.Month | NSCalendarUnit.Day, date);
				components.Hour = 23;
				components.Minute = 59;
				components.Second = 59;
				NSDate endDate = calendar.Calendar.DateFromComponents (components);
				List<TKCalendarEventProtocol> filteredEvents = new List<TKCalendarEventProtocol> ();
				for (int i = 0; i < this.main.Events.Length; i++) {
					TKCalendarEvent ev = (TKCalendarEvent)this.main.Events [i];
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

