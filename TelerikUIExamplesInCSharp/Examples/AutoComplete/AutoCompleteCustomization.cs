using System;
using UIKit;
using Foundation;
using CoreGraphics;
using ObjCRuntime;

using TelerikUI;

namespace Examples
{
	[Register("AutoCompleteCustomization")]
	public class AutoCompleteCustomization : XamarinExampleViewController
	{
		public TKDataSource Datasource { get; set;}
		public TKAutoCompleteTextView Autocomplete { get; set;}
		AutoCompleteDelegate autocompleteDelegate = new AutoCompleteDelegate();
		NSObject didShowObserver;
		NSObject didHideObserver;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.View.BackgroundColor = UIColor.FromRGB (239, 239, 244);
			TKView view = new TKView (this.View.Bounds);
			view.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			view.Fill = TKLinearGradientFill.WithColors (new UIColor[] { 
				new UIColor (0.35f, 0.68f, 0.89f, 0.89f), 
				new UIColor (0.35f, 0.68f, 1.0f, 1.0f), 
				new UIColor (0.85f, 0.8f, 0.2f, 0.8f)
			});
			this.View.AddSubview (view);

			this.Autocomplete = new TKAutoCompleteTextView (new CGRect (10, this.View.Bounds.Y + 10, this.View.Bounds.Size.Width-20, 35));
			this.Autocomplete.SuggestionViewOutOfFrame = true;
			this.AutomaticallyAdjustsScrollViewInsets = false;

			this.Datasource = new TKDataSource ();
			this.Datasource.LoadDataFromJSONResource ("namesPhotos", "json", "data");
			this.Datasource.Settings.AutoComplete.CreateToken (delegate(nuint index, NSObject item) {
				TKAutoCompleteToken token = new TKAutoCompleteToken ((NSString)(item.ValueForKey (new NSString ("name"))));
				token.Image = UIImage.FromBundle ((NSString)item.ValueForKey (new NSString ("photo")));
				return token;
			});

			TKListView listView = (TKListView)this.Autocomplete.WeakSuggestionView;
			listView.BackgroundColor = UIColor.Clear;
			listView.Frame = new CGRect (10, this.View.Bounds.Y + 15 + this.Autocomplete.Bounds.Height, this.View.Bounds.Size.Width-20, this.View.Bounds.Height - (15 + this.Autocomplete.Bounds.Height));
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
			this.Autocomplete.CloseButton.SetImage (UIImage.FromBundle ("clear.png"), UIControlState.Normal);
			this.Autocomplete.ImageView.Image = UIImage.FromBundle (new NSString ("search.png"));
			this.Autocomplete.BackgroundColor = UIColor.White;
			this.Autocomplete.WeakDelegate = autocompleteDelegate;
			this.Autocomplete.ShowAllItemsInitially = true;
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

