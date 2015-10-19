using System;
using CoreGraphics;
using UIKit;
using Foundation;

using TelerikUI;

namespace Examples
{
	public class AutoCompleteGettingStarted : ExampleViewController
	{
		public TKDataSource Datasource { get; set;}
		public TKAutoCompleteTextView Autocomplete { get; set;}

		public AutoCompleteGettingStarted ()
		{
			AddOption ("Contains", ContainsSelected);
			AddOption ("Prefix", PrefixSelected);
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			 NSNotificationCenter.DefaultCenter.AddObserver(UIKeyboard.DidShowNotification, (notification) => {
				NSValue nsKeyboardBounds = (NSValue)notification.UserInfo.ObjectForKey(UIKeyboard.BoundsUserInfoKey);
				CGRect keyboardBounds = nsKeyboardBounds.RectangleFValue;
				var height = this.ExampleBounds.Height - keyboardBounds.Height;
				this.Autocomplete.SuggestionViewHeight = this.ExampleBounds.Height - (100 + height);
			});

			NSNotificationCenter.DefaultCenter.AddObserver(UIKeyboard.DidHideNotification, (notification) => {
				
				this.Autocomplete.SuggestionViewHeight = this.ExampleBounds.Height - 100;
			});

			this.Autocomplete = new TKAutoCompleteTextView(new CGRect(10, this.ExampleBounds.Y + 25, this.ExampleBounds.Size.Width - 10, 30));
			this.AutomaticallyAdjustsScrollViewInsets = false;

			UILabel title = new UILabel (new CGRect (10, this.ExampleBounds.Y, this.ExampleBounds.Width - 20, 20));
			title.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			title.Text = "Shipping country:";
			this.View.AddSubview (title);

			this.Datasource = new TKDataSource ();
			this.Datasource.Settings.AutoComplete.CompletionMode = TKAutoCompleteCompletionMode.Contains;
			this.Datasource.LoadDataFromJSONResource("countries", "json", "data");
			this.Datasource.Settings.AutoComplete.CreateToken (delegate(nuint index, NSObject item) {
				TKAutoCompleteToken token = new TKAutoCompleteToken((NSString)(item.ValueForKey(new NSString("country"))));
				token.Image = new UIImage((NSString)item.ValueForKey(new NSString("flag")));
				return token;
			});
				
			this.Autocomplete.WeakDataSource = this.Datasource;
			this.Autocomplete.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			this.Autocomplete.TextField.Placeholder = "Choose country";
			this.Autocomplete.CloseButton.SetImage (new UIImage ("clear.png"), UIControlState.Normal);
			this.Autocomplete.ImageView.Image = new UIImage (new NSString("search.png"));
			this.Autocomplete.MinimumCharactersToSearch = 1;
			this.Autocomplete.SuggestionViewHeight = this.ExampleBounds.Height - this.ExampleBounds.Y + 45;
			this.View.AddSubview (this.Autocomplete);
		}
			
		void PrefixSelected (object sender, EventArgs e)
		{
			this.Datasource.Settings.AutoComplete.CompletionMode = TKAutoCompleteCompletionMode.StartsWith;
		}

		void ContainsSelected (object sender, EventArgs e)
		{
			this.Datasource.Settings.AutoComplete.CompletionMode = TKAutoCompleteCompletionMode.Contains;
		}
	}
}

