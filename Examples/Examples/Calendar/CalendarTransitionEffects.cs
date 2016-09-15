using System;
using System.Drawing;

using Foundation;
using UIKit;
using ObjCRuntime;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("CalendarTransitionEffects")]
	public class CalendarTransitionEffects : XamarinExampleViewController
	{
		CalendarDelegate calendarDelegate;
		CalendarPresenterDelegate presenterDelegate;

		public TKCalendar CalendarView { get; set; }

		public UIButton ButtonPrev { get; set; }

		public UIButton ButtonNext { get; set; }

		public int ColorIndex {	get; set; }

		public int OldColorIndex { get;	set; }

		public UIColor[] Colors { get; set; }

		public TKCalendarTransitionMode TransitionMode { get; set; }

		public CalendarTransitionEffects ()
		{
			this.ColorIndex = 0;
			this.Colors = new UIColor[] {
				new UIColor (0f, 1f, 0f, 0.3f),
				new UIColor (1f, 0f, 0f, 0.3f),
				new UIColor (0f, 0f, 1f, 0.3f),
				new UIColor (1f, 1f, 0f, 0.3f),
				new UIColor (0f, 1f, 1f, 0.3f),
				new UIColor (1f, 0f, 1f, 0.3f)
			};

		}

		public override void ViewDidLoad ()
		{
			this.AddOption ("Flip Effect", SelectFlipEffect);
			this.AddOption ("Float Effect", SelectedFloatEffect);
			this.AddOption ("Fold Effect", SelectedFoldEffect);
			this.AddOption ("Rotate Effect", SelectedRotateEffect);
			this.AddOption ("Card Effect", SelectedCardEffect);
			this.AddOption ("Scroll Effect", SelectedScrollEffect);

			base.ViewDidLoad ();

			this.calendarDelegate  = new CalendarDelegate (this); 
			this.presenterDelegate = new CalendarPresenterDelegate (this);

			UIToolbar toolbar = new UIToolbar (new CGRect (0, this.View.Frame.Size.Height - 44, this.View.Bounds.Size.Width, 44));
			toolbar.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin;
			this.View.AddSubview (toolbar);

			UIBarButtonItem buttonPrev = new UIBarButtonItem("Prev month", UIBarButtonItemStyle.Plain, this, new Selector("PrevTouched"));
			UIBarButtonItem buttonNext = new UIBarButtonItem("Next month", UIBarButtonItemStyle.Plain, this, new Selector("NextTouched"));
			UIBarButtonItem space = new UIBarButtonItem (UIBarButtonSystemItem.FlexibleSpace, this, null);
			toolbar.Items = new UIBarButtonItem[] { buttonPrev, space, buttonNext };

			CGRect rect = new CGRect (0, 0, this.View.Bounds.Size.Width, this.View.Bounds.Size.Height - toolbar.Frame.Size.Height);
			this.CalendarView = new TKCalendar (rect);
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			this.CalendarView.Delegate = calendarDelegate;
			this.CalendarView.AllowPinchZoom = false;
			this.View.AddSubview (CalendarView);

			NSDate date = NSDate.Now;
			NSDateComponents components = new NSDateComponents ();
			components.Year = -1;
			this.CalendarView.MinDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);
			components.Year = 1;
			this.CalendarView.MaxDate = this.CalendarView.Calendar.DateByAddingComponents (components, date, NSCalendarOptions.None);

			// >> transitions-monthpresenter-cs
			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)this.CalendarView.Presenter;
			presenter.TransitionMode = TKCalendarTransitionMode.Flip;
			// << transitions-monthpresenter-cs
			presenter.Delegate = new CalendarPresenterDelegate (this);
			// >> transitions-transitionvertical-cs
			presenter.TransitionIsVertical = true;
			// << transitions-transitionvertical-cs
			presenter.ContentView.BackgroundColor = this.Colors [ColorIndex];
			// >> transitions-transitionduration-cs
			presenter.TransitionDuration = 2;
			// << transitions-transitionduration-cs
			this.TransitionMode = TKCalendarTransitionMode.Flip;
		}

		[Export("PrevTouched")]
		public void PrevTouched ()
		{
			this.CalendarView.NavigateBack(true);
		}
			
		[Export("NextTouched")]
		public void NextTouched ()
		{
			// >> navigation-navigateforward-cs
			this.CalendarView.NavigateForward(true);
			// << navigation-navigateforward-cs
		}

		public void SelectFlipEffect ()
		{
			this.SetTransition (TKCalendarTransitionMode.Flip, false);
		}

		public void SelectedFloatEffect ()
		{
			this.SetTransition (TKCalendarTransitionMode.Float, false);
		}

		public void SelectedFoldEffect ()
		{
			this.SetTransition (TKCalendarTransitionMode.Fold, false);
		}

		public void SelectedRotateEffect () 
		{
			this.SetTransition (TKCalendarTransitionMode.Rotate, false);
		}

		public void SelectedCardEffect ()
		{
			this.SetTransition (TKCalendarTransitionMode.Card, true);
		}

		public void SelectedScrollEffect ()
		{
			this.SetTransition (TKCalendarTransitionMode.Scroll, true);
		}

		public void SetTransition (TKCalendarTransitionMode transitionMode, bool isVertical)
		{
			this.CalendarView.ViewMode = TKCalendarViewMode.Month;
			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)this.CalendarView.Presenter;
			presenter.Delegate = presenterDelegate;
			presenter.HeaderIsSticky = true;
			presenter.TransitionIsVertical = isVertical;
			presenter.TransitionMode = transitionMode;
			this.TransitionMode = transitionMode;
		}

		class CalendarDelegate: TKCalendarDelegate
		{
			CalendarTransitionEffects main;

			public CalendarDelegate (CalendarTransitionEffects main)
			{
				this.main = main;
			}

			public override void DidChangedViewModeFrom (TKCalendar calendar, TKCalendarViewMode previousViewMode, TKCalendarViewMode viewMode)
			{
				if (viewMode == TKCalendarViewMode.Month) 
				{
					TKCalendarMonthPresenter monthPresenter = (TKCalendarMonthPresenter)calendar.Presenter;
					monthPresenter.ContentView.BackgroundColor = main.Colors [main.ColorIndex];
					monthPresenter.Delegate = new CalendarPresenterDelegate (main);
					monthPresenter.TransitionMode = main.TransitionMode;
				}
			}
		}

		class CalendarPresenterDelegate : TKCalendarPresenterDelegate
		{
			CalendarTransitionEffects main;
			public CalendarPresenterDelegate (CalendarTransitionEffects main)
			{
				this.main = main;
			}

			public override void BeginTransition (TKCalendarPresenter presenter, TKViewTransition transition)
			{
				main.OldColorIndex = main.ColorIndex;
				main.ColorIndex = (main.ColorIndex + 1) % main.Colors.Length;
				TKCalendarMonthPresenter monthPresenter = (TKCalendarMonthPresenter)(NSObject)presenter;
				monthPresenter.ContentView.BackgroundColor = main.Colors [main.ColorIndex];
			}

			public override void FinishTransition (TKCalendarPresenter presenter, bool canceled)
			{
				if (canceled) {
					TKCalendarMonthPresenter monthPresenter = (TKCalendarMonthPresenter)(NSObject)presenter;
					monthPresenter.ContentView.BackgroundColor = main.Colors [main.OldColorIndex];
					main.ColorIndex = main.OldColorIndex;
				}
			}
		}
	}
}

