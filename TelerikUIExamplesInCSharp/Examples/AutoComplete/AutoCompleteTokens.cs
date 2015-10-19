using System;
using UIKit;
using Foundation;
using CoreGraphics;
using ObjCRuntime;

using TelerikUI;

namespace Examples
{
	public class AutoCompleteTokens : ExampleViewController
	{
		public TKDataSource Datasource { get; set;}
		public TKAutoCompleteTextView Autocomplete { get; set;}
		AutoCompleteTokensDelegate autocompleteDelegate = new AutoCompleteTokensDelegate();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.Autocomplete = new TKAutoCompleteTextView(new CGRect(10, this.ExampleBounds.Y, this.ExampleBounds.Size.Width - 10, 30));
			this.AutomaticallyAdjustsScrollViewInsets = false;

			this.Datasource = new TKDataSource ();
			this.Datasource.LoadDataFromJSONResource("namesPhotos", "json", "data");
			this.Datasource.Settings.AutoComplete.CreateToken (delegate(nuint index, NSObject item) {
				TKAutoCompleteToken token = new TKAutoCompleteToken((NSString)(item.ValueForKey(new NSString("name"))));
				token.Image = new UIImage((NSString)item.ValueForKey(new NSString("photo")));
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

			this.Autocomplete.DisplayMode = TKAutoCompleteDisplayMode.Tokens;
			this.Autocomplete.LayoutMode = TKAutoCompleteLayoutMode.Wrap;
			this.Autocomplete.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			this.Autocomplete.MaximumWrapHeight = 80;
			this.Autocomplete.WeakDataSource = this.Datasource;
			this.Autocomplete.TextField.Placeholder = "Enter Users";
			this.Autocomplete.NoResultsLabel.Text = "No Users Found";
			this.Autocomplete.ImageView.Image = new UIImage (new NSString("search.png"));
			this.Autocomplete.MinimumCharactersToSearch = 1;
			this.Autocomplete.WeakDelegate = autocompleteDelegate;
			this.Autocomplete.SuggestionViewHeight = this.ExampleBounds.Height - this.ExampleBounds.Y + 45;
			this.View.AddSubview (this.Autocomplete);
		}
	}

	class AutoCompleteTokensDelegate : TKAutoCompleteDelegate
	{
		public override TKAutoCompleteTokenView ViewForToken(TKAutoCompleteTextView autocomplete, TKAutoCompleteToken token)
		{
			TKAutoCompleteTokenView tokenView = new TKAutoCompleteTokenView(token);
			tokenView.BackgroundColor = new UIColor(0.090f, 0.537f, 0.965f, 1.00f);
			tokenView.Layer.CornerRadius = 10;
			tokenView.ImageView.Layer.CornerRadius = 10;
			return tokenView;
		}
	}
}

