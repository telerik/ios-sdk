using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

namespace Examples
{
	public class ExampleViewController: UIViewController
	{
		UIBarButtonItem settingsButton;
		UIPopoverController popover;
		List<OptionInfo> options = new List<OptionInfo>();
		List<OptionSection> sections = new List<OptionSection> ();
		List<OptionInfo> selectedOptions = new List<OptionInfo>();
		CGRect exampleBounds;
		float headerHeight = 0;
		float offset = 0;

		public nint SelectedOption { get; set; }
	
		public CGRect ExampleBounds 
		{ 
			get { return exampleBounds; }
		}

		public OptionSection[] Sections {
			get { return sections.ToArray (); }
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
			this.UpdateHeaderHeight ();

			UIUserInterfaceIdiom idiom = UIDevice.CurrentDevice.UserInterfaceIdiom;
			if (options.Count > 0 || sections.Count > 0) 
			{
				if (idiom == UIUserInterfaceIdiom.Pad)
					this.loadIPadLayout ();
				else
					this.loadIPhoneLayout ();
			} 
			this.UpdateLayoutConstraints ();

		}

		void UpdateHeaderHeight () 
		{
			if (this.NavigationController == null) {
				return;
			}
			UINavigationBar navigationBar = this.NavigationController.NavigationBar;
			if (navigationBar.Translucent) {
				UIApplication app = UIApplication.SharedApplication;
				bool isLandscape = UIInterfaceOrientationExtensions.IsLandscape (app.StatusBarOrientation);
				UIUserInterfaceIdiom idiom = UIDevice.CurrentDevice.UserInterfaceIdiom;
				double version = Double.Parse (UIDevice.CurrentDevice.SystemVersion);
				if (idiom == UIUserInterfaceIdiom.Pad && version >= 8.0) {
					this.headerHeight = (float)(navigationBar.IntrinsicContentSize.Height + app.StatusBarFrame.Height);
				} else {
					float statusBarSize = (float)app.StatusBarFrame.Size.Height;
					if (isLandscape) {
						statusBarSize = (float)app.StatusBarFrame.Size.Width;
					}
					this.headerHeight = (float)(navigationBar.IntrinsicContentSize.Height + statusBarSize);
				}
			}
		}

		void UpdateLayoutConstraints () 
		{
			this.exampleBounds = this.View.Bounds;
			this.UpdateHeaderHeight ();
			this.exampleBounds.Y += this.headerHeight;
			this.exampleBounds.Height -= this.headerHeight;

			if (this.offset > 0) {
				this.exampleBounds.Y += this.offset;
				this.exampleBounds.Height -= this.offset;
			}

			UIUserInterfaceIdiom idiom = UIDevice.CurrentDevice.UserInterfaceIdiom;
			if (idiom == UIUserInterfaceIdiom.Pad)
				exampleBounds = CGRect.Inflate (this.exampleBounds, -30, -30);
			else
				exampleBounds = CGRect.Inflate (this.exampleBounds, -10, -10);
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();
			this.UpdateLayoutConstraints();
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

		public virtual void AddOption(string text, EventHandler func, string sectionName)
		{
			this.AddOptionInSection (new OptionInfo(text, func), sectionName);
		}

		void AddOptionInSection(OptionInfo option, string sectionName)
		{
			foreach (OptionSection section in this.sections) {
				if (section.Title.Equals(sectionName)) {
					section.Items.Add (option);
					return;
				}
			}

			OptionSection newSection = new OptionSection(sectionName);
			newSection.Items.Add(option);
			this.sections.Add(newSection);
		}

		public void SetSelectedOptionInSection (int selectedOption, int section)
		{
			OptionSection sec = sections [section];
			sec.SelectedOption = selectedOption;
		}
			
		void loadIPadLayout()
		{
			CGSize desiredSize = CGSize.Empty;
			this.offset = 0;
			if (sections.Count == 0 && options.Count == 1) 
			{
				UIButton button = new UIButton (UIButtonType.RoundedRect);
				button.SetTitle (options [0].OptionText, UIControlState.Normal);
				button.AddTarget (optionTouched, UIControlEvent.TouchUpInside);
				desiredSize = button.SizeThatFits (this.View.Bounds.Size);
				button.Frame = new CGRect (30, 10 + this.headerHeight, desiredSize.Width, desiredSize.Height);
				this.View.AddSubview (button);
				this.offset = (float)(10 + desiredSize.Height + 10);
			} 
			else if (options.Count >= 3 || sections.Count > 0) 
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
				segmented.Frame = new CGRect (10, 10 + this.headerHeight, desiredSize.Width, desiredSize.Height);
				segmented.AddTarget (optionTouched, UIControlEvent.ValueChanged);
				this.View.AddSubview (segmented);
				segmented.SelectedSegment = this.SelectedOption;
				this.offset = (float)(10 + desiredSize.Height + 10);
			}
		}

		void loadIPhoneLayout()
		{
			if (sections.Count == 0 && options.Count == 1) 
			{
				settingsButton = new UIBarButtonItem (options[0].OptionText, UIBarButtonItemStyle.Plain, optionTouched);
			} 
			else 
			{
				settingsButton = new UIBarButtonItem (new UIImage ("menu.png"), UIBarButtonItemStyle.Plain, settingsTouched);
			}
			this.NavigationItem.RightBarButtonItem = settingsButton;
//			exampleBounds = CGRect.Inflate (this.View.Bounds, -10, -10);
		}

		public virtual void optionTouched(object sender, EventArgs e)
		{
			UISegmentedControl segmented = sender as UISegmentedControl;
			if (segmented != null)
				this.SelectedOption = segmented.SelectedSegment;
			else {
				this.SelectedOption = 0;
			}
			OptionInfo info = options [(int)this.SelectedOption];
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
				CGRect settingsRect = settings.View.Bounds;
				settings.Table.SizeToFit ();
				popover.PopoverContentSize = new CGSize ((float)(Math.Min(settingsRect.Size.Width, settingsRect.Size.Height) / 2.0), settings.Table.ContentSize.Height);
				popover.PresentFromBarButtonItem (settingsButton, UIPopoverArrowDirection.Up, true);
			} 
			else 
			{
				this.NavigationController.PushViewController (settings, true);
			}
		}
	}
}

