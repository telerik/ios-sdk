using System;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("ListViewSelection")]
	public class ListViewSelection: XamarinExampleViewController
	{
		UILabel label = new UILabel();
		TKListView listView = new TKListView();
		TKDataSource dataSource = new TKDataSource();
		ListViewDelegate listViewDelegage;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Selection on press", "Selection type", SelectionOnPressSelected);
			this.AddOption ("Selection on hold", "Selection type", SelectionOnHoldSelected);
			this.AddOption ("No selection", "Selection type", NoSelectionSelected);
			this.AddOption ("YES", "Multiple selection", MultipleSelectionSelected);
			this.AddOption ("NO", "Multiple selection", SingleSelectionSelected);

			base.ViewDidLoad ();

			this.dataSource.LoadDataFromJSONResource ("ListViewSampleData", "json", "players");

			this.label.Frame = new CGRect (0, this.View.Bounds.Height - 44, this.View.Bounds.Size.Width, 44);
			this.label.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin;
			this.label.TextAlignment = UITextAlignment.Center;
			this.View.AddSubview (this.label);

			this.listViewDelegage = new ListViewDelegate (this);

			this.listView.Frame = new CGRect (0, 0, this.View.Bounds.Size.Width, this.View.Bounds.Size.Height - 55);
			this.listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.listView.Delegate = this.listViewDelegage;
			this.listView.WeakDataSource = this.dataSource;

			// >> listview-selection-behavior-cs
			this.listView.SelectionBehavior = TKListViewSelectionBehavior.Press;
			// << listview-selection-behavior-cs

			// >> listview-multiple-selection-cs
			this.listView.AllowsMultipleSelection = true;
			// << listview-multiple-selection-cs

			this.View.AddSubview (this.listView);

			TKListViewLinearLayout layout = new TKListViewLinearLayout ();
			layout.ItemAlignment = TKListViewItemAlignment.Stretch;
			layout.ItemSpacing = 0;

			// >> listview-selection-programatically-cs
			NSIndexPath indexPath = NSIndexPath.FromRowSection (1, 0);
			this.listView.SelectItem (indexPath, false, UICollectionViewScrollPosition.None);
			// << listview-selection-programatically-cs
		}

		void SelectionOnPressSelected()
		{
			this.listView.SelectionBehavior = TKListViewSelectionBehavior.Press;
		}

		void SelectionOnHoldSelected()
		{
			// >> listview-selection-behavior-long-cs
			this.listView.SelectionBehavior = TKListViewSelectionBehavior.LongPress;
			// << listview-selection-behavior-long-cs
		}

		void NoSelectionSelected()
		{
			// >> listview-selection-behavior-none-cs
			this.listView.SelectionBehavior = TKListViewSelectionBehavior.None;
			// << listview-selection-behavior-none-cs
			this.label.Text = "";
		}

		void MultipleSelectionSelected ()
		{
			this.listView.AllowsMultipleSelection = true;
		}

		void SingleSelectionSelected ()
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

			public override void DidHighlightItemAtIndexPath (TKListView listView, NSIndexPath indexPath)
			{
				Console.WriteLine ("Did highlight item at row {0}", this.owner.dataSource.Items [indexPath.Row]);
				TKListViewCell cell = listView.CellForItem (indexPath);
				if (!cell.Selected && listView.SelectionBehavior == TKListViewSelectionBehavior.LongPress)
				{
					cell.SelectedBackgroundView.Hidden = true;
				}
			}

			public override void DidUnhighlightItemAtIndexPath (TKListView listView, NSIndexPath indexPath)
			{
				Console.WriteLine ("Did unhighlight item at row {0}", this.owner.dataSource.Items [indexPath.Row]);
			}

			// >> listview-respond-cs
			public override void DidSelectItemAtIndexPath (TKListView listView, NSIndexPath indexPath)
			{
				this.owner.label.Text = string.Format("Selected: {0}", this.owner.dataSource.Items[indexPath.Row]);
				Console.WriteLine ("Did select item at row {0}", this.owner.dataSource.Items [indexPath.Row]);
				TKListViewCell cell = listView.CellForItem (indexPath);
				if (cell != null) {
					cell.SelectedBackgroundView.Hidden = false;
				}
			}

			public override void DidDeselectItemAtIndexPath (TKListView listView, NSIndexPath indexPath)
			{
				Console.WriteLine("Did deselect item at row {0}", this.owner.dataSource.Items[indexPath.Row]);
			}

			// << listview-respond-cs
		}
	}
}

