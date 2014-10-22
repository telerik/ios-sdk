using System;

using MonoTouch.Foundation;
using MonoTouch.UIKit;
using System.Drawing;

namespace Examples
{
	public class SettingsViewController: UIViewController
	{
		public ExampleViewController owner;

		public UITableView Table { get; set; }

		public SettingsViewController (ExampleViewController owner)
		{
			this.owner = owner;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.View.BackgroundColor = UIColor.White;
			this.Title = "Settings";

			this.Table = new UITableView(this.View.Bounds);
			this.Table.RegisterClassForCellReuse (typeof(UITableViewCell), new NSString("cell"));
			this.Table.DataSource = new TableViewDataSource(this);
			this.Table.Delegate = new TableViewDelegate(this);
			this.View.AddSubview(this.Table);

			NSIndexPath path = NSIndexPath.FromRowSection(this.owner.SelectedOption, 0);
			this.Table.SelectRow(path, false, UITableViewScrollPosition.Middle);
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();
			this.Table.Frame = this.View.Bounds;
		}

		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();

			// Release any cached data, images, etc that aren't in use.
		}

		public class TableViewDataSource: UITableViewDataSource
		{
			SettingsViewController owner;

			public TableViewDataSource(SettingsViewController owner)
			{
				this.owner = owner;
			}

			public override int RowsInSection (UITableView tableView, int section)
			{
				return owner.owner.Options.Length;
			}

			public override UITableViewCell GetCell (UITableView tableView, NSIndexPath indexPath)
			{
				OptionInfo info = owner.owner.Options [indexPath.Row];
				UITableViewCell cell = tableView.DequeueReusableCell ("cell");
				cell.TextLabel.Text = info.OptionText;
				cell.SelectionStyle = UITableViewCellSelectionStyle.None;
				if (indexPath.Row == this.owner.owner.SelectedOption)
					cell.Accessory = UITableViewCellAccessory.Checkmark;
				return cell;
			}
		}

		public class TableViewDelegate: UITableViewDelegate
		{
			SettingsViewController owner;

			public TableViewDelegate(SettingsViewController owner)
			{
				this.owner = owner;
			}

			public override void RowSelected (UITableView tableView, NSIndexPath indexPath)
			{
				this.owner.owner.SelectedOption = indexPath.Row;
				OptionInfo info = this.owner.owner.Options [indexPath.Row];
				if (info.Handler != null) {
					info.Handler (info, EventArgs.Empty);
				}
				if (this.owner.owner.Popover != null && this.owner.owner.Popover.PopoverVisible)
					this.owner.owner.Popover.Dismiss (false);
				else
					this.owner.NavigationController.PopViewControllerAnimated (true);
			}
		}
	}
}

