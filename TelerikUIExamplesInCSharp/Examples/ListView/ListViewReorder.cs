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
		ListViewDelegate listViewDelegate;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Reorder with handle", ReorderWithHandleSelected);
			this.AddOption ("Reorder with long press", ReorderWithLongPressSelected);
			this.AddOption ("Disable reorder mode", DisableReorderSelected);

			base.ViewDidLoad ();

			this.dataSource.AllowItemsReorder = true;
			this.dataSource.LoadDataFromJSONResource ("PhotosWithNames", "json", "names");

			this.listViewDelegate = new ListViewDelegate(this);

			this.listView.Frame = this.View.Bounds;
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.WeakDataSource = this.dataSource;
			this.listView.WeakDelegate = this.listViewDelegate;
			this.listView.AllowsCellReorder = true;
			this.View.AddSubview (listView);
		}

		void ReorderWithHandleSelected(object sender, EventArgs e)
		{
			this.listView.AllowsCellReorder = true;
			this.listView.ReorderMode = TKListViewReorderMode.WithHandle;
		}

		void ReorderWithLongPressSelected(object sender, EventArgs e)
		{
			this.listView.AllowsCellReorder = true;
			this.listView.ReorderMode = TKListViewReorderMode.WithLongPress;
		}

		void DisableReorderSelected(object sender, EventArgs e)
		{
			this.listView.AllowsCellReorder = false;
		}

		class ListViewDelegate: TKListViewDelegate
		{
			ListViewReorder owner;

			public ListViewDelegate(ListViewReorder owner) 
			{
				this.owner = owner;
			}

			public override void WillReorderItemAtIndexPath (TKListView listView, NSIndexPath indexPath)
			{
				TKListViewCell cell = listView.CellForItem(indexPath);
				cell.BackgroundView.BackgroundColor = UIColor.Yellow;
			}

			public override void DidReorderItemFromIndexPath (TKListView listView, NSIndexPath originalIndexPath, NSIndexPath targetIndexPath)
			{
				TKListViewCell cell = listView.CellForItem(originalIndexPath);
				cell.BackgroundView.BackgroundColor = UIColor.White;
				this.owner.dataSource.DidReorderItemFromTo (listView, originalIndexPath, targetIndexPath);
			}
		}
	}
}

