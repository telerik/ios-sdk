using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("DataSourceGettingStarted")]
	public class DataSourceGettingStarted: XamarinExampleViewController
	{
		TKDataSource dataSource;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			dataSource = new TKDataSource (ArrayWithObjects(new object [] { 10, 5, 12, 7, 44 }), null);

			// filter all values less or equal to 3
			dataSource.Filter ((NSObject item) => {
				return ((NSNumber)item).NIntValue > 5;
			});

			// sort ascending
			dataSource.Sort ((NSObject obj1, NSObject obj2) => {
				nint a = ((NSNumber)obj1).NIntValue;
				nint b = ((NSNumber)obj2).NIntValue;
				if (a<b) return NSComparisonResult.Descending; 
				else if (a>b) return NSComparisonResult.Ascending;
				return NSComparisonResult.Same;
			});

			// group odd/even values
			dataSource.Group ((NSObject item) => {
				return NSObject.FromObject(((NSNumber)item).NIntValue % 2 == 0);
			});

			// multiply every value * 10
			dataSource.Map ((NSObject item) => {
				return NSObject.FromObject(((NSNumber)item).NIntValue * 10);
			});

			// find the max value
			NSObject maxValue = dataSource.Reduce (NSObject.FromObject(0), (NSObject item, NSObject value) => {
				if (((NSNumber)item).NIntValue > ((NSNumber)value).NIntValue) 
					return item;
				return value;
			});
			Console.WriteLine ("the max value is: {0}", ((NSNumber)maxValue).NIntValue);

			// output everything to the console
			dataSource.Enumerate ((NSObject item) => {
				if (item.IsKindOfClass(new ObjCRuntime.Class(typeof(TKDataSourceGroup)))) {
					TKDataSourceGroup group = (TKDataSourceGroup)item;
					Console.WriteLine("group: {0}", group.Key);
				}
				else {
					Console.WriteLine("{0}", ((NSNumber)item).NIntValue);
				}
			});

			// bind with a table view
			var tableView = new UITableView (this.View.Bounds);
			tableView.DataSource = dataSource;
			this.View.AddSubview (tableView);
		}

		NSObject[] ArrayWithObjects(object[] objects)
		{
			List<NSObject> array = new List<NSObject>();
			for (int i = 0; i<objects.Length; i++) {
				array.Add (NSObject.FromObject (objects [i]));
			}
			return array.ToArray();
		}
	}
}

