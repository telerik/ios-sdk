using System;
using System.Collections.Generic;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("ListViewSwipe")]
	public class ListViewSwipe: XamarinExampleViewController
	{
		TKListView listView = new TKListView();
		TKDataSource dataSource = new TKDataSource();
		ListViewDelegate listViewDelegate;
		LoremIpsumGenerator loremIpsum = new LoremIpsumGenerator();
		bool buttonAnimationEnabled;

		public override void ViewDidLoad ()
		{
			this.AddOption ("YES", "Animate buttons", EnableButtonAnimation);
			this.AddOption ("NO", "Animate buttons", DisableButtonAnimation);

			base.ViewDidLoad ();

			buttonAnimationEnabled = true;
			NSMutableDictionary mails = new NSMutableDictionary ();
			mails.Add (new NSString("Joyce Dean"), new NSString("Sales report for January"));
			mails.Add (new NSString("Joel Robertson"), new NSString("Planned network mainternance"));
			mails.Add (new NSString("Sherman Martin"), new NSString("IT help desk"));
			mails.Add (new NSString("Lela Richardson"), new NSString("Summaries of my interviews with customers"));
			mails.Add (new NSString("Jackie Maldonado"), new NSString("REMAINDER: corporate meeting"));
			mails.Add (new NSString("Kathryn Byrd"), new NSString("Stock options"));
			mails.Add (new NSString("Ervin Powers"), new NSString("Thank you!"));
			mails.Add (new NSString("Leland Warner"), new NSString("Meeting with Jack"));
			mails.Add (new NSString("Nicholas Bowers"), new NSString("Please share these articles"));
			mails.Add (new NSString("Alex Soto"), new NSString("Additional information for Jack"));
			mails.Add (new NSString("Naomi Carson"), new NSString("Miss you!"));
			mails.Add (new NSString("Lela Richardson"), new NSString("Summaries of my interviews with customers"));
			mails.Add (new NSString("Rufus Edwards"), new NSString("Training"));
			mails.Add (new NSString("Kathryn Byrd"), new NSString("Stock options"));
			mails.Add (new NSString("Ian Ellis"), new NSString("Do you like this blog article?"));
			mails.Add (new NSString("Pat Vasquez"), new NSString("The latest UI design"));
			mails.Add (new NSString("Chelsea Burton"), new NSString("Need this article!"));
			mails.Add (new NSString("Karl Bates"), new NSString("Training update"));
			mails.Add (new NSString("Evan Rivera"), new NSString("Safety instructions"));
			mails.Add (new NSString("Tony Lawson"), new NSString("Missed our converstation"));
			mails.Add (new NSString("Wallace Little"), new NSString("Swift is awessome"));
			mails.Add (new NSString("Carrie Tran"), new NSString("Missed conference call with Jack"));
			mails.Add (new NSString("Tyler Washington"), new NSString("HR question"));
			mails.Add (new NSString("Dominick Holloway"), new NSString("Wellcome!"));
			mails.Add (new NSString("Clark Sharp"), new NSString("Important question!"));

			this.dataSource.ItemSource = mails;
			this.dataSource.Settings.ListView.CreateCell(delegate (TKListView listView, NSIndexPath indexPath, NSObject item) {
				TKListViewCell cell = listView.DequeueReusableCell("defaultCell", indexPath) as TKListViewCell;
				// >> listview-swipe-view-cs
				if (cell.SwipeBackgroundView.Subviews.Length == 0) {
					CGSize size = cell.Frame.Size;
					UIFont font = UIFont.SystemFontOfSize(14);
					UIButton bMore = new UIButton(new CGRect(size.Width - 180, 0, 60, size.Height));
					bMore.SetTitle("More", UIControlState.Normal);
					bMore.BackgroundColor = UIColor.LightGray;
					bMore.TitleLabel.Font = font;
					bMore.AddTarget(ButtonTouched, UIControlEvent.TouchUpInside);
					cell.SwipeBackgroundView.AddSubview(bMore);

					UIButton bFlag = new UIButton(new CGRect(size.Width - 120, 0, 60, size.Height));
					bFlag.SetTitle("Flag", UIControlState.Normal);
					bFlag.BackgroundColor = UIColor.Orange;
					bFlag.TitleLabel.Font = font;
					bFlag.AddTarget(ButtonTouched, UIControlEvent.TouchUpInside);
					cell.SwipeBackgroundView.AddSubview(bFlag);

					UIButton bTrash = new UIButton(new CGRect(size.Width - 60, 0, 60, size.Height));
					bTrash.SetTitle("Trash", UIControlState.Normal);
					bTrash.BackgroundColor = UIColor.Red;
					bTrash.TitleLabel.Font = font;
					bTrash.AddTarget(ButtonTouched, UIControlEvent.TouchUpInside);
					cell.SwipeBackgroundView.AddSubview(bTrash);

					UIButton bUnread = new UIButton(new CGRect(0, 0, 60, size.Height));
					bUnread.SetTitle("Mark as Unread", UIControlState.Normal);
					bUnread.BackgroundColor = UIColor.Blue;
					bUnread.TitleLabel.Font = font;
					bUnread.TitleLabel.LineBreakMode = UILineBreakMode.WordWrap;
					bUnread.TitleLabel.TextAlignment = UITextAlignment.Center;
					bUnread.AddTarget(ButtonTouched, UIControlEvent.TouchUpInside);
					cell.SwipeBackgroundView.AddSubview(bUnread);
				}
				// << listview-swipe-view-cs

				return cell;
			});

			this.dataSource.Settings.ListView.InitCell (delegate (TKListView listView, NSIndexPath indexPath, TKListViewCell cell, NSObject item) {
				cell.TextLabel.Text = item as NSString;
				NSDictionary dict = this.dataSource.ItemSource as NSDictionary;
				cell.DetailTextLabel.AttributedText = this.AttributedMailText(dict[item] as NSString);
				cell.ContentInsets = new UIEdgeInsets(5,10,5,10);
			});

			this.listViewDelegate = new ListViewDelegate (this);

			this.listView.Frame = this.View.Bounds;
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.WeakDataSource = this.dataSource;
			this.listView.Delegate = this.listViewDelegate;

			// >> listview-swipe-cs
			this.listView.AllowsCellSwipe = true;
			// << listview-swipe-cs

			// >> listview-swipe-limits-cs
			this.listView.CellSwipeLimits = new UIEdgeInsets (0, 60, 0, 180);
			// << listview-swipe-limits-cs

			// >> listview-swipe-treshold-cs
			this.listView.CellSwipeTreshold = 30;
			// << listview-swipe-treshold-cs

			this.View.AddSubview (this.listView);

			TKListViewLinearLayout layout = (TKListViewLinearLayout)this.listView.Layout;
			layout.ItemSize = new CGSize (100, 80);
		}

		void ButtonTouched(object sender, EventArgs e)
		{
			this.listView.EndSwipe (true);
		}

		void EnableButtonAnimation()
		{
			this.buttonAnimationEnabled = true;
			this.listView.ReloadData ();
		}

		void DisableButtonAnimation()
		{
			this.buttonAnimationEnabled = false;
			this.listView.ReloadData ();
		}

		void AnimateButtonInCell(TKListViewCell cell, CGPoint offset)
		{
			if (offset.X > 0) {
				return;
			}

			UIButton bMore = cell.SwipeBackgroundView.Subviews [0] as UIButton;
			UIButton bFlag = cell.SwipeBackgroundView.Subviews [1] as UIButton;
			UIButton bTrash = cell.SwipeBackgroundView.Subviews [2] as UIButton;		

			CGSize size = cell.Frame.Size;
			if (this.buttonAnimationEnabled) {
				float x = (float)size.Width - (float)Math.Abs (offset.X);
				float delta = (float)Math.Abs (offset.X) / (float)this.listView.CellSwipeLimits.Right;
				bTrash.Frame = new CGRect (x + 20 + 100 * delta, 0, 60, size.Height);
				bFlag.Frame = new CGRect (x + 10 + 50 * delta, 0, 60, size.Height);
				bMore.Frame = new CGRect (x, 0, 60, size.Height);
			} else {
				bMore.Frame = new CGRect (size.Width - 180, 0, 60, size.Height);
				bFlag.Frame = new CGRect (size.Width - 120, 0, 60, size.Height);
				bTrash.Frame = new CGRect (size.Width - 60, 0, 60, size.Height);
			}
		}

		public NSAttributedString AttributedMailText(string text)
		{
			Random r = new Random ();
			string randomString = loremIpsum.GenerateString (10 + r.Next (0, 16));
			string str = String.Format ("{0}\n{1}", text, randomString);
			NSMutableAttributedString attrStr = new NSMutableAttributedString (str, new NSDictionary ());
			NSRange range = new NSRange (str.IndexOf ("\n"), "\n".Length);
			attrStr.AddAttribute(UIStringAttributeKey.ForegroundColor, UIColor.Gray, new NSRange(range.Location, str.Length - range.Location));
			return attrStr;
		}

		// >> listview-delegate-cs
		class ListViewDelegate: TKListViewDelegate 
		{
			ListViewSwipe owner;

			public ListViewDelegate(ListViewSwipe owner) 
			{
				this.owner = owner;
			}

			public override void DidSwipeCell (TKListView listView, TKListViewCell cell, NSIndexPath indexPath, CGPoint offset)
			{
				this.owner.AnimateButtonInCell (cell, offset);
			}

			public override void DidFinishSwipeCell (TKListView listView, TKListViewCell cell, NSIndexPath indexPath, CGPoint offset)
			{
				Console.WriteLine ("Did swipe cell at index: {0}", indexPath.Row);
			}
		}
		// << listview-delegate-cs
	}
}

