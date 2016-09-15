using System;
using CoreGraphics;
using UIKit;
using Foundation;
using ObjCRuntime;

using TelerikUI;

namespace Examples
{
	[Register("AutoCompleteGettingStarted")]
	public class AutoCompleteGettingStarted : XamarinExampleViewController
	{
		public TKDataSource Datasource { get; set;}
		public TKAutoCompleteTextView Autocomplete { get; set;}
		NSObject didShowObserver;
		NSObject didHideObserver;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.View.BackgroundColor = UIColor.FromRGB (239, 239, 244);

			AddOption ("Contains", "Completion Modes", () => ContainsSelected());
			AddOption ("Starts With", "Completion Modes", () => PrefixSelected());

			AddOption ("Append","Suggest Modes", () => AppendSelected());
			AddOption ("Suggest-Append", "Suggest Modes", () => SuggestAppendSelected());
			AddOption ("Suggest", "Suggest Modes", () => SuggestSelected());
			this.SetSelectedOption (2, 1);

			this.Autocomplete = new TKAutoCompleteTextView(new CGRect(10, this.View.Bounds.Y + 10, this.View.Bounds.Size.Width - 20, 30));
			this.AutomaticallyAdjustsScrollViewInsets = false;

			this.Datasource = new TKDataSource ();

			this.Datasource.Settings.AutoComplete.CompletionMode = TKAutoCompleteCompletionMode.Contains;

			this.Datasource.LoadDataFromJSONResource("countries", "json", "data");
			this.Datasource.Settings.AutoComplete.CreateToken (delegate(nuint index, NSObject item) {
				TKAutoCompleteToken token = new TKAutoCompleteToken((NSString)(item.ValueForKey(new NSString("country"))));
				token.Image = UIImage.FromBundle((NSString)item.ValueForKey(new NSString("flag")));
				return token;
			});
				
			this.Autocomplete.WeakDataSource = this.Datasource;
			this.Autocomplete.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			this.Autocomplete.TextField.Placeholder = "Choose country";
			this.Autocomplete.CloseButton.SetImage (UIImage.FromBundle ("clear.png"), UIControlState.Normal);
			this.Autocomplete.ImageView.Image = UIImage.FromBundle (new NSString("search.png"));
			this.Autocomplete.MinimumCharactersToSearch = 1;
			this.Autocomplete.SuggestionViewHeight = this.View.Bounds.Height - this.View.Bounds.Y + 45;
			this.View.AddSubview (this.Autocomplete);
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);

			didShowObserver = NSNotificationCenter.DefaultCenter.AddObserver(UIKeyboard.DidShowNotification, (notification) => {
				NSValue nsKeyboardBounds = (NSValue)notification.UserInfo.ObjectForKey(UIKeyboard.BoundsUserInfoKey);
				CGRect keyboardBounds = nsKeyboardBounds.RectangleFValue;
				var height = keyboardBounds.Height;
				this.Autocomplete.SuggestionViewHeight = this.View.Bounds.Height - (30 + height);
			});
			didHideObserver = NSNotificationCenter.DefaultCenter.AddObserver(UIKeyboard.DidHideNotification, (notification) => {
				this.Autocomplete.SuggestionViewHeight = this.View.Bounds.Height - 100;
			});
		}

		public override void ViewWillDisappear (bool animated)
		{
			NSNotificationCenter.DefaultCenter.RemoveObserver (didShowObserver);
			NSNotificationCenter.DefaultCenter.RemoveObserver (didHideObserver);
			base.ViewWillDisappear (animated);
		}
			
		public void PrefixSelected()
		{
			this.Datasource.Settings.AutoComplete.CompletionMode = TKAutoCompleteCompletionMode.StartsWith;
			this.Autocomplete.ResetAutocomplete ();
		}

		public void ContainsSelected()
		{
			this.Datasource.Settings.AutoComplete.CompletionMode = TKAutoCompleteCompletionMode.Contains;

			// >> autocmp-suggest-mode-cs
			this.Autocomplete.SuggestMode = TKAutoCompleteSuggestMode.Suggest;
			// << autocmp-suggest-mode-cs
			this.SetSelectedOption (2, 1);
			this.Autocomplete.ResetAutocomplete ();
		}

		public void SuggestSelected()
		{
			this.Autocomplete.SuggestMode = TKAutoCompleteSuggestMode.Suggest;
			this.Autocomplete.ResetAutocomplete ();
		}

		public void SuggestAppendSelected()
		{
			this.Datasource.Settings.AutoComplete.CompletionMode = TKAutoCompleteCompletionMode.StartsWith;
			this.Autocomplete.SuggestMode = TKAutoCompleteSuggestMode.SuggestAppend;
			this.SetSelectedOption (1, 0);
			this.Autocomplete.ResetAutocomplete ();
		}

		public void AppendSelected()
		{
			this.Datasource.Settings.AutoComplete.CompletionMode = TKAutoCompleteCompletionMode.StartsWith;
			this.Autocomplete.SuggestMode = TKAutoCompleteSuggestMode.Append;
			this.SetSelectedOption (1, 0);
			this.Autocomplete.ResetAutocomplete ();
		}
	}
}