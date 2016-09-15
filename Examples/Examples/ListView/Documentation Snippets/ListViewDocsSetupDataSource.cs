using System;
using TelerikUI;
using ObjCRuntime;
using Foundation;

namespace Examples
{
	[Register("ListViewDocsSetupDataSource")]
	// >> listview-populating-cs
	public class ListViewDocsSetupDataSource : XamarinExampleViewController
	{
		public NSArray sampleArrayOfStrings;

		public ListViewDocsSetupDataSource ()
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.sampleArrayOfStrings = NSArray.FromStrings (new String [] { 
				"Kristina Wolfe",
				"Freda Curtis",
				"Jeffery Francis",
				"Eva Lawson",
				"Emmett Santos",
				"Theresa Bryan",
				"Jenny Fuller",
				"Terrell Norris",
				"Eric Wheeler",
				"Julius Clayton",
				"Alfredo Thornton",
				"Roberto Romero",
				"Orlando Mathis",
				"Eduardo Thomas",
				"Harry Douglas"
			});

			TKListView listView = new TKListView (this.View.Bounds);
			listView.RegisterClassForCell (new Class (typeof(TKListViewCell)), "cell");
			listView.DataSource = new ListViewDataSource (this);

			this.View.AddSubview (listView);

		}

		class ListViewDataSource: TKListViewDataSource
		{
			ListViewDocsSetupDataSource owner;

			public ListViewDataSource(ListViewDocsSetupDataSource owner)
			{
				this.owner = owner;
			}

			public override int NumberOfItemsInSection (TKListView listView, int section)	{
				return (int)this.owner.sampleArrayOfStrings.Count;
			}

			public override int NumberOfSectionsInListView (TKListView listView)
			{
				return 1;
			}

			public override TKListViewCell CellForItem (TKListView listView, NSIndexPath indexPath)
			{
				TKListViewCell cell = listView.DequeueReusableCell ("cell", indexPath) as TKListViewCell;
				cell.TextLabel.Text = this.owner.sampleArrayOfStrings.GetItem<NSString> ((uint)indexPath.Row);
				return cell;
			}
		}
	}
	// << listview-populating-cs
}

