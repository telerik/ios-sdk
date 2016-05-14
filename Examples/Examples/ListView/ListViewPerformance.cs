using System;
using System.Collections;
using System.Collections.Generic;
using Foundation;
using UIKit;
using TelerikUI;
using CoreGraphics;
using System.Globalization;

namespace Examples
{
	[Register("ListViewPerformance")]
	public class ListViewPerformance: XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			var button = new UIButton (UIButtonType.System);
			button.Frame = new CGRect(20, this.View.Center.Y - 22, this.View.Frame.Width-40, 44);
			button.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleBottomMargin;
			button.SetTitle ("Load 10000 items", UIControlState.Normal);
			button.AddTarget ((object sender, EventArgs e) => {
				int systemVersion = int.Parse(UIDevice.CurrentDevice.SystemVersion.Split('.')[0]);
				if (systemVersion < 9) {
					var alert = new TKAlert();
					alert.Title = "Telerik UI";
					alert.Message = "TKListView is optimized for performance when using dynamic item sizing only when running on iOS 9 and upper!";
					alert.AddAction(new TKAlertAction("OK", (TKAlert arg1, TKAlertAction arg2) => {
						this.CreateListView();
						return true;
					}));
					alert.Show(true);
				}
				else {
					this.CreateListView();
				}

				((UIView)sender).RemoveFromSuperview();

			}, UIControlEvent.TouchUpInside);
			this.View.AddSubview(button);
		}

		void CreateListView()
		{
			var list = new TKListView (this.View.Bounds);
			list.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			list.RegisterClassForCell (new ObjCRuntime.Class(typeof(ListViewVariableSizeCell)), "cell");
			this.View.AddSubview (list);

			TKListViewLinearLayout layout = (TKListViewLinearLayout)list.Layout;
			layout.DynamicItemSize = true;

			list.WeakDataSource = new ListViewDataSource();
		}

		class ListViewDataSource: TKListViewDataSource
		{
			List<string> items = new List<string>();

			public ListViewDataSource()
			{
				var random = new Random();
				var generator = new LoremIpsumGenerator();
				for (int i = 0; i<10000; i++) {
					items.Add(generator.GenerateString(3 + random.Next(50) + random.Next(30)));
				}
			}

			public override int NumberOfItemsInSection (TKListView listView, int section)
			{
				return items.Count;
			}

			public override TKListViewCell CellForItem (TKListView listView, NSIndexPath indexPath)
			{
				var cell = listView.DequeueReusableCell ("cell", indexPath) as ListViewVariableSizeCell;
				cell.label.Text = this.items[indexPath.Row];
				return cell;
			}
		}
	}
}

