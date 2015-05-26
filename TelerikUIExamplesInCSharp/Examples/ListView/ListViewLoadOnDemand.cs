using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

using Foundation;
using UIKit;
using CoreGraphics;
using CoreFoundation;

using TelerikUI;

namespace Examples
{
	public class ListViewLoadOnDemand: ExampleViewController
	{
		TKDataSource names = new TKDataSource();
		TKDataSource photos = new TKDataSource();
		LoremIpsumGenerator loremIpsum = new LoremIpsumGenerator();
		int lastRetrievedDataIndex = 15;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.photos.LoadDataFromJSONResource ("PhotosWithNames", "json", "photos");
			this.names.LoadDataFromJSONResource ("PhotosWithNames", "json", "names");

			TKListView listView = new TKListView (this.View.Bounds);
			listView.BackgroundColor = new UIColor (0.0f, 1.0f, 0.0f, 0.5f);
			listView.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			listView.Delegate = new ListViewDelegate (this);
			listView.DataSource = new ListViewDataSource (this);
			listView.CellBufferSize = 5;
			listView.ContentInset = new UIEdgeInsets (10, 10, 10, 10);
			this.View.AddSubview (listView);
			listView.RegisterClassForCell(new ObjCRuntime.Class(typeof(CustomCardListViewCell)), "cell");

			TKListViewLinearLayout layout = (TKListViewLinearLayout)listView.Layout;
			layout.ItemSize = new CGSize (100, 120);
			layout.ItemSpacing = 5;
			layout.ItemAlignment = TKListViewItemAlignment.Stretch;
		}

		class ListViewDataSource: TKListViewDataSource
		{
			ListViewLoadOnDemand owner;

			public ListViewDataSource(ListViewLoadOnDemand owner)
			{
				this.owner = owner;
			}

			public override int NumberOfItemsInSection (TKListView listView, int section)
			{
				return owner.lastRetrievedDataIndex;
			}

			public override TKListViewCell CellForItem (TKListView listView, NSIndexPath indexPath)
			{
				TKListViewCell cell = listView.DequeueReusableCell ("cell", indexPath) as TKListViewCell;
				cell.BackgroundView.BackgroundColor = UIColor.FromWhiteAlpha (0.3f, 0.5f);
				string imageName = this.owner.photos.Items [indexPath.Row] as NSString;
				cell.ImageView.Image = new UIImage (imageName);
				cell.TextLabel.Text = this.owner.names.Items [indexPath.Row] as NSString;
				Random r = new Random ();
				cell.DetailTextLabel.Text = this.owner.loremIpsum.RandomString (10 + r.Next (0, 16), indexPath);
				cell.DetailTextLabel.TextColor = UIColor.White;
				((TKView)cell.BackgroundView).Stroke = null;
				return cell;
			}
		}

		class ListViewDelegate: TKListViewDelegate
		{
			ListViewLoadOnDemand owner;

			public ListViewDelegate(ListViewLoadOnDemand owner)
			{
				this.owner = owner;
			}

			public override bool ShouldLoadMoreDataAtIndexPath (TKListView listView, NSIndexPath indexPath)
			{
				DispatchQueue.DefaultGlobalQueue.DispatchAsync (() => {
					this.owner.lastRetrievedDataIndex = Math.Min(this.owner.names.Items.Length, this.owner.lastRetrievedDataIndex + 10);
					DispatchQueue.MainQueue.DispatchAfter(new DispatchTime(DispatchTime.Now, 2 * 400000000), new Action(delegate {
							listView.DidLoadDataOnDemand();				
					}));
				});

				return true;
			}
		}
	}
}

