using System;
using UIKit;
using Foundation;
using CoreGraphics;
using ObjCRuntime;

using TelerikUI;

namespace Examples
{
	[Register("AutoCompleteTokens")]
	public class AutoCompleteTokens : XamarinExampleViewController
	{
		public TKDataSource Datasource { get; set;}
		public TKAutoCompleteTextView Autocomplete { get; set;}
		AutoCompleteTokensDelegate autocompleteDelegate = new AutoCompleteTokensDelegate();
		NSObject didShowObserver;
		NSObject didHideObserver;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.View.BackgroundColor = UIColor.FromRGB (239, 239, 244);

			this.Autocomplete = new TKAutoCompleteTextView(new CGRect(10, this.View.Bounds.Y + 10, this.View.Bounds.Size.Width - 10, 30));
			this.AutomaticallyAdjustsScrollViewInsets = false;

			this.Datasource = new TKDataSource ();
			this.Datasource.LoadDataFromJSONResource("namesPhotos", "json", "data");
			this.Datasource.Settings.AutoComplete.CreateToken (delegate(nuint index, NSObject item) {
				TKAutoCompleteToken token = new TKAutoCompleteToken((NSString)(item.ValueForKey(new NSString("name"))));
				token.Image = UIImage.FromBundle((NSString)item.ValueForKey(new NSString("photo")));
				return token;
			});

			TKListView listView = (TKListView)this.Autocomplete.WeakSuggestionView;
			listView.RegisterClassForCell (new Class(typeof(PersonListViewCell)), "cell");

			TKListViewGridLayout layout = new TKListViewGridLayout();
			layout.ItemAlignment = TKListViewItemAlignment.Center;
			layout.SpanCount = 2;
			layout.ItemSize = new CGSize (120, 150);
			layout.LineSpacing = 20;
			layout.ItemSpacing = 20;
			listView.Layout = layout;

			// >> autocmp-display-mode-cs
			this.Autocomplete.DisplayMode = TKAutoCompleteDisplayMode.Tokens;
			// << autocmp-display-mode-cs

			// >> autocmp-layout-mode-cs
			this.Autocomplete.LayoutMode = TKAutoCompleteLayoutMode.Wrap;
			// << autocmp-layout-mode-cs
			this.Autocomplete.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			this.Autocomplete.MaximumWrapHeight = 150;
			this.Autocomplete.WeakDataSource = this.Datasource;
			this.Autocomplete.TextField.Placeholder = "Enter Users";
			this.Autocomplete.NoResultsLabel.Text = "No Users Found";
			this.Autocomplete.ImageView.Image = UIImage.FromBundle (new NSString("search.png"));
			this.Autocomplete.MinimumCharactersToSearch = 1;
			this.Autocomplete.WeakDelegate = autocompleteDelegate;
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
				this.Autocomplete.SuggestionViewHeight = this.View.Bounds.Height - (this.Autocomplete.CurrentWrapHeight + height + 30);
			});
			didHideObserver = NSNotificationCenter.DefaultCenter.AddObserver(UIKeyboard.DidHideNotification, (notification) => {
				this.Autocomplete.SuggestionViewHeight = this.View.Bounds.Height - (15 + this.Autocomplete.Bounds.Height);
			});
		}

		public override void ViewWillDisappear (bool animated)
		{
			NSNotificationCenter.DefaultCenter.RemoveObserver (didShowObserver);
			NSNotificationCenter.DefaultCenter.RemoveObserver (didHideObserver);
			base.ViewWillDisappear (animated);
		}
	}

	// >> autocmp-token-custom-cs
	class AutoCompleteTokensDelegate : TKAutoCompleteDelegate
	{
		public override TKAutoCompleteTokenView ViewForToken(TKAutoCompleteTextView autocomplete, TKAutoCompleteToken token)
		{
			TKAutoCompleteTokenView tokenView = new TKAutoCompleteTokenView(token);
			tokenView.BackgroundColor = UIColor.LightGray;
			tokenView.Layer.CornerRadius = 10;
			tokenView.ImageView.Layer.CornerRadius = 3;
			return tokenView;
		}
	}
	// << autocmp-token-custom-cs
}

