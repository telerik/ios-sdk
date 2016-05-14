using System;
using Foundation;
using UIKit;
using TelerikUI;

namespace Examples
{
	[Register("ListViewVariableHeight")]
	public class ListViewVariableHeight: XamarinExampleViewController
	{
		NSMutableArray items;
		TKDataSource dataSource;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			var r = new Random ();
			var generator = new LoremIpsumGenerator ();
			items = new NSMutableArray ();
			for (int i = 0; i < 20; i++) {
				items.Add (new NSString(generator.GenerateString (2 + r.Next (30))));
			}

			dataSource = new TKDataSource (items);
			dataSource.Settings.ListView.DefaultCellClass = new ObjCRuntime.Class (typeof(ListViewVariableSizeCell));
			dataSource.Settings.ListView.InitCell ((TKListView listView, NSIndexPath indexPath, TKListViewCell cell, NSObject item) => {
				var myCell = cell as ListViewVariableSizeCell;
				myCell.label.Text = item.Description;
			});

			var list = new TKListView (this.View.Bounds);
			list.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			list.WeakDataSource = dataSource;
			this.View.AddSubview (list);

			var layout = list.Layout as TKListViewLinearLayout;
			layout.DynamicItemSize = true;
		}
	}
}

