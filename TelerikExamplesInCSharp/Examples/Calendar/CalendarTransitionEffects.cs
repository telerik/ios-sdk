using System;
using MonoTouch.Foundation;
using MonoTouch.UIKit;
using TelerikUI;
using System.Drawing;
using MonoTouch.ObjCRuntime;

namespace Examples
{
	public class CalendarTransitionEffects : ExampleViewController
	{
		CalendarPresenterDelegate presenterDelegate;

		public TKCalendar CalendarView {
			get;
			set;
		}

		public UIButton ButtonPrev {
			get;
			set;
		}

		public UIButton ButtonNext {
			get;
			set;
		}

		public int ColorIndex {
			get;
			set;
		}

		public int OldColorIndex {
			get;
			set;
		}

		public UIColor[] Colors {
			get;
			set;
		}

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

			this.AddOption ("Flip Effect", SelectFlipEffect);
			this.AddOption ("Float Effect", SelectedFloatEffect);
			this.AddOption ("Fold Effect", SelectedFoldEffect);
			this.AddOption ("Rotate Effect", SelectedRotateEffect);
			this.AddOption ("Card Effect", SelectedCardEffect);
			this.AddOption ("Scroll Effect", SelectedScrollEffect);
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.presenterDelegate = new CalendarPresenterDelegate (this);

			UIToolbar toolbar = new UIToolbar (new RectangleF (0, this.View.Frame.Size.Height - 44, this.View.Bounds.Size.Width, 44));
			toolbar.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin;
			this.View.AddSubview (toolbar);

			UIBarButtonItem buttonPrev = new UIBarButtonItem("Prev month", UIBarButtonItemStyle.Plain, this, new Selector("PrevTouched"));
			UIBarButtonItem buttonNext = new UIBarButtonItem("Next month", UIBarButtonItemStyle.Plain, this, new Selector("NextTouched"));
			UIBarButtonItem space = new UIBarButtonItem (UIBarButtonSystemItem.FlexibleSpace, this, null);
			toolbar.Items = new UIBarButtonItem[] { buttonPrev, space, buttonNext };

			RectangleF rect = new RectangleF (0, 0, this.View.Bounds.Size.Width, this.View.Bounds.Size.Height - toolbar.Frame.Size.Height);
			this.CalendarView = new TKCalendar (rect);
			this.CalendarView.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			this.View.AddSubview (CalendarView);

			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)this.CalendarView.Presenter;
			presenter.TransitionMode = TKCalendarTransitionMode.Flip;
//			presenter.Delegate = 
			presenter.ContentView.BackgroundColor = this.Colors [ColorIndex];
		}

		[Export ("PrevTouched")]
		public void PrevTouched ()
		{
			this.CalendarView.NavigateBack(true);
		}

		[Export ("NextTouched")]
		public void NextTouched ()
		{
			this.CalendarView.NavigateForward(true);
		}

		public void SelectFlipEffect (object sender, EventArgs e)
		{
			this.SetTransition (TKCalendarTransitionMode.Flip, false);
		}

		public void SelectedFloatEffect (object sender, EventArgs e)
		{
			this.SetTransition (TKCalendarTransitionMode.Float, false);
		}

		public void SelectedFoldEffect (object sender, EventArgs e)
		{
			this.SetTransition (TKCalendarTransitionMode.Fold, false);
		}

		public void SelectedRotateEffect (object sender, EventArgs e) 
		{
			this.SetTransition (TKCalendarTransitionMode.Rotate, false);
		}

		public void SelectedCardEffect (object sender, EventArgs e)
		{
			this.SetTransition (TKCalendarTransitionMode.Card, true);
		}

		public void SelectedScrollEffect (object sender, EventArgs e)
		{
			this.SetTransition (TKCalendarTransitionMode.Scroll, true);
		}

		public void SetTransition (TKCalendarTransitionMode transitionMode, bool isVertical)
		{
			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)this.CalendarView.Presenter;
			presenter.Delegate = presenterDelegate;
			presenter.HeaderIsSticky = true;
			presenter.TransitionIsVertical = isVertical;
			presenter.TransitionMode = transitionMode;
		}

		class CalendarPresenterDelegate : TKCalendarPresenterDelegate
		{
			CalendarTransitionEffects main;
			public CalendarPresenterDelegate (CalendarTransitionEffects main)
			{
				this.main = main;
			}

			public override void BeginTransition (ITKCalendarPresenter presenter, TKViewTransition transition)
			{
				main.OldColorIndex = main.ColorIndex;
				main.ColorIndex = (main.ColorIndex + 1) % main.Colors.Length;
				TKCalendarMonthPresenter monthPresenter = (TKCalendarMonthPresenter)presenter;
				monthPresenter.ContentView.BackgroundColor = main.Colors [main.ColorIndex];
			}

			public override void FinishTransition (ITKCalendarPresenter presenter, bool canceled)
			{
				if (canceled) {
					TKCalendarMonthPresenter monthPresenter = (TKCalendarMonthPresenter)presenter;
					monthPresenter.ContentView.BackgroundColor = main.Colors [main.OldColorIndex];
					main.ColorIndex = main.OldColorIndex;
				}
			}
		}
	}
}

