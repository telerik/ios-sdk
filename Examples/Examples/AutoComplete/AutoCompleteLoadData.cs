using System;
using TelerikUI;
using UIKit;
using CoreGraphics;
using Foundation;
using System.Threading.Tasks;
using System.Collections.Generic;
using CoreFoundation;


namespace Examples
{
	[Register("AutoCompleteLoadData")]
	public class AutoCompleteLoadData : XamarinExampleViewController
	{
		private AutoCompleteLoadDataDataSource dataSource;

		public TKAutoCompleteTextView Autocomplete { get; set;}

		NSObject didShowObserver;
		NSObject didHideObserver;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.View.BackgroundColor = UIColor.FromRGB (239, 239, 244);
			dataSource = new AutoCompleteLoadDataDataSource ();

			this.Autocomplete = new TKAutoCompleteTextView(new CGRect(10, this.View.Bounds.Y + 10, this.View.Bounds.Size.Width - 20, 35));
			this.AutomaticallyAdjustsScrollViewInsets = false;

			this.Autocomplete.SuggestMode = TKAutoCompleteSuggestMode.Suggest;
			this.Autocomplete.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			this.Autocomplete.TextField.Placeholder = "Search airports";
			this.Autocomplete.CloseButton.SetImage (UIImage.FromBundle ("clear.png"), UIControlState.Normal);
			this.Autocomplete.ImageView.Image = UIImage.FromBundle (new NSString("search.png"));
			this.Autocomplete.MinimumCharactersToSearch = 1;
			this.Autocomplete.SuggestionViewHeight = this.View.Bounds.Height - this.View.Bounds.Y + 45;
			this.Autocomplete.WeakDataSource = dataSource;
			this.View.AddSubview (this.Autocomplete);
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);

			didShowObserver = NSNotificationCenter.DefaultCenter.AddObserver(UIKeyboard.DidShowNotification, (notification) => {
				NSValue nsKeyboardBounds = (NSValue)notification.UserInfo.ObjectForKey(UIKeyboard.BoundsUserInfoKey);
				CGRect keyboardBounds = nsKeyboardBounds.RectangleFValue;
				var height = keyboardBounds.Height;
				this.Autocomplete.SuggestionViewHeight = this.View.Bounds.Height - (50 + height);
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
	}

	class AutoCompleteLoadDataDataSource : TKAutoCompleteDataSource
	{
		private string urlStr = "http://www.telerik.com/docs/default-source/ui-for-ios/airports.json?sfvrsn=2";
		private NSArray airports;
		private string prefix = "";

		public override void CompletionForString (TKAutoCompleteTextView autocomplete, NSString input)
		{
			prefix = input;
			DispatchQueue queue = DispatchQueue.GetGlobalQueue (DispatchQueuePriority.High);
			queue.DispatchAsync(delegate {ReloadData(autocomplete);});


		}

		public void ReloadData(TKAutoCompleteTextView autocomplete)
		{
			NSMutableArray suggestions = new NSMutableArray ();

			if (airports == null) {
				NSUrl url = new NSUrl (urlStr);
				NSUrlRequest req = new NSUrlRequest (url);
				NSUrlResponse res;
				NSData dataVal = new NSData ();
				NSDictionary jsonResult = new NSDictionary ();
				NSError error;
				NSError errorReq;
				dataVal = NSUrlConnection.SendSynchronousRequest (req, out res, out errorReq);
				if (dataVal != null) {
					jsonResult = (NSDictionary)NSJsonSerialization.Deserialize (dataVal, NSJsonReadingOptions.MutableContainers, out error);
					if (error == null) {
						airports = (NSArray)jsonResult.ObjectForKey (new NSString ("airports"));
					} 
				

				for (nuint i = 0; i < airports.Count; i++) {
					NSDictionary item = airports.GetItem<NSDictionary> (i);
					NSString name = (NSString)item.ValueForKey (new NSString ("FIELD2"));
					NSString shortName = (NSString)item.ValueForKey (new NSString ("FIELD5"));
					string result = String.Format ("{0}, {1}", name.ToString (), shortName.ToString ());

					if (result.ToUpper ().StartsWith (prefix.ToUpper ())) {
						suggestions.Add (new TKAutoCompleteToken (new NSString (result)));
					}
				}
			}

			DispatchQueue queue = DispatchQueue.MainQueue;
			queue.DispatchAfter (DispatchTime.Now, delegate {autocomplete.CompleteSuggestionViewPopulation (suggestions);});
		}
	}
	}

}

