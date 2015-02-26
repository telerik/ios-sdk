using System;

using Foundation;
using UIKit;
using CoreGraphics;
using ObjCRuntime;
using CoreAnimation;

using TelerikUI;

namespace Examples
{
	public class ListViewGettingStarted : ExampleViewController
	{
		public TKDataSource Photos {
			get;
			set;
		}
		public TKDataSource Names {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.Photos = new TKDataSource ("PhotosWithNames", "json", "photos");
			this.Names = new TKDataSource ("PhotosWithNames", "json", "names");

			TKListView listView = new TKListView (this.View.Bounds);
			listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			listView.DataSource = new ListViewDataSource (this);
			this.View.AddSubview (listView);
			listView.RegisterClassForCell (new Class(typeof(ImageWithTextListViewCell)), "cell");

			TKListViewColumnsLayout layout = (TKListViewColumnsLayout)listView.Layout;
			layout.CellAlignment = TKListViewCellAlignment.Center;
			layout.ColumnsCount = 2;
			layout.ItemSize = new CGSize (150, 200);
			layout.MinimumLineSpacing = 60;
			layout.MinimumInteritemSpacing = 10;

			listView.Fill = TKLinearGradientFill.WithColors (new UIColor[] { 
				new UIColor (0.35f, 0.68f, 0.89f, 0.89f), 
				new UIColor (0.35f, 0.68f, 1.0f, 1.0f), 
				new UIColor (0.85f, 0.8f, 0.2f, 0.8f)
			});
		}

		class ListViewDataSource : TKListViewDataSource
		{
			ListViewGettingStarted owner;

			public ListViewDataSource (ListViewGettingStarted owner)
			{
				this.owner = owner;
			}

			public override int NumberOfItemsInSection (TKListView listView, int section)
			{
				return this.owner.Names.Items.Length;
			}

			public override TKListViewCell CellForItem (TKListView listView, NSIndexPath indexPath)
			{
				TKListViewCell cell = (TKListViewCell)listView.DequeueReusableCell ("cell", indexPath);
				NSString imageName = (NSString)this.owner.Photos.Items [indexPath.Row];
				cell.ImageView.Image = new UIImage (imageName);
				cell.TextLabel.Text = (NSString)this.owner.Names.Items [indexPath.Row];
				return cell;
			}
		}
	}
}

