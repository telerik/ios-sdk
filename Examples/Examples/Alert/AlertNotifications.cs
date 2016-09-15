using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	[Register("AlertNotifications")]
	public class AlertNotifications : XamarinExampleViewController
	{
		public TKListView listView;
		public TKDataSource dataSource;
		public NSMutableArray titles;
		public NSMutableArray messages;
		public NSMutableArray colors;
		public TKAlert alert;
		NotificationsListViewDelegate listViewDelegate;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.listViewDelegate = new NotificationsListViewDelegate(this);

			NSMutableArray types = new NSMutableArray ();
			types.Add (new NSString ("Error"));
			types.Add (new NSString ("Warning"));
			types.Add (new NSString ("Success"));
			types.Add (new NSString("Info"));

			dataSource = new TKDataSource(types);
		
			listView = new TKListView ();
			listView.Frame = this.View.Bounds;
			listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			listView.Delegate = listViewDelegate;
			listView.WeakDataSource = dataSource;
			this.View.AddSubview (listView);

			titles = new NSMutableArray ();
			titles.Add (new NSString ("Oh no!"));
			titles.Add (new NSString ("Warning!"));
			titles.Add (new NSString ("Well done!"));
			titles.Add (new NSString ("Info."));

			messages = new NSMutableArray ();
			messages.Add (new NSString ("Change this and try again!"));
			messages.Add (new NSString ("e careful next time"));
			messages.Add (new NSString ("You successfully read this message"));
			messages.Add (new NSString ("This is TKAlert dialog"));

			colors = new NSMutableArray ();
			colors.Add(new UIColor(1f, 0f, 0.282f, 1f));
			colors.Add(new UIColor(1f, 0.733f, 0f, 1f));
			colors.Add(new UIColor(0.478f, 0.988f, 0.157f, 1f));
			colors.Add(new UIColor(0.231f, 0.678f, 1f, 1f));

			alert = new TKAlert ();
			alert.Style.ContentSeparatorWidth = 0;
			alert.Style.TitleColor = new UIColor (1f, 1f, 1f, 1f);
			alert.Style.MessageColor = new UIColor (1f, 1f, 1f, 1f);
			alert.Style.CornerRadius = 0;
			alert.Style.ShowAnimation = TKAlertAnimation.SlideFromTop;
			alert.Style.DismissAnimation = TKAlertAnimation.SlideFromTop;

			// >> alert-bg-cs
			alert.Style.BackgroundStyle = TKAlertBackgroundStyle.None;
			// << alert-bg-cs

			// >> alert-dismiss-cs
			alert.DismissMode = TKAlertDismissMode.Tap;
			// << alert-dismiss-cs

			// >> alert-layout-cs
			alert.ActionsLayout = TKAlertActionsLayout.Vertical;
			// << alert-layout-cs
		}
	}

    class NotificationsListViewDelegate : TKListViewDelegate
	{
		AlertNotifications owner;

		public NotificationsListViewDelegate(AlertNotifications owner) 
		{
			this.owner = owner;
		}

		public override void DidSelectItemAtIndexPath (TelerikUI.TKListView listView, Foundation.NSIndexPath indexPath)
		{
			owner.alert.CustomFrame = new CGRect(0, 0, listView.Superview.Frame.Size.Width, 160);
			owner.alert.Title = owner.titles.GetItem<NSString> ((uint)indexPath.Row);
			owner.alert.Message = owner.messages.GetItem<NSString> ((uint)indexPath.Row);
			owner.alert.ContentView.Fill = new TKSolidFill (owner.colors.GetItem<UIColor> ((uint)indexPath.Row));
			owner.alert.HeaderView.Fill = new TKSolidFill (owner.colors.GetItem<UIColor> ((uint)indexPath.Row));
			owner.alert.AlertView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;

			if (indexPath.Row > 0) {
				owner.alert.DismissTimeout = 3.2;
			}
			else {
				owner.alert.DismissTimeout = 0;
			}

			owner.alert.Show (true);
		}
	} 
}

