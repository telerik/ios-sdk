using System;
using TelerikUI;
using Foundation;
using CoreGraphics;
using ObjCRuntime;

namespace Examples
{
	[Register("ListViewDocsGroupsDelegate")]
	// >> listview-groups-delegate-cs
	public class ListViewDocsGroupsDelegate : XamarinExampleViewController
	{
		public NSMutableArray groups;

		public ListViewDocsGroupsDelegate ()
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			groups = new NSMutableArray ();
			groups.Add (NSArray.FromStrings (new string[] { "John", "Abby" }));
			groups.Add(NSArray.FromStrings (new string[] { "Smith", "Peter", "Paula" }));

			TKListView listView = new TKListView (new CGRect (20, 20, this.View.Bounds.Size.Width - 40, this.View.Bounds.Size.Height - 40));
			listView.RegisterClassForCell (new Class (typeof(TKListViewCell)), "cell");

			listView.RegisterClassForSupplementaryView (new Class (typeof(TKListViewHeaderCell)), TKListViewElementKindSectionKey.Header, new NSString("header"));
			listView.DataSource = new ListViewDataSource (this);
			TKListViewLinearLayout layout = (TKListViewLinearLayout)listView.Layout;
			layout.HeaderReferenceSize = new CGSize (200, 22);

			this.View.AddSubview (listView);
		}
	}

	class ListViewDataSource : TKListViewDataSource
	{
		ListViewDocsGroupsDelegate owner;

		public ListViewDataSource (ListViewDocsGroupsDelegate owner)
		{
			this.owner = owner;
		}

		public override int NumberOfSectionsInListView (TKListView listView)
		{
			return (int)this.owner.groups.Count;
		}

		public override int NumberOfItemsInSection (TKListView listView, int section)
		{
			return (int)this.owner.groups.GetItem<NSArray>((uint)section).Count;
		}

		public override TKListViewCell CellForItem (TKListView listView, NSIndexPath indexPath)
		{
			TKListViewCell cell = listView.DequeueReusableCell("cell", indexPath) as TKListViewCell;
			cell.TextLabel.Text = this.owner.groups.GetItem<NSArray> ((uint)indexPath.Section).GetItem<NSString> ((uint)indexPath.Row);
			return cell;
		}

		public override TKListViewReusableCell ViewForSupplementaryElementOfKind (TKListView listView, NSString kind, NSIndexPath indexPath)
		{
			TKListViewReusableCell headerCell = listView.DequeueReusableSupplementaryView(kind, "header", indexPath) as TKListViewReusableCell;
			headerCell.TextLabel.Text = String.Format ("Group {0}", indexPath.Section);
			return headerCell;
		}
	}
	// << listview-groups-delegate-cs
}

