using System;

using Foundation;
using UIKit;

using System.Drawing;

namespace Examples
{
	public class SettingsViewController: UIViewController
	{
		public ExampleViewController owner;
		TableViewDelegate tableViewDelegate;
		TableViewDataSource tableViewDataSource;

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

			this.tableViewDataSource = new TableViewDataSource(this);
			this.tableViewDelegate = new TableViewDelegate (this);

			this.Table = new UITableView(this.View.Bounds);
			this.Table.RegisterClassForCellReuse (typeof(UITableViewCell), new NSString("cell"));
			this.Table.DataSource = this.tableViewDataSource;
			this.Table.Delegate = this.tableViewDelegate;
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

			public override nint NumberOfSections (UITableView tableView)
			{
				if (this.owner.owner.Sections.Length > 0) {
					return this.owner.owner.Sections.Length;
				}

				return 1;
			}

			public override nint RowsInSection (UITableView tableView, nint section)
			{
				if (this.owner.owner.Sections.Length > 0) {
					OptionSection sectionInfo = this.owner.owner.Sections[section];
					return sectionInfo.Items.Count;
				}

				return owner.owner.Options.Length;
			}

			public override string TitleForHeader (UITableView tableView, nint section)
			{
				OptionSection sectionInfo = this.owner.owner.Sections[section];
				return sectionInfo.Title;
			}

			public override UITableViewCell GetCell (UITableView tableView, NSIndexPath indexPath)
			{
				UITableViewCell cell = tableView.DequeueReusableCell ("cell");
				OptionInfo info = null;
				if (this.owner.owner.Sections.Length > 0) {
					OptionSection sectionInfo = this.owner.owner.Sections [indexPath.Section];
					info = sectionInfo.Items [indexPath.Row];
					if (indexPath.Row == sectionInfo.SelectedOption) {
						cell.Accessory = UITableViewCellAccessory.Checkmark;
					}
				} else {
					info = this.owner.owner.Options [indexPath.Row];
					if (indexPath.Row == this.owner.owner.SelectedOption) {
						cell.Accessory = UITableViewCellAccessory.Checkmark;
					}
				}

				cell.TextLabel.Text = info.OptionText;
				cell.SelectionStyle = UITableViewCellSelectionStyle.None;
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

			public override nfloat GetHeightForHeader (UITableView tableView, nint section)
			{
				if (this.owner.owner.Sections.Length > 0) {
					return 44;
				}

				return 0;
			}

			public override void RowSelected (UITableView tableView, NSIndexPath indexPath)
			{
				this.owner.owner.SelectedOption = indexPath.Row;
				OptionInfo info = null;
				if (this.owner.owner.Sections.Length > 0) {
					OptionSection sectionInfo = this.owner.owner.Sections [indexPath.Section];
					info = sectionInfo.Items [indexPath.Row];
					sectionInfo.SelectedOption = indexPath.Row;
				} else {
					info = this.owner.owner.Options [indexPath.Row];
					this.owner.owner.SelectedOption = indexPath.Row;
				}

				if (info.Handler != null) {
					info.Handler (info, EventArgs.Empty);
				}

				if (this.owner.owner.Popover != null && this.owner.owner.Popover.PopoverVisible)
					this.owner.owner.Popover.Dismiss (false);
				else
					this.owner.NavigationController.PopViewController (true);
			}
		}
	}
}

