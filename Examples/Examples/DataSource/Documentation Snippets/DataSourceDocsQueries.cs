using System;
using Foundation;
using TelerikUI;
using UIKit;

namespace Examples
{
	[Register("DataSourceDocsQueries")]
	// >> datasource-predicate-style-cs
	public class DataSourceDocsQueries : XamarinExampleViewController
	{
		TKDataSource dataSource;

		public DataSourceDocsQueries ()
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			// >> datasource-displaykey-cs
			NSMutableArray items = new NSMutableArray();
			items.Add (new DSItem () { Name = "John", Value = 50, Group = "A" });
			items.Add (new DSItem () { Name = "Abby", Value = 33, Group = "A" });
			items.Add (new DSItem () { Name = "Smith", Value = 42, Group = "B" });
			items.Add (new DSItem () { Name = "Peter", Value = 28, Group = "B" });
			items.Add (new DSItem () { Name = "Paula", Value = 25, Group = "B" });

			this.dataSource = new TKDataSource ();
			this.dataSource.ItemSource = items;
			this.dataSource.DisplayKey = "Name";
			// << datasource-displaykey-cs

			this.dataSource.FilterWithQuery ("Value > 30");
			this.dataSource.SortWithKey ("Value", true);
			this.dataSource.GroupWithKey ("Group");


			UITableView tableView = new UITableView (this.View.Bounds);
			tableView.DataSource = this.dataSource;
			this.View.AddSubview (tableView);
		}
	}
	// << datasource-predicate-style-cs
}

