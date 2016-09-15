using System;
using TelerikUI;
using Foundation;
using CoreGraphics;

namespace Examples
{
	[Register("ListViewDocsGroups")]
	public class ListViewDocsGroups : XamarinExampleViewController
	{
		TKDataSource dataSource;

		public ListViewDocsGroups ()
		{
		}
	
		public override void ViewDidLoad ()
		{
			// >> listview-groups-cs
			NSMutableArray items = new NSMutableArray ();
			items.Add (new DataSourceItem ("John", 50f, "A"));
			items.Add (new DataSourceItem ("Abby", 33f, "A"));
			items.Add (new DataSourceItem ("Smith", 42f, "B"));
			items.Add (new DataSourceItem ("Peter", 28f, "B"));
			items.Add (new DataSourceItem ("Paula", 25f, "B"));

			this.dataSource = new TKDataSource ();
			this.dataSource.ItemSource = items;
			this.dataSource.GroupWithKey ("Group");
			dataSource.DisplayKey = "Name";

			TKListView listView = new TKListView (new CGRect (20, 20, this.View.Bounds.Size.Width - 40, this.View.Bounds.Size.Height - 40));
			listView.WeakDataSource = dataSource;
			this.View.AddSubview (listView);

			var layout = listView.Layout as TKListViewLinearLayout;
			layout.HeaderReferenceSize = new CGSize (200, 22);
			// << listview-groups-cs
		}
	}
}

