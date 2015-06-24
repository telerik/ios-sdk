using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	public class AlertCustomContentView : UIView
	{
		public UILabel dayLabel;
		public TKCalendar calendarView;

		public AlertCustomContentView(CGRect frame): base(frame)
		{
			Double width = frame.Size.Width;
			Double height = frame.Size.Height;
			UIColor color = new UIColor (0.5f, 0.7f, 0.2f, 1f);

			calendarView = new TKCalendar(new CGRect(width/2 - 0.5f, 0, width/2 + 0.5f, height)); 
			calendarView.Delegate = new CalendarDelegate (this);
			this.AddSubview (calendarView);

			calendarView.TintColor = UIColor.White;

			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)calendarView.Presenter;
			presenter.Style.BackgroundColor = color;

			dayLabel = new UILabel(new CGRect(0, 0, width/2, height));
			dayLabel.TextAlignment = UITextAlignment.Center;
			dayLabel.TextColor = color;
			dayLabel.Font = UIFont.SystemFontOfSize (60);
			dayLabel.Text = "20";
			this.AddSubview(dayLabel);

			calendarView.SelectedDate = new NSDate ();
		}
	}

	sealed class CalendarDelegate : TKCalendarDelegate
	{
		AlertCustomContentView owner;

		public CalendarDelegate(AlertCustomContentView owner) 
		{
			this.owner = owner;
		}

		public override void UpdateVisualsForCell (TKCalendar calendar, TKCalendarCell cell)
		{
			cell.Style.TextColor = new UIColor (1f, 1f, 1f, 1f);
			cell.Style.BottomBorderWidth = 0;
			cell.Style.TopBorderWidth = 0;
			cell.Style.TextFont = UIFont.SystemFontOfSize (10);
			cell.Style.ShapeFill = new TKSolidFill(new UIColor(1f, 1f, 1f,  1f));

			if(cell.IsKindOfClass(new ObjCRuntime.Class(typeof(TKCalendarDayCell))))
			{
				TKCalendarDayCell dayCell = (TKCalendarDayCell)cell;
				if ((dayCell.State & TKCalendarDayState.Selected) != 0)
				{
					dayCell.Style.TextColor = new UIColor(0.5f, 0.7f,  0.2f, 1f);
				}
			}

			if(cell.IsKindOfClass(new ObjCRuntime.Class(typeof(TKCalendarDayNameCell))))
			{
				TKCalendarDayNameCell dayNameCell = (TKCalendarDayNameCell)cell;
				dayNameCell.Label.Text = dayNameCell.Label.Text.Substring (0, 1);
			}

			if (cell.IsKindOfClass(new ObjCRuntime.Class(typeof(TKCalendarMonthTitleCell)))) {
				TKCalendarMonthTitleCell titleCell = (TKCalendarMonthTitleCell)cell;
				titleCell.LayoutMode = TKCalendarMonthTitleCellLayoutMode.MonthWithButtons;
			}
		}

		public override void DidSelectDate (TKCalendar calendar, NSDate date)
		{
			NSDateComponents components = calendar.Calendar.Components (NSCalendarUnit.Day, date);
			owner.dayLabel.Text = new NSString (components.Day.ToString());
		}
	}
}

