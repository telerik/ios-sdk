using System;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("ListViewReorder")]
	public class ListViewReorder: XamarinExampleViewController
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

			// >> listview-datasource-reorder-cs
			this.listView.WeakDataSource = this.dataSource;
			this.dataSource.AllowItemsReorder = true;
			// << listview-datasource-reorder-cs

			this.dataSource.LoadDataFromJSONResource ("PhotosWithNames", "json", "names");

			// >> listview-delegate-set-cs
			this.listViewDelegate = new ListViewDelegate(this);
			// << listview-delegate-set-cs

			this.listView.Frame = this.View.Bounds;
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.WeakDelegate = this.listViewDelegate;

			// >> listview-reorder-cs
			this.listView.AllowsCellReorder = true;
			// << listview-reorder-cs

			this.View.AddSubview (listView);
		}

		void ReorderWithHandleSelected()
		{
			this.listView.AllowsCellReorder = true;
			this.listView.ReorderMode = TKListViewReorderMode.WithHandle;
		}

		void ReorderWithLongPressSelected()
		{
			this.listView.AllowsCellReorder = true;
			this.listView.ReorderMode = TKListViewReorderMode.WithLongPress;
		}

		void DisableReorderSelected()
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

			// >> listview-did-reorder-cs
			public override void DidReorderItemFromIndexPath (TKListView listView, NSIndexPath originalIndexPath, NSIndexPath targetIndexPath)
			{
				TKListViewCell cell = listView.CellForItem(originalIndexPath);
				cell.BackgroundView.BackgroundColor = UIColor.White;
				this.owner.dataSource.DidReorderItemFromTo (listView, originalIndexPath, targetIndexPath);
			}
			// << listview-did-reorder-cs
		}
	}
}

