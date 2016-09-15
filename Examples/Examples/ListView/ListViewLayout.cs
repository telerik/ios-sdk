using System;
using System.Collections.Generic;

using Foundation;
using UIKit;
using CoreGraphics;
using ObjCRuntime;
using CoreAnimation;

using TelerikUI;

namespace Examples
{
	[Register("ListViewLayout")]
	public class ListViewLayout : XamarinExampleViewController
	{
		TKListView listView;
		TKDataSource dataSource;
		string[] categories = new string[] { "breakfast", "paleo", "desserts" };
		int itemsCount;
		TKListViewScrollDirection scrollDirection;
		StaggeredLayoutDelegate staggeredLayoutDelegate;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Linear", "Layout", LinearLayoutSelected);
			this.AddOption ("Grid", "Layout", GridLayoutSelected);
			this.AddOption ("Staggered", "Layout", StaggeredLayoutSelected);
			this.AddOption ("Flow",  "Layout", FlowLayoutSelected);

			this.AddOption ("Horiontal", "Orientation", HorizontalSelected);
			this.AddOption ("Vertical", "Orientation", VerticalSelected);

			this.SetSelectedOption (1, 1);

			base.ViewDidLoad ();

			dataSource = new TKDataSource ();
			dataSource.LoadDataFromJSONResource ("ListItems", "json", "items");

			string descriptor = string.Format ("category LIKE '{0}' OR category LIKE '{1}' OR category LIKE '{2}'", 
				                    categories [0], categories [1], categories [2]);
			dataSource.AddFilterDescriptor (new TKDataSourceFilterDescriptor(descriptor));

			itemsCount = dataSource.Items.Length;
			dataSource.ReloadData ();
			dataSource.GroupWithKey ("category");

			dataSource.Settings.ListView.CreateCell ((TKListView listView, NSIndexPath indexPath, NSObject item) => {
				return listView.DequeueReusableCell(new NSString("custom"), indexPath) as TKListViewCell;
			});

			dataSource.Settings.ListView.InitCell ((TKListView listView, NSIndexPath indexPath, TKListViewCell cell, NSObject item) => {
				cell.ImageView.Image = UIImage.FromBundle((NSString)item.ValueForKey(new NSString("photo")));
				cell.TextLabel.Text = (NSString)item.ValueForKey(new NSString("title"));
				cell.DetailTextLabel.Text = (NSString)item.ValueForKey(new NSString("author"));
			});
				
			dataSource.Settings.ListView.InitHeader ((TKListView listView, NSIndexPath indexPath, TKListViewHeaderCell headerCell, TKDataSourceGroup group) => {
				headerCell.TextLabel.TextAlignment = UITextAlignment.Center;
				headerCell.TextLabel.Text = group.Key as NSString;
				headerCell.BackgroundColor = UIColor.LightGray;
			});

			this.listView = new TKListView (this.View.Bounds);
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.WeakDataSource = this.dataSource;
			this.listView.RegisterClassForCell(new Class(typeof(CustomListCell)), "custom");
			this.View.AddSubview (this.listView);

			this.LinearLayoutSelected ();
		}

		void LinearLayoutSelected()
		{
			// >> listview-linear-cs
			TKListViewLinearLayout layout = new TKListViewLinearLayout ();
			layout.ItemSize = new CGSize(200, 200);
			layout.HeaderReferenceSize = new CGSize(100, 30);
			layout.ItemSpacing = 1;
			layout.ScrollDirection = this.scrollDirection;
			this.listView.Layout = layout;
			this.SetSelectedOption (1, 1);
			// << listview-linear-cs
		}

		void GridLayoutSelected()
		{
			// >> listview-grid-cs
			TKListViewGridLayout layout = new TKListViewGridLayout ();
			layout.ItemSize = new CGSize(200, 100);
			layout.HeaderReferenceSize = new CGSize(100, 30);
			layout.SpanCount = 2;
			layout.ItemSpacing = 1;
			layout.LineSpacing = 1;
			layout.ScrollDirection = this.scrollDirection;
			this.listView.Layout = layout;
			// << listview-grid-cs
			this.SetSelectedOption (1, 1);
		}

		void StaggeredLayoutSelected()
		{
			this.staggeredLayoutDelegate = new StaggeredLayoutDelegate (itemsCount);
			// >> listview-staggered-cs
			TKListViewStaggeredLayout layout = new TKListViewStaggeredLayout ();
			layout.Delegate = this.staggeredLayoutDelegate;
			layout.ItemSize = new CGSize(200, 100);
			layout.HeaderReferenceSize = new CGSize(100, 30);
			layout.SpanCount = 2;
			layout.ItemSpacing = 1;
			layout.LineSpacing = 1;
			layout.ScrollDirection = this.scrollDirection;
			layout.AlignLastLine = true;
			this.listView.Layout = layout;
			// << listview-staggered-cs
			this.SetSelectedOption (1, 1);
		}

		void FlowLayoutSelected()
		{
			UICollectionViewFlowLayout layout = new UICollectionViewFlowLayout();
			layout.ItemSize = new CGSize((this.listView.Bounds.Size.Width-3)/3.0, this.listView.Bounds.Size.Height/4.0);
			layout.HeaderReferenceSize = new CGSize(100, 30);
			layout.MinimumInteritemSpacing = 1;
			layout.MinimumLineSpacing = 1;
			this.listView.Layout = layout;
			this.scrollDirection = TKListViewScrollDirection.Vertical;
			this.SetSelectedOption (1, 1);
		}

		void VerticalSelected()
		{
			this.listView.ScrollDirection = TKListViewScrollDirection.Vertical;
			this.scrollDirection = TKListViewScrollDirection.Vertical;
		}

		void HorizontalSelected()
		{
			this.listView.ScrollDirection = TKListViewScrollDirection.Horizontal;
			this.scrollDirection = TKListViewScrollDirection.Horizontal;
		}

		public class StaggeredLayoutDelegate: TKListViewLinearLayoutDelegate 
		{
			List<float> sizes = new List<float>();

			public StaggeredLayoutDelegate(int itemsCount)
			{
				Random r = new Random();
				for (int i = 0; i<itemsCount; i++) 
				{
					sizes.Add((float)(50.0 + 5.0*r.Next(40)));
				}
			}

			// >> listview-staggered-size-cs
			public override CGSize SizeForItem (TKListView listView, TKListViewLinearLayout layout, NSIndexPath indexPath)
			{
				if (layout.ScrollDirection == TKListViewScrollDirection.Vertical) {
					return new CGSize(100, sizes[indexPath.Row]);
				}
				else {
					return new CGSize(sizes[indexPath.Row], 100);
				}
			}
			// << listview-staggered-size-cs
		}
	}
}

