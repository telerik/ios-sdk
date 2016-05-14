using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	[Register("AlertAnimations")]
	public class AlertAnimations : XamarinExampleViewController
	{
		UILabel appearLabel;
		UILabel hideLabel;
		TKDataSource appearAnimations;
		TKDataSource hideAnimations;
		TKListView appearAnimationsList;
		TKListView hideAnimationsList;
		NSMutableArray showAnimations;
		NSMutableArray dismissAnimations;
		public TKAlert alert;
		ListViewDelegate listViewDelegate;

		public override void ViewDidLoad ()
		{
			AddOption ("Show Alert", Show);

			base.ViewDidLoad ();

			this.listViewDelegate = new ListViewDelegate (this);

			alert = new TKAlert ();
			alert.Title = "Animations";
			alert.Style.BackgroundStyle = TKAlertBackgroundStyle.Blur;
			alert.AddActionWithTitle("Close", (TKAlert al, TKAlertAction action) => true);

			showAnimations = new NSMutableArray ();
			showAnimations.Add (new NSString ("Scale in"));
			showAnimations.Add (new NSString ("Fade in"));
			showAnimations.Add (new NSString ("Slide from left"));
			showAnimations.Add (new NSString ("Slide from top"));
			showAnimations.Add (new NSString ("Slide from right"));
			showAnimations.Add (new NSString ("Slide from bottom"));

			dismissAnimations = new NSMutableArray ();
			dismissAnimations.Add (new NSString ("Scale out"));
			dismissAnimations.Add (new NSString ("Fade out"));
			dismissAnimations.Add (new NSString ("Slide to left"));
			dismissAnimations.Add (new NSString ("Slide to top"));
			dismissAnimations.Add (new NSString ("Slide to right"));
			dismissAnimations.Add (new NSString ("Slide to bottom"));

			appearAnimations = new TKDataSource (showAnimations);
			hideAnimations = new TKDataSource (dismissAnimations);

			appearAnimationsList = new TKListView ();
			appearAnimationsList.WeakDataSource = appearAnimations;
			appearAnimationsList.Delegate = listViewDelegate;
			appearAnimationsList.Tag = 0;
			appearAnimationsList.AutoresizingMask = UIViewAutoresizing.None;
			this.View.AddSubview (appearAnimationsList);

			NSIndexPath selected = NSIndexPath.FromItemSection (3, 0);
			appearAnimationsList.SelectItem (selected, true, UICollectionViewScrollPosition.None);

			hideAnimationsList = new TKListView ();
			hideAnimationsList.WeakDataSource = hideAnimations;
			hideAnimationsList.Tag = 1;
			hideAnimationsList.Delegate = listViewDelegate;
			hideAnimationsList.AutoresizingMask = UIViewAutoresizing.None;
			this.View.AddSubview (hideAnimationsList);

			selected = NSIndexPath.FromItemSection (5, 0);
			hideAnimationsList.SelectItem (selected, true, UICollectionViewScrollPosition.None);

			appearLabel = new UILabel ();
			appearLabel.Text = "Show animation:";
			appearLabel.TextColor = new UIColor (0f, 0f, 0f, 1f);
			appearLabel.Font = UIFont.SystemFontOfSize (12);
			appearLabel.TextAlignment = UITextAlignment.Center;
			this.View.AddSubview (appearLabel);

			hideLabel = new UILabel ();
			hideLabel.Text = "Hide animation:";
			hideLabel.TextColor = new UIColor (0f, 0f, 0f, 1f);
			hideLabel.Font = UIFont.SystemFontOfSize (12);
			hideLabel.TextAlignment = UITextAlignment.Center;
			this.View.AddSubview (hideLabel);
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();

			nfloat titleHeight = 0;

			if (UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
				titleHeight += 40;
			}

			nfloat halfWidth = this.View.Frame.Size.Width/2;
			appearLabel.Frame = new CGRect(0, titleHeight + 10, halfWidth, 20);
			hideLabel.Frame = new CGRect(halfWidth, titleHeight + 10, halfWidth, 20);

			nfloat height = this.View.Frame.Size.Height - titleHeight - 50;

			appearAnimationsList.Frame = new CGRect(0, titleHeight + 40, halfWidth, height);
			hideAnimationsList.Frame = new CGRect(halfWidth, titleHeight + 40, halfWidth, height);
		}

		public void Show ()
		{
			NSMutableString message = new NSMutableString ();
			NSIndexPath[] selected = appearAnimationsList.IndexPathsForSelectedItems();

			if (selected.Length > 0) {
				NSIndexPath indexPath = selected [0];
				message.Append (new NSString("Alert did "));
				message.Append(new NSString(showAnimations.GetItem<NSString> ((uint)indexPath.Row)));
				message.Append (new NSString("\n"));
			}

			selected = hideAnimationsList.IndexPathsForSelectedItems();
			if (selected.Length > 0) {
				NSIndexPath indexPath = selected [0];
				message.Append (new NSString ("It will "));
				message.Append (new NSString(dismissAnimations.GetItem<NSString> ((uint)indexPath.Row)));
				message.Append (new NSString(" when close"));
			}

			alert.Message = message;
			alert.Show (true);
		}
	}

	class ListViewDelegate : TKListViewDelegate
	{
		AlertAnimations owner;

		public ListViewDelegate(AlertAnimations owner) 
		{
			this.owner = owner;
		}

		public override void DidSelectItemAtIndexPath (TKListView listView, NSIndexPath indexPath)
		{
			if (listView.Tag == 0) 
			{
				owner.alert.Style.ShowAnimation = (TKAlertAnimation)indexPath.Row;
			} 
			else {
				owner.alert.Style.DismissAnimation = (TKAlertAnimation)indexPath.Row;
			}
		}
	}
}

