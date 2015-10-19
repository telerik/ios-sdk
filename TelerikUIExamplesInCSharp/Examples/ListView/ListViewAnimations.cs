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

		public override void ViewDidLoad ()
		{
			AddOption ("Scale in", ScaleInSelected);
			AddOption ("Fade in", FadeInSelected);
			AddOption ("Slide in", SlideInSelected);

			base.ViewDidLoad ();

			this.dataSource.LoadDataFromJSONResource ("ListViewSampleData", "json", "photos");

			this.dataSource.Settings.ListView.CreateCell ((TKListView listView, NSIndexPath indexPath, NSObject item) => {
				return listView.DequeueReusableCell("cell", indexPath) as TKListViewCell;
			});
			this.dataSource.Settings.ListView.InitCell (delegate (TKListView listView, NSIndexPath indexPath, TKListViewCell cell, NSObject item) {
				cell.ImageView.Image = new UIImage (this.dataSource.Items[indexPath.Row] as NSString);
			});

			this.listView.Frame = this.View.Bounds;
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.WeakDataSource = this.dataSource;
			this.listView.RegisterClassForCell (new ObjCRuntime.Class (typeof(AnimationListCell)), "cell");
			this.View.AddSubview (this.listView);

			var layout = new TKListViewGridLayout();
			if (UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
				layout.SpanCount = 3;
			}
			else {
				layout.SpanCount = 2;
			}
			layout.ItemSize = new CGSize(130, 180);
			layout.ItemSpacing = 10;
			layout.LineSpacing = 10;
			layout.ItemAlignment = TKListViewItemAlignment.Center;
			layout.ItemAppearAnimation = TKListViewItemAnimation.Scale;
			layout.AnimationDuration = 0.4f;
			this.listView.Layout = layout;
		}

		void ScaleInSelected(object sender, EventArgs e)
		{
			TKListViewLinearLayout layout = (TKListViewLinearLayout)this.listView.Layout;
			layout.ItemAppearAnimation = TKListViewItemAnimation.Scale;
		}

		void FadeInSelected(object sender, EventArgs e)
		{
			TKListViewLinearLayout layout = (TKListViewLinearLayout)this.listView.Layout;
			layout.ItemAppearAnimation = TKListViewItemAnimation.Fade;
		}

		void SlideInSelected(object sender, EventArgs e)
		{
			TKListViewLinearLayout layout = (TKListViewLinearLayout)this.listView.Layout;
			layout.ItemAppearAnimation = TKListViewItemAnimation.Slide;
		}
	}
}

