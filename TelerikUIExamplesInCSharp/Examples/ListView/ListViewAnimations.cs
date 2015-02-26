using System;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class ListViewAnimations: ExampleViewController
	{
		TKDataSource dataSource = new TKDataSource();
		TKListView listView = new TKListView();

		public ListViewAnimations()
		{
			AddOption ("Scale in", ScaleInSelected);
			AddOption ("Fade in", FadeInSelected);
			AddOption ("Slide in", SlideInSelected);
			AddOption ("Fade + Scale in", FadePlusScaleInSelected);
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.dataSource.LoadDataFromJSONResource ("ListViewSampleData", "json", "photos");
			this.dataSource.Settings.ListView.InitCell (delegate (TKListView listView, NSIndexPath indexPath, TKListViewCell cell, NSObject item) {
				cell.ImageView.Image = new UIImage (this.dataSource.Items[indexPath.Row] as NSString);
				TKView view = cell.BackgroundView as TKView;
				view.Stroke.Width = 0;

				cell.ImageView.Layer.ShadowColor = new UIColor(0.27f, 0.27f, 0.55f, 1.0f).CGColor;
				cell.ImageView.Layer.ShadowOffset = new CGSize(2,2);
				cell.ImageView.Layer.ShadowOpacity = 0.5f;
				cell.ImageView.Layer.ShadowRadius = 3;
			});

			this.listView.Frame = this.View.Bounds;
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.WeakDataSource = this.dataSource;
			this.listView.CellAppearBehavior = new TKListViewCellScaleInBehavior ();
			this.View.AddSubview (this.listView);

			TKListViewColumnsLayout layout = (TKListViewColumnsLayout)this.listView.Layout;
			layout.ItemSize = new CGSize (130, 180);
			layout.MinimumLineSpacing = 10;
			layout.CellAlignment = TKListViewCellAlignment.Stretch;
		}

		void ScaleInSelected(object sender, EventArgs e)
		{
			this.listView.CellAppearBehavior = new TKListViewCellScaleInBehavior ();
		}

		void FadeInSelected(object sender, EventArgs e)
		{
			this.listView.CellAppearBehavior = new TKListViewCellFadeInBehavior ();
		}

		void SlideInSelected(object sender, EventArgs e)
		{
			this.listView.CellAppearBehavior = new TKListViewCellSlideInBehavior ();
		}

		void FadePlusScaleInSelected(object sender, EventArgs e)
		{
			this.listView.CellAppearBehavior = new TKListViewCellFadeInBehavior ();
			this.listView.CellAppearBehavior.AddChildBehavior (new TKListViewCellScaleInBehavior ());
		}
	}
}

