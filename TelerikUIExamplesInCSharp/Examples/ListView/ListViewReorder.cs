using System;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class ListViewReorder: ExampleViewController
	{
		TKListView listView = new TKListView();
		TKDataSource dataSource = new TKDataSource();

		public ListViewReorder()
		{
			this.AddOption ("Enabled", EnableReorderSelected, "Items reorder");
			this.AddOption ("Disabled", DisableReorderSelected, "Items reorder");
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.dataSource.AllowItemsReorder = true;
			this.dataSource.LoadDataFromJSONResource ("PhotosWithNames", "json", "names");

			this.listView.Frame = this.View.Bounds;
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.WeakDataSource = this.dataSource;
			this.listView.WeakDelegate = this.dataSource;
			this.listView.AllowsCellReorder = true;
			this.View.AddSubview (listView);
		}

		void EnableReorderSelected(object sender, EventArgs e)
		{
			this.listView.AllowsCellReorder = true;
		}

		void DisableReorderSelected(object sender, EventArgs e)
		{
			this.listView.AllowsCellReorder = false;
		}
	}
}

