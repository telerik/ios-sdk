using System;
using System.Collections;
using System.Collections.Generic;
using Foundation;
using UIKit;
using TelerikUI;
using CoreGraphics;

namespace Examples
{
	[Register("ListViewUpdate")]
	public class ListViewUpdate: XamarinExampleViewController
	{
		UIToolbar toolbar;
		TKListView listView;
		TKDataSource dataSource = new TKDataSource();
		NSMutableArray items = new NSMutableArray();
		nint added;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			for (int i = 0; i<3; i++) {
				this.AddItem ();
			}
			this.dataSource.ItemSource = this.items;

			this.toolbar = new UIToolbar(new CGRect(0, this.View.Bounds.Y, this.View.Frame.Width, 44));
			this.toolbar.Items = new UIBarButtonItem[]{
				new UIBarButtonItem("Add", UIBarButtonItemStyle.Plain, this.AddTouched),
				new UIBarButtonItem(UIBarButtonSystemItem.FlexibleSpace),
				new UIBarButtonItem("Remove", UIBarButtonItemStyle.Plain, this.RemoveTouched),
				new UIBarButtonItem(UIBarButtonSystemItem.FlexibleSpace),
				new UIBarButtonItem("Update", UIBarButtonItemStyle.Plain, this.UpdateTouched),
			};
			toolbar.AutoresizingMask = UIViewAutoresizing.FlexibleWidth;
			this.View.AddSubview (toolbar);

			this.listView = new TKListView (new CGRect(0, this.View.Bounds.Y + 44, this.View.Frame.Width, this.View.Bounds.Height - 44));
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.WeakDataSource = this.dataSource;
			this.listView.Delegate = new ListViewDelegate(this);
			this.View.AddSubview (this.listView);

			this.toolbar.Items[2].Enabled = false;
			this.toolbar.Items[4].Enabled = false;
		}

		void AddItem()
		{
			this.added ++;
			this.items.Add(new NSString(string.Format("Item {0}", this.added)));
		}

		void AddTouched(object sender, EventArgs e) 
		{
			this.AddItem ();

			// >> listview-insert-item-cs
			this.listView.InsertItems (new NSIndexPath[] { NSIndexPath.FromItemSection ((nint)(this.items.Count - 1), 0) });
			// << listview-insert-item-cs

			this.listView.SelectItem (NSIndexPath.FromItemSection (this.dataSource.Items.Length - 1, 0), false, UICollectionViewScrollPosition.CenteredVertically);
		}

		void RemoveTouched(object sender, EventArgs e) 
		{
			var selectedItemsPaths = this.listView.IndexPathsForSelectedItems();
			if (selectedItemsPaths.Length > 0) {
				var indexPath = selectedItemsPaths[0];
				this.items.RemoveObject (indexPath.Row);

				// >> listview-delete-item-cs
				this.listView.DeleteItems(selectedItemsPaths);
				// << listview-delete-item-cs

				if (indexPath.Row < this.dataSource.Items.Length) {
					this.listView.SelectItem (indexPath, false, UICollectionViewScrollPosition.None);
				} else if (this.dataSource.Items.Length > 0) {
					this.listView.SelectItem (NSIndexPath.FromItemSection (0, 0), false, UICollectionViewScrollPosition.None);
				}
			}
		}

		void UpdateTouched(object sender, EventArgs e) 
		{
			var selectedItems = this.listView.IndexPathsForSelectedItems();
			if (selectedItems.Length > 0) {
				var indexPath = selectedItems[0];
				this.items.ReplaceObject(indexPath.Row, new NSString("updated"));
				this.listView.ReloadItems(selectedItems);
				this.listView.SelectItem (indexPath, false, UICollectionViewScrollPosition.None);
			}
		}

		class ListViewDelegate: TKListViewDelegate
		{
			ListViewUpdate owner;

			public ListViewDelegate(ListViewUpdate owner)
			{
				this.owner = owner;
			}

			public override void DidSelectItemAtIndexPath (TKListView listView, NSIndexPath indexPath)
			{
				owner.toolbar.Items[2].Enabled = true;
				owner.toolbar.Items[4].Enabled = true;
			}
		}
	}
}

