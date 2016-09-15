using System;
using UIKit;
using TelerikUI;
using Foundation;
using CoreGraphics;

namespace Examples
{
	[Register("ListViewBasicSetup")]
	// >> listview-populating-ds-cs
	public class ListViewBasicSetup : XamarinExampleViewController
	{
		NSMutableArray simpleArrayOfStrings;
		TKDataSource dataSource = new TKDataSource();

		public ListViewBasicSetup ()
		{
		}

		public override void ViewDidLoad()
		{
			base.ViewDidLoad();
			// >> listview-feed-cs
			simpleArrayOfStrings = new NSMutableArray();
			simpleArrayOfStrings.Add (new NSString ("Kristina Wolfe"));
			simpleArrayOfStrings.Add (new NSString ("Freda Curtis"));
			simpleArrayOfStrings.Add (new NSString ("Eva Lawson"));
			simpleArrayOfStrings.Add (new NSString ("Emmett Santos"));
			simpleArrayOfStrings.Add (new NSString ("Theresa Bryan"));
			simpleArrayOfStrings.Add (new NSString ("Jenny Fuller"));
			simpleArrayOfStrings.Add (new NSString ("Terrell Norris"));
			simpleArrayOfStrings.Add (new NSString ("Eric Wheeler"));
			simpleArrayOfStrings.Add (new NSString ("Julius Clayton"));
			simpleArrayOfStrings.Add (new NSString ("Harry Douglas"));
			simpleArrayOfStrings.Add (new NSString ("Eduardo Thomas"));
			simpleArrayOfStrings.Add (new NSString ("Orlando Mathis"));
			simpleArrayOfStrings.Add (new NSString ("Alfredo Thornton"));

			// << listview-feed-cs

			// >> listview-feed-ds-cs
			dataSource.ItemSource = simpleArrayOfStrings;
			// << listview-feed-ds-cs

			// >> listview-init-cs
			TKListView listView = new TKListView ();
			listView.Frame = new CGRect (0, 0, this.View.Bounds.Size.Width,this.View.Bounds.Size.Height-20);
			listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			listView.WeakDataSource = dataSource;
			this.View.AddSubview(listView);
			// << listview-init-cs

			// >> listview-init-selec-cs
			listView.AllowsMultipleSelection = true;
			// << listview-init-selec-cs

			// >> listview-init-reorder-cs
			listView.AllowsCellReorder = true;
			// << listview-init-reorder-cs
		}
			
	}
	// << listview-populating-ds-cs
}

