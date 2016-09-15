using System;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("ListViewGroups")]
	public class ListViewGroups: XamarinExampleViewController
	{
		TKDataSource dataSource = new TKDataSource();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.dataSource.LoadDataFromJSONResource ("ListViewSampleData", "json", "teams");
			this.dataSource.GroupItemSourceKey = "items";
			this.dataSource.GroupWithKey ("key");

			TKListView listView = new TKListView (this.View.Bounds);
			listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			listView.WeakDataSource = dataSource;
			listView.SelectionBehavior = TKListViewSelectionBehavior.Press;
			this.View.AddSubview (listView);

			// >> listview-layout-cs
			TKListViewLinearLayout layout = (TKListViewLinearLayout)listView.Layout;
			// << listview-layout-cs
			layout.ItemSize = new CGSize (300, 44);
			layout.HeaderReferenceSize = new CGSize (100, 44);
			layout.FooterReferenceSize = new CGSize (100, 44);

			this.dataSource.Settings.ListView.InitCell (delegate (TKListView list, NSIndexPath indexPath, TKListViewCell cell, NSObject item) {
				TKDataSourceGroup group = this.dataSource.Items[indexPath.Section] as TKDataSourceGroup;
				cell.TextLabel.Text = group.Items[indexPath.Row] as NSString;
			});

			this.dataSource.Settings.ListView.InitHeader (delegate (TKListView list, NSIndexPath indexPath, TKListViewHeaderCell headerCell, TKDataSourceGroup group) {
				headerCell.TextLabel.Text = String.Format("{0}", group.Key);
				headerCell.TextLabel.TextAlignment = UITextAlignment.Center;
			});

			this.dataSource.Settings.ListView.InitFooter (delegate (TKListView list, NSIndexPath indexPath, TKListViewFooterCell footerCell, TKDataSourceGroup group) {
				footerCell.TextLabel.Text = String.Format("Members count: {0}", group.Items.Length);
				footerCell.TextLabel.TextAlignment = UITextAlignment.Left;
				footerCell.TextLabel.Frame = new CGRect(5, 10, 200, 22);
			});
		}
			
	}
}

