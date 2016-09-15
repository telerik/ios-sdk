using System;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;


namespace Examples
{
	[Register("CalendarDocsSimpleCustomization")]
	public class CalendarDocsSimpleCustomization : XamarinExampleViewController
	{
		CalendarDelegateCustomization calendarDelegate;

		public TKCalendar CalendarView {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
// >> customization-theme-cs			
			TKCalendar calendar = new TKCalendar (this.View.Bounds);
			calendar.Theme = new TKCalendarIPadTheme ();
			calendar.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (calendar);
// << customization-theme-cs

			calendarDelegate = new CalendarDelegateCustomization ();
			calendar.Delegate = calendarDelegate;

// >> customization-presenter-cs
			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)calendar.Presenter;
			presenter.Style.TitleCellHeight = 40;
			presenter.Style.BackgroundColor = UIColor.Yellow;
			presenter.HeaderIsSticky = true;
			presenter.Style.MonthNameTextEffect = TKCalendarTextEffect.Lowercase;
			presenter.Update (false);
// << customization-presenter-cs
		}
	}

	class CalendarDelegateCustomization : TKCalendarDelegate
	{
// >> customization-updatevisualcell-cs
		public override void UpdateVisualsForCell (TKCalendar calendar, TKCalendarCell cell)
		{
			if (cell is TKCalendarDayCell) {
				TKCalendarDayCell dayCell = (TKCalendarDayCell)cell;
				if ((dayCell.State & TKCalendarDayState.Today) != 0) {
					cell.Style.TextColor = UIColor.Red;
				}
				else {
					cell.Style.TextColor = UIColor.Purple;
				}
			}
		}
		// << customization-updatevisualcell-cs

		// >> customization-viewforcell-cs
		public override TKCalendarCell ViewForCellOfKind (TKCalendar calendar, TKCalendarCellType cellType)
		{
			if (cellType == TKCalendarCellType.Day) {
				DocsCustomCell cell = new DocsCustomCell ();
				return cell;
			}
			return null;
		}
		// << customization-viewforcell-cs
	}

}

