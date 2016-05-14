using System;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("DataSourceDescriptorsAPI")]
	public class DataSourceDescriptorsAPI: XamarinExampleViewController
	{
		TKDataSource dataSource;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			dataSource = new TKDataSource ();

			dataSource.AddFilterDescriptor (new TKDataSourceFilterDescriptor ("NOT (Name like 'John')"));
			dataSource.AddSortDescriptor (new TKDataSourceSortDescriptor ("Name", true));
			dataSource.AddGroupDescriptor (new TKDataSourceGroupDescriptor ("Group"));

			var array = new NSMutableArray ();
			array.Add (new DSItem () { Name = "John", Value = 22.0f, Group = "one" });
			array.Add (new DSItem () { Name = "Peter", Value = 15.0f, Group = "one" });
			array.Add (new DSItem () { Name = "Abby", Value = 47.0f, Group = "one" });
			array.Add (new DSItem () { Name = "Robert", Value = 45.0f, Group = "two" });
			array.Add (new DSItem () { Name = "Alan", Value = 17.0f, Group = "two" });
			array.Add (new DSItem () { Name = "Saly", Value = 33.0f, Group = "two" });

			dataSource.DisplayKey = "Name";
			dataSource.ValueKey = "Value";
			dataSource.ItemSource = array;

			var tableView = new UITableView (this.View.Bounds);
			tableView.DataSource = dataSource;
			this.View.AddSubview (tableView);
		}
	}
}

