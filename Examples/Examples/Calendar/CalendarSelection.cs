using System;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("CalendarSelection")]
	public class CalendarSelection : XamarinExampleViewController
	{
		CalendarDelegate calendarDelegate;

		public TKCalendar CalendarView {
			get;
			set;
		}

		public NSDate UnselectableDate {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			this.AddOption ("Single date selection", SelectSingleMode);
			this.AddOption ("Multiple dates selection", SelectMultipleMode);
			this.AddOption ("Date range selection", SelectRangeMode);

			this.SelectedOption = 2;

			base.ViewDidLoad ();

			this.calendarDelegate = new CalendarDelegate (this);

			this.CalendarView = new TKCalendar (this.View.Bounds);
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.CalendarView.Delegate = calendarDelegate;
			this.CalendarView.SelectionMode = TKCalendarSelectionMode.Range;
			this.View.AddSubview (this.CalendarView);

			NSDateComponents components = new NSDateComponents ();
			components.Day = 1;

			NSDate date = NSDate.Now;
			this.UnselectableDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, (NSCalendarOptions)0);

			components.Day = 3;
			NSDate startDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, (NSCalendarOptions)0);

			components.Day = 6;
			NSDate endDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, (NSCalendarOptions)0);

			components.Year = -5;
			this.CalendarView.MinDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, (NSCalendarOptions)0);

			components.Year = 5;
			this.CalendarView.MaxDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, (NSCalendarOptions)0);

			this.CalendarView.SelectedDatesRange = new TKDateRange (startDate, endDate);
		}

		public void SelectSingleMode ()
		{
			this.CalendarView.SelectionMode = TKCalendarSelectionMode.Single;
		}

		public void SelectMultipleMode ()
		{
			this.CalendarView.SelectionMode = TKCalendarSelectionMode.Multiple;
		}

		public void SelectRangeMode ()
		{
			this.CalendarView.SelectionMode = TKCalendarSelectionMode.Range;
		}

		class CalendarDelegate : TKCalendarDelegate
		{
			CalendarSelection main;
			public CalendarDelegate (CalendarSelection main)
			{
				this.main = main;
			}
			// >> selection-didselectdate-cs
			public override void DidSelectDate (TKCalendar calendar, NSDate date)
			{
				Console.WriteLine (String.Format ("{0}", date));
			}
			// << selection-didselectdate-cs

			// >> selection-didselecteddate-cs
			public override void DidDeselectedDate (TKCalendar calendar, NSDate date)
			{
				Console.WriteLine (String.Format ("{0}", date));
			}
			// << selection-didselecteddate-cs

			// >> selection-shouldselectdate-cs
			public override bool ShouldSelectDate (TKCalendar calendar, NSDate date)
			{
				Console.WriteLine (String.Format ("Trying to select the unselectable {0}", date));

				return !TKCalendar.IsDate (main.UnselectableDate, date, NSCalendarUnit.Year | NSCalendarUnit.Month | NSCalendarUnit.Day, main.CalendarView.Calendar);
			}
			// << selection-shouldselectdate-cs

			public override void UpdateVisualsForCell (TKCalendar calendar, TKCalendarCell cell)
			{
				if (cell.IsKindOfClass(new ObjCRuntime.Class(typeof(TKCalendarMonthTitleCell)))) {
					TKCalendarMonthTitleCell monthTitleCell = (TKCalendarMonthTitleCell)cell;
					monthTitleCell.LayoutMode = TKCalendarMonthTitleCellLayoutMode.MonthAndYearWithButtons;
				}
			}
		}
	}
}

