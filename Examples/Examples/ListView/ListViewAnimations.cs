using System;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("ListViewAnimations")]
	public class ListViewAnimations: XamarinExampleViewController
	{
		TKDataSource dataSource = new TKDataSource();
		TKListView listView = new TKListView();

		public override void ViewDidLoad ()
		{
			AddOption ("Scale in", ScaleInSelected);
			AddOption ("Fade in", FadeInSelected);
			AddOption ("Slide in", SlideInSelected);

			base.ViewDidLoad ();

			string s = TKChart.VersionString;

			this.dataSource.LoadDataFromJSONResource ("ListViewSampleData", "json", "photos");

			this.dataSource.Settings.ListView.CreateCell ((TKListView listView, NSIndexPath indexPath, NSObject item) => {
				return listView.DequeueReusableCell("cell", indexPath) as TKListViewCell;
			});
			this.dataSource.Settings.ListView.InitCell (delegate (TKListView listView, NSIndexPath indexPath, TKListViewCell cell, NSObject item) {
				cell.ImageView.Image = UIImage.FromBundle (this.dataSource.Items[indexPath.Row] as NSString);
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

			// >> listview-alignment-cs
			layout.ItemAlignment = TKListViewItemAlignment.Center;
			// << listview-alignment-cs

			layout.ItemAppearAnimation = TKListViewItemAnimation.Scale;

			// >> listview-animation-duration-cs
			layout.AnimationDuration = 0.4f;
			// << listview-animation-duration-cs

			this.listView.Layout = layout;
		}

		void ScaleInSelected()
		{
			TKListViewLinearLayout layout = (TKListViewLinearLayout)this.listView.Layout;
			// >> listview-appear-cs
			layout.ItemAppearAnimation = TKListViewItemAnimation.Scale;
			// << listview-appear-cs

			// >> listview-insert-cs
			layout.ItemInsertAnimation = TKListViewItemAnimation.Scale;
			// << listview-insert-cs

			// >> listview-delete-cs
			layout.ItemDeleteAnimation = TKListViewItemAnimation.Slide;
			// << listview-delete-cs
		}

		void FadeInSelected()
		{
			TKListViewLinearLayout layout = (TKListViewLinearLayout)this.listView.Layout;
			layout.ItemAppearAnimation = TKListViewItemAnimation.Fade;
			layout.ItemInsertAnimation = TKListViewItemAnimation.Fade;
			layout.ItemDeleteAnimation = TKListViewItemAnimation.Fade;
		}

		void SlideInSelected()
		{
			TKListViewLinearLayout layout = (TKListViewLinearLayout)this.listView.Layout;
			layout.ItemAppearAnimation = TKListViewItemAnimation.Slide;
			layout.ItemInsertAnimation = TKListViewItemAnimation.Slide;
			layout.ItemDeleteAnimation = TKListViewItemAnimation.Slide;
		}
	}
}

