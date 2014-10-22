using System;
using System.Drawing;
using MonoTouch.Foundation;
using MonoTouch.UIKit;
using TelerikUI;

namespace Examples
{
	public class CalendarCustomization : ExampleViewController
	{
		public TKCalendar CalendarView {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.CalendarView = new TKCalendar (new RectangleF ());
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.CalendarView.Delegate = new CalendarDelegate ();
			this.View.AddSubview (this.CalendarView);

			UIImage img = new UIImage ("calendar_header.png");

			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)this.CalendarView.Presenter;
			presenter.Style.TitleCellHeight = 20;
			presenter.HeaderView.ContentMode = UIViewContentMode.ScaleToFill;
			presenter.HeaderView.BackgroundColor = UIColor.FromPatternImage (img);
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();
			float width = Math.Min (this.View.Bounds.Width, this.View.Bounds.Height);
			this.CalendarView.Frame = new RectangleF (0, 0, width, width);
		}

		class CalendarDelegate : TKCalendarDelegate
		{
			public override TKCalendarCell ViewForCellOfKind (TKCalendar calendar, TKCalendarCellType cellType)
			{
				if (cellType == TKCalendarCellType.Day) {
					return new CustomCell ();
				}

				return null;
			}
		}

	}
}

