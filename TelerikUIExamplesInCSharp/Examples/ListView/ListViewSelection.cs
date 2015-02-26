using System;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class ListViewSelection: ExampleViewController
	{
		UILabel label = new UILabel();
		TKListView listView = new TKListView();
		TKDataSource dataSource = new TKDataSource();

		public ListViewSelection ()
		{
			this.AddOption ("Selection on press", SelectionOnPressSelected, "Selection type");
			this.AddOption ("Selection on hold", SelectionOnHoldSelected, "Selection type");
			this.AddOption ("No selection", NoSelectionSelected, "Selection type");
			this.AddOption ("YES", MultipleSelectionSelected, "Multiple selection");
			this.AddOption ("NO", SingleSelectionSelected, "Multiple selection");
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.dataSource.LoadDataFromJSONResource ("ListViewSampleData", "json", "players");

			this.label.Frame = new CGRect (0, this.View.Bounds.Height - 44, this.View.Bounds.Size.Width, 44);
			this.label.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin;
			this.label.TextAlignment = UITextAlignment.Center;
			this.View.AddSubview (this.label);

			this.listView.Frame = new CGRect (0, 0, this.View.Bounds.Size.Width, this.View.Bounds.Size.Height - 55);
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.Delegate = new ListViewDelegate (this);
			this.listView.WeakDataSource = this.dataSource;
			this.listView.SelectionBehavior = TKListViewSelectionBehavior.Press;
			this.listView.AllowsMultipleSelection = true;
			this.View.AddSubview (this.listView);

			TKListViewColumnsLayout layout = new TKListViewColumnsLayout ();
			layout.CellAlignment = TKListViewCellAlignment.Stretch;
			layout.MinimumLineSpacing = 0;

			NSIndexPath indexPath = NSIndexPath.FromRowSection (1, 0);
			this.listView.SelectItem (indexPath, false, UICollectionViewScrollPosition.None);
		}

		void SelectionOnPressSelected(object sender, EventArgs e)
		{
			this.listView.SelectionBehavior = TKListViewSelectionBehavior.Press;
			this.listView.Layout.InvalidateLayout ();
		}

		void SelectionOnHoldSelected(object sender, EventArgs e)
		{
			this.listView.SelectionBehavior = TKListViewSelectionBehavior.LongPress;
		}

		void NoSelectionSelected(object sender, EventArgs e)
		{
			this.listView.SelectionBehavior = TKListViewSelectionBehavior.None;
			this.listView.ClearSelectedItems ();
		}

		void MultipleSelectionSelected (object sender, EventArgs e)
		{
			this.listView.AllowsMultipleSelection = true;
		}

		void SingleSelectionSelected (object sender, EventArgs e)
		{
			this.listView.AllowsMultipleSelection = false;
		}

		class ListViewDelegate: TKListViewDelegate 
		{
			ListViewSelection owner;

			public ListViewDelegate(ListViewSelection owner) 
			{
				this.owner = owner;
			}

			public override void DidSelectItemAtIndexPath (TKListView listView, NSIndexPath indexPath)
			{
				this.owner.label.Text = string.Format("Selected: {0}", this.owner.dataSource.Items[indexPath.Row]);
				Console.WriteLine ("Did select item at row {0}", this.owner.dataSource.Items [indexPath.Row]);
			}

			public override void DidDeselectItemAtIndexPath (TKListView listView, NSIndexPath indexPath)
			{
				Console.WriteLine("Did deselect item at row {0}", this.owner.dataSource.Items[indexPath.Row]);
			}
		}
	}
}

