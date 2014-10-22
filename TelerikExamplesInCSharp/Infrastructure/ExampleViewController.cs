using System;
using System.Collections.Generic;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace Examples
{
	public class ExampleViewController: UIViewController
	{
		UIBarButtonItem settingsButton;
		UIPopoverController popover;
		List<OptionInfo> options = new List<OptionInfo>();
		List<OptionInfo> selectedOptions = new List<OptionInfo>();
		RectangleF exampleBounds;

		public int SelectedOption { get; set; }
	
		public RectangleF ExampleBounds 
		{ 
			get { return exampleBounds; }
		}

		public OptionInfo[] Options
		{
			get { return options.ToArray(); }
		}

		public OptionInfo[] SelectedOptions 
		{
			get { return selectedOptions.ToArray (); }
		}

		public UIPopoverController Popover
		{
			get { return popover; }
			set { popover = value; }
		}

		public UIBarButtonItem SettingsButton 
		{
			get { return settingsButton; }
		}

		public ExampleViewController ()
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.View.BackgroundColor = UIColor.White;

			UIUserInterfaceIdiom idiom = UIDevice.CurrentDevice.UserInterfaceIdiom;
			if (options.Count > 0) 
			{
				if (idiom == UIUserInterfaceIdiom.Pad)
					this.loadIPadLayout ();
				else
					this.loadIPhoneLayout ();
 			} 
			else 
			{
				if (idiom == UIUserInterfaceIdiom.Pad)
					exampleBounds = RectangleF.Inflate (this.View.Bounds, -30, -30);
				else
					exampleBounds = RectangleF.Inflate (this.View.Bounds, -10, -10);
			}
		}

		public override void ViewWillDisappear (bool animated)
		{
			base.ViewWillDisappear (animated);

			if (popover != null && popover.PopoverVisible) 
			{
				popover.Dismiss (false);
			}
		}

		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();

			// Release any cached data, images, etc that aren't in use.
		}

		public virtual void AddOption(OptionInfo option)
		{
			options.Add (option);
		}

		public virtual void AddOption(string text, EventHandler func)
		{
			options.Add(new OptionInfo(text, func));
		}
			
		void loadIPadLayout()
		{
			SizeF desiredSize = SizeF.Empty;
			if (options.Count == 1) 
			{
				UIButton button = new UIButton (UIButtonType.RoundedRect);
				button.SetTitle (options [0].OptionText, UIControlState.Normal);
				button.AddTarget (optionTouched, UIControlEvent.TouchUpInside);
				desiredSize = button.SizeThatFits (this.View.Bounds.Size);
				button.Frame = new RectangleF (30, 10, desiredSize.Width, desiredSize.Height);
				this.View.AddSubview (button);
			} 
			else if (options.Count >= 3) 
			{
				settingsButton = new UIBarButtonItem (new UIImage ("menu.png"), UIBarButtonItemStyle.Plain, settingsTouched);
				this.NavigationItem.RightBarButtonItem = settingsButton;
			} 
			else 
			{
				UISegmentedControl segmented = new UISegmentedControl ();
				for (int i = 0; i < options.Count; i++) {
					segmented.InsertSegment (options [i].OptionText, i + 1, false);
				}
				desiredSize = segmented.SizeThatFits (this.View.Bounds.Size);
				segmented.Frame = new RectangleF (10, 10, desiredSize.Width, desiredSize.Height);
				segmented.AddTarget (optionTouched, UIControlEvent.ValueChanged);
				this.View.AddSubview (segmented);
				segmented.SelectedSegment = this.SelectedOption;
			}
			exampleBounds = new RectangleF (20, 30 + desiredSize.Height, this.View.Bounds.Size.Width - 40, this.View.Bounds.Size.Height - desiredSize.Height - 60);
		}

		void loadIPhoneLayout()
		{
			if (options.Count == 1) 
			{
				settingsButton = new UIBarButtonItem (options[0].OptionText, UIBarButtonItemStyle.Plain, optionTouched);
			} 
			else 
			{
				settingsButton = new UIBarButtonItem (new UIImage ("menu.png"), UIBarButtonItemStyle.Plain, settingsTouched);
			}
			this.NavigationItem.RightBarButtonItem = settingsButton;
			exampleBounds = RectangleF.Inflate (this.View.Bounds, -10, -10);
		}

		public virtual void optionTouched(object sender, EventArgs e)
		{
			UISegmentedControl segmented = sender as UISegmentedControl;
			if (segmented != null)
				this.SelectedOption = segmented.SelectedSegment;
			else {
				this.SelectedOption = 0;
			}
			OptionInfo info = options [this.SelectedOption];
			if (info.Handler != null) {
				info.Handler (info, EventArgs.Empty);
			}
		}

		public virtual void settingsTouched(object sender, EventArgs e)
		{
			SettingsViewController settings = new SettingsViewController (this);
			UIUserInterfaceIdiom idiom = UIDevice.CurrentDevice.UserInterfaceIdiom;
			if (idiom == UIUserInterfaceIdiom.Pad) 
			{
				if (popover != null && popover.PopoverVisible) 
				{
					popover.Dismiss (true);
					return;
				}
				popover = new UIPopoverController (settings);
				RectangleF settingsRect = settings.View.Bounds;
				settings.Table.SizeToFit ();
				popover.PopoverContentSize = new SizeF ((float)(Math.Min(settingsRect.Size.Width, settingsRect.Size.Height) / 2.0), settings.Table.ContentSize.Height);
				popover.PresentFromBarButtonItem (settingsButton, UIPopoverArrowDirection.Up, true);
			} 
			else 
			{
				this.NavigationController.PushViewController (settings, true);
			}
		}
	}
}

