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
	public class ListViewLayout : ExampleViewController
	{
		TKListView listView;
		TKDataSource dataSource;
		string[] categories = new string[] { "breakfast", "paleo", "desserts" };
		int itemsCount;
		TKListViewScrollDirection scrollDirection;

		public ListViewLayout () : base()
		{
			this.AddOption ("Linear", LinearLayoutSelected, "Layout");
			this.AddOption ("Grid", GridLayoutSelected, "Layout");
			this.AddOption ("Staggered", StaggeredLayoutSelected, "Layout");
			this.AddOption ("Flow", FlowLayoutSelected, "Layout");

			this.AddOption ("Horiontal", HorizontalSelected, "Orientation");
			this.AddOption ("Vertical", VerticalSelected, "Orientation");

			this.SetSelectedOptionInSection (1, 1);
		}

		public override void ViewDidLoad ()
		{
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
				cell.ImageView.Image = new UIImage((NSString)item.ValueForKey(new NSString("photo")));
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

			this.LinearLayoutSelected (this, EventArgs.Empty);
		}

		void LinearLayoutSelected(object sender, EventArgs e)
		{
			TKListViewLinearLayout layout = new TKListViewLinearLayout ();
			layout.ItemSize = new CGSize(200, 200);
			layout.HeaderReferenceSize = new CGSize(100, 30);
			layout.ItemSpacing = 1;
			layout.ScrollDirection = this.scrollDirection;
			this.listView.Layout = layout;
			this.SetSelectedOptionInSection (1, 1);
		}

		void GridLayoutSelected(object sender, EventArgs e)
		{
			TKListViewGridLayout layout = new TKListViewGridLayout ();
			layout.ItemSize = new CGSize(200, 100);
			layout.HeaderReferenceSize = new CGSize(100, 30);
			layout.SpanCount = 2;
			layout.ItemSpacing = 1;
			layout.LineSpacing = 1;
			layout.ScrollDirection = this.scrollDirection;
			this.listView.Layout = layout;
			this.SetSelectedOptionInSection (1, 1);
		}

		void StaggeredLayoutSelected(object sender, EventArgs e)
		{
			TKListViewStaggeredLayout layout = new TKListViewStaggeredLayout ();
			layout.Delegate = new StaggeredLayoutDelegate(itemsCount);
			layout.ItemSize = new CGSize(200, 100);
			layout.HeaderReferenceSize = new CGSize(100, 30);
			layout.SpanCount = 2;
			layout.ItemSpacing = 1;
			layout.LineSpacing = 1;
			layout.ScrollDirection = this.scrollDirection;
			layout.AlignLastLine = true;
			this.listView.Layout = layout;
			this.SetSelectedOptionInSection (1, 1);
		}

		void FlowLayoutSelected(object sender, EventArgs e)
		{
			UICollectionViewFlowLayout layout = new UICollectionViewFlowLayout();
			layout.ItemSize = new CGSize((this.listView.Bounds.Size.Width-3)/3.0, this.listView.Bounds.Size.Height/4.0);
			layout.HeaderReferenceSize = new CGSize(100, 30);
			layout.MinimumInteritemSpacing = 1;
			layout.MinimumLineSpacing = 1;
			this.listView.Layout = layout;
			this.scrollDirection = TKListViewScrollDirection.Vertical;
			this.SetSelectedOptionInSection (1, 1);
		}

		void VerticalSelected(object sender, EventArgs e)
		{
			this.listView.ScrollDirection = TKListViewScrollDirection.Vertical;
			this.scrollDirection = TKListViewScrollDirection.Vertical;
		}

		void HorizontalSelected(object sender, EventArgs e)
		{
			this.listView.ScrollDirection = TKListViewScrollDirection.Horizontal;
			this.scrollDirection = TKListViewScrollDirection.Horizontal;
		}

		public class StaggeredLayoutDelegate: TKListViewStaggeredLayoutDelegate 
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

			public override CGSize SizeForItem (TKListViewStaggeredLayout layout, NSIndexPath indexPath)
			{
				if (layout.ScrollDirection == TKListViewScrollDirection.Vertical) {
					return new CGSize(100, sizes[indexPath.Row]);
				}
				else {
					return new CGSize(sizes[indexPath.Row], 100);
				}
			}
		}
	}
}

