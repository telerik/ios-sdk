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
	[Register("ListViewLoadOnDemand")]
	public class ListViewLoadOnDemand: XamarinExampleViewController
	{
		TKListView listView = new TKListView();
		ListViewDataSource listViewDataSource;
		ListViewDelegate listViewDelegate;
		TKDataSource names = new TKDataSource();
		TKDataSource photos = new TKDataSource();
		LoremIpsumGenerator loremIpsum = new LoremIpsumGenerator();
		int lastRetrievedDataIndex = 15;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Manual", "Load on demand mode", LoadOnDemandManual);
			this.AddOption ("Auto", "Load on demand mode", LoadOnDemandAuto);

			base.ViewDidLoad ();

			this.photos.LoadDataFromJSONResource ("PhotosWithNames", "json", "photos");
			this.names.LoadDataFromJSONResource ("PhotosWithNames", "json", "names");

			this.listViewDataSource = new ListViewDataSource (this);
			this.listViewDelegate = new ListViewDelegate (this);

			listView.Frame = this.View.Bounds;
			listView.BackgroundColor = new UIColor (0.0f, 1.0f, 0.0f, 0.5f);
			listView.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			listView.Delegate = this.listViewDelegate;
			listView.DataSource = this.listViewDataSource;

			// >> listview-buffer-cs
			listView.LoadOnDemandBufferSize = 5;
			// << listview-buffer-cs

			// >> listview-load-on-demand-cs
			listView.LoadOnDemandMode = TKListViewLoadOnDemandMode.Manual;
			// << listview-load-on-demand-cs

			listView.ContentInset = new UIEdgeInsets (10, 10, 10, 10);
			this.View.AddSubview (listView);
			listView.RegisterClassForCell(new ObjCRuntime.Class(typeof(CustomCardListViewCell)), "cell");

			TKListViewLinearLayout layout = (TKListViewLinearLayout)listView.Layout;
			layout.ItemSize = new CGSize (100, 120);
			layout.ItemSpacing = 5;
			layout.ItemAlignment = TKListViewItemAlignment.Stretch;
		}

		void LoadOnDemandManual() {
			this.lastRetrievedDataIndex = 15;
			this.listView.LoadOnDemandMode = TKListViewLoadOnDemandMode.Manual;
			this.listView.ReloadData ();
			this.listView.ContentOffset = new CGPoint(0, 0);
		}


		void LoadOnDemandAuto() {
			this.lastRetrievedDataIndex = 15;
			this.listView.LoadOnDemandMode = TKListViewLoadOnDemandMode.Auto;
			this.listView.ReloadData ();
			this.listView.ContentOffset = new CGPoint(0, 0);
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

			// >> listview-load-on-demand-deque-cs
			public override TKListViewCell CellForItem (TKListView listView, NSIndexPath indexPath)
			{
				TKListViewCell cell = listView.DequeueLoadOnDemandCell (indexPath);

				if (cell == null) {
					cell = listView.DequeueReusableCell ("cell", indexPath) as TKListViewCell;
					cell.ImageView.Image = UIImage.FromBundle (this.owner.photos.Items [indexPath.Row] as NSString);
					cell.TextLabel.Text = this.owner.names.Items [indexPath.Row] as NSString;
					Random r = new Random ();
					cell.DetailTextLabel.Text = this.owner.loremIpsum.RandomString (10 + r.Next (0, 16), indexPath);
					cell.DetailTextLabel.TextColor = UIColor.White;
				}

				cell.BackgroundView.BackgroundColor = UIColor.FromWhiteAlpha (0.3f, 0.5f);
				((TKView)cell.BackgroundView).Stroke = null;

				return cell;
			}
			// << listview-load-on-demand-deque-cs
		}

		// >> listview-should-load-cs
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
						if (this.owner.names.Items.Length == this.owner.lastRetrievedDataIndex) {
							listView.LoadOnDemandMode = TKListViewLoadOnDemandMode.None;
						}
						listView.DidLoadDataOnDemand();				
					}));
				});

				return true;
			}
		}
		// << listview-should-load-cs
	}
}

