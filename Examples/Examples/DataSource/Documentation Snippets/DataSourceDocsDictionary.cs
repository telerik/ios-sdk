using System;
using UIKit;
using Foundation;
using TelerikUI;

namespace Examples
{
	public class DataSourceDocsDictionary : UIViewController
	{
		public DataSourceDocsDictionary ()
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			// >> datasource-dict-cs
			NSMutableDictionary dict = new NSMutableDictionary();
			dict.Add (new NSString ("John"), NSObject.FromObject (50));
			dict.Add (new NSString ("Abby"), NSObject.FromObject (33));
			dict.Add (new NSString ("Smith"), NSObject.FromObject (42));
			dict.Add (new NSString ("Peter"), NSObject.FromObject (28));
			dict.Add (new NSString ("Paula"), NSObject.FromObject (25));

			TKDataSource dataSource = new TKDataSource ();
			dataSource.ItemSource = dict;
			dataSource.SortWithKey ("", true);
			dataSource.Filter ((NSObject item) => {
				return ((NSNumber)dict.ObjectForKey(item)).Int32Value > 30;
			});
			// << datasource-dict-cs
		}
	}
}

