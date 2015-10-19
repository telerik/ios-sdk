using System;
using UIKit;
using Foundation;
using CoreGraphics;
using ObjCRuntime;

using TelerikUI;

namespace Examples
{
	public class AutoCompleteCustomize : ExampleViewController
	{
		public TKDataSource Datasource { get; set;}
		public TKAutoCompleteTextView Autocomplete { get; set;}
		AutoCompleteDelegate autocompleteDelegate = new AutoCompleteDelegate();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			TKView view = new TKView (this.View.Bounds);
			view.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			view.Fill = TKLinearGradientFill.WithColors (new UIColor[] { 
				new UIColor (0.35f, 0.68f, 0.89f, 0.89f), 
				new UIColor (0.35f, 0.68f, 1.0f, 1.0f), 
				new UIColor (0.85f, 0.8f, 0.2f, 0.8f)
			});
			this.View.AddSubview (view);

			this.Autocomplete = new TKAutoCompleteTextView (new CGRect (10, this.ExampleBounds.Y, this.ExampleBounds.Size.Width, 30));
			this.AutomaticallyAdjustsScrollViewInsets = false;

			this.Datasource = new TKDataSource ();
			this.Datasource.LoadDataFromJSONResource ("namesPhotos", "json", "data");
			this.Datasource.Settings.AutoComplete.CreateToken (delegate(nuint index, NSObject item) {
				TKAutoCompleteToken token = new TKAutoCompleteToken ((NSString)(item.ValueForKey (new NSString ("name"))));
				token.Image = new UIImage ((NSString)item.ValueForKey (new NSString ("photo")));
				return token;
			});

			TKListView listView = (TKListView)this.Autocomplete.WeakSuggestionView;
			listView.BackgroundColor = UIColor.Clear;
			listView.Frame = new CGRect (10, this.ExampleBounds.Y + 15 + this.Autocomplete.Bounds.Height, this.ExampleBounds.Size.Width, this.View.Bounds.Height - (15 + this.Autocomplete.Bounds.Height));
			listView.RemoveFromSuperview ();
			listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (listView);
			listView.RegisterClassForCell (new Class (typeof(ImageWithTextListViewCell)), "cell");

			TKListViewGridLayout layout = new TKListViewGridLayout ();
			layout.ItemAlignment = TKListViewItemAlignment.Center;
			layout.SpanCount = 2;
			layout.ItemSize = new CGSize (150, 200);
			layout.LineSpacing = 60;
			layout.ItemSpacing = 10;
			listView.Layout = layout;

			this.Autocomplete.SuggestMode = TKAutoCompleteSuggestMode.SuggestAppend;
			this.Autocomplete.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			this.Autocomplete.MaximumWrapHeight = 80;
			this.Autocomplete.WeakDataSource = this.Datasource;
			this.Autocomplete.TextField.Placeholder = "Enter Users";
			this.Autocomplete.NoResultsLabel.Text = "No Users Found";
			this.Autocomplete.CloseButton.SetImage (new UIImage ("clear.png"), UIControlState.Normal);
			this.Autocomplete.ImageView.Image = new UIImage (new NSString ("search.png"));
			this.Autocomplete.BackgroundColor = UIColor.White;
			this.Autocomplete.WeakDelegate = autocompleteDelegate;
			this.Autocomplete.ShowAllItemsInitially = true;
			this.View.AddSubview (this.Autocomplete);
		}
	}

	class AutoCompleteDelegate : TKAutoCompleteDelegate
	{
		public override TKAutoCompleteTokenView ViewForToken(TKAutoCompleteTextView autocomplete, TKAutoCompleteToken token)
		{
			TKAutoCompleteTokenView tokenView = new TKAutoCompleteTokenView(token);
			tokenView.BackgroundColor = UIColor.LightGray;
			tokenView.Layer.CornerRadius = 10;
			tokenView.ImageView.Layer.CornerRadius = 5;
			return tokenView;
		}

		public override void DidAddToken(TKAutoCompleteTextView autocomplete, TKAutoCompleteToken token)
		{
			((TKListView)autocomplete.WeakSuggestionView).ScrollToItem (((TKSuggestionListView)autocomplete.WeakSuggestionView). SelectedIndexPath, UICollectionViewScrollPosition.Top, true);
		}
	}
}

