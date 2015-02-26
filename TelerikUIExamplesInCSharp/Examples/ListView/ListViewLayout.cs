using System;

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
		public TKDataSource Photos {
			get;
			set;
		}
		public TKDataSource Names {
			get;
			set;
		}

		public TKListView ListView {
			get;
			set;
		}

		public ListViewLayout () : base()
		{
			this.AddOption ("Wrap Layout", WrapLayoutSelected, "Layout");
			this.AddOption ("Columns Layout", ColumnLayoutSelected, "Layout");
			this.AddOption ("Horizontal", HorizontalSelected, "Orientation");
			this.AddOption ("Vertical", VerticalSelected, "Orientation");
			this.SetSelectedOptionInSection (1, 1);
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.Photos = new TKDataSource ("PhotosWithNames", "json", "photos");
			this.Names = new TKDataSource ("PhotosWithNames", "json", "names");

			this.Photos.Settings.ListView.CreateCell (delegate (TKListView listView, NSIndexPath indexPath, NSObject item) {
				TKListViewCell cell = listView.DequeueReusableCell("simpleCell", indexPath) as TKListViewCell;
				return cell;
			});

			this.Photos.Settings.ListView.InitCell (delegate (TKListView listView, NSIndexPath indexPath, TKListViewCell cell, NSObject item) {
				NSString imageName = (NSString)this.Photos.Items [indexPath.Row];
				cell.ImageView.Image = new UIImage (imageName);
				cell.TextLabel.Text = this.Names.Items [indexPath.Row] as NSString;
				TKView view = (TKView)cell.BackgroundView;
				view.Stroke.StrokeSides = listView.Layout.IsKindOfClass(new Class(typeof(TKListViewColumnsLayout))) ? TKRectSide.Right | TKRectSide.Bottom : TKRectSide.All;
				view.SetNeedsDisplay();
			});

			this.ListView = new TKListView (this.View.Bounds);
			this.ListView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.ListView.WeakDataSource = this.Photos;
			this.ListView.RegisterClassForCell(new Class(typeof(SimpleListViewCell)), "simpleCell");
			this.View.AddSubview (this.ListView);

			this.WrapLayoutSelected (this, EventArgs.Empty);
		}

		void WrapLayoutSelected(object sender, EventArgs e)
		{
			this.ListView.Insets = new UIEdgeInsets (4, 4, 0, 4);
			TKListViewWrapLayout layout = new TKListViewWrapLayout ();
			layout.MinimumLineSpacing = 4;
			layout.MinimumInteritemSpacing = 4;
			layout.ItemSize = new CGSize (100f, 100f);
			this.ListView.Layout = layout;
			this.ListView.ReloadData ();
		}

		void ColumnLayoutSelected(object sender, EventArgs e)
		{
			this.ListView.Insets = UIEdgeInsets.Zero;
			TKListViewColumnsLayout layout = new TKListViewColumnsLayout ();
			layout.MinimumLineSpacing = 0;
			layout.MinimumInteritemSpacing = 0;
			layout.ItemSize = new CGSize (100f, 100f);
			layout.ColumnsCount = 2;
			this.ListView.Layout = layout;
			this.ListView.ReloadData ();

			this.ListView.ScrollDirection = TKListViewScrollDirection.Vertical;
			this.SetSelectedOptionInSection (1, 1);
		}

		void VerticalSelected(object sender, EventArgs e)
		{
			this.ListView.ScrollDirection = TKListViewScrollDirection.Vertical;
		}

		void HorizontalSelected(object sender, EventArgs e)
		{
			if (this.ListView.Layout.IsKindOfClass(new Class(typeof(TKListViewColumnsLayout)))) {
				this.SetSelectedOptionInSection (1, 1);
				UIAlertView alert = new UIAlertView ("TKListView", "Columns layout supports only vertical scroll direction", null, "Close", null);
				alert.Show ();
				return;
			}

			this.ListView.ScrollDirection = TKListViewScrollDirection.Horizontal;
		}
	}
}

