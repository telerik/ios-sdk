using System;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("DataSourceDescriptorsAPI")]
	// >> datasource-descriptor-cs
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

			// >> datasource-feed-object-cs
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
			// << datasource-feed-object-cs

			// >> datasource-text-cs
			dataSource.FormatText ((NSObject item, TKDataSourceGroup group) => {
				DSItem dsItem = (DSItem)item;
				return new NSString(string.Format("{0} has {1} points", dsItem.Name, dsItem.Value));
			});
			// << datasource-text-cs

			var tableView = new UITableView (this.View.Bounds);
			tableView.DataSource = dataSource;
			this.View.AddSubview (tableView);
		}
	}
	// << datasource-descriptor-cs
}

