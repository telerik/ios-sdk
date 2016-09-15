using System;
using Foundation;
using TelerikUI;
using UIKit;
using CoreGraphics;

namespace Examples
{
	[Register("AutoCompleteBasicSetup")]
	public class AutoCompleteBasicSetup : UIViewController
	{
		private TKDataSource dataSource;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad();

			this.View.BackgroundColor = UIColor.FromRGB (239, 239, 244);

			// >> autocmp-feed-cs
			NSString[] sampleArrayOfStrings = new NSString[] { new NSString("Kristina Wolfe"),
				new NSString("Freda Curtis"),
				new NSString("Jeffery Francis"),
				new NSString("Eva Lawson"),
				new NSString("Emmett Santos"), 
				new NSString("Theresa Bryan"), 
				new NSString("Jenny Fuller"), 
				new NSString("Terrell Norris"),
				new NSString("Eric Wheeler"), 
				new NSString("Julius Clayton"), 
				new NSString("Alfredo Thornton"), 
				new NSString("Roberto Romero"),
				new NSString("Orlando Mathis"),
				new NSString("Eduardo Thomas"),
				new NSString("Harry Douglas")
			};
			// << autocmp-feed-cs

			// >> autocmp-src-cs
			this.dataSource = new TKDataSource(sampleArrayOfStrings);
			this.dataSource.Settings.AutoComplete.CreateToken (delegate(nuint index, NSObject item) {
			TKAutoCompleteToken token = new TKAutoCompleteToken((NSString)item);
				return token;
			});
			// << autocmp-src-cs

			// >> autocmp-init-cs
			this.AutomaticallyAdjustsScrollViewInsets = false;
			TKAutoCompleteTextView autocomplete = new TKAutoCompleteTextView(new CGRect(10, 80, this.View.Bounds.Width - 20, 30));
			autocomplete.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			autocomplete.WeakDataSource = this.dataSource;
			this.View.AddSubview(autocomplete);
			// << autocmp-init-cs
		
			// >> autocmp-char-cs
			autocomplete.MinimumCharactersToSearch = 1;	
			autocomplete.SuggestionViewHeight = this.View.Bounds.Size.Height/2;
			// << autocmp-char-cs

			// >> autocmp-completion-cs
			this.dataSource.Settings.AutoComplete.CompletionMode = TKAutoCompleteCompletionMode.StartsWith;
			// << autocmp-completion-cs

			// >> autocmp-suggestmode-cs
			autocomplete.SuggestMode = TKAutoCompleteSuggestMode.SuggestAppend;
			// << autocmp-suggestmode-cs
		}
	}
}

