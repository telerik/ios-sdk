using System;

using Foundation;
using UIKit;

namespace Examples
{
	public class IndicatorsTableView: UIViewController
	{
		IndicatorsChart example;
		UITableView table;
		TableDataSource tableDataSource = new TableDataSource();
		TableDelegate tableDelegate = new TableDelegate();

		public UITableView Table 
		{
			get { return table; }
		}

		public IndicatorsTableView (IndicatorsChart example)
		{
			this.example = example;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			table = new UITableView (this.View.Bounds);
			table.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			table.RegisterClassForCellReuse (typeof(UITableViewCell), new NSString("cell"));
			table.DataSource = tableDataSource;
			table.Delegate = tableDelegate;
			table.AllowsMultipleSelection = true;
			table.BackgroundColor = UIColor.White;
			this.View.AddSubview (table);

			tableDataSource.Example = example;
			tableDelegate.Example = example;

			table.SelectRow (NSIndexPath.FromRowSection (example.SelectedTrendLine, 0), false, UITableViewScrollPosition.None);
			table.SelectRow (NSIndexPath.FromRowSection (example.SelectedIndicator, 1), false, UITableViewScrollPosition.None);
		}

		class TableDataSource: UITableViewDataSource
		{
			public IndicatorsChart Example;

			public override nint NumberOfSections (UITableView tableView)
			{
				return 2;
			}

			public override nint RowsInSection (UITableView tableView, nint section)
			{
				if (section == 0) {
					return Example.Trendlines.Count;
				}
				return Example.Indicators.Count;
			}

			public override string TitleForHeader (UITableView tableView, nint section)
			{
				if (section == 0) {
					return "Trendlines";
				}
				return "Indicators";
			}

			public override UITableViewCell GetCell (UITableView tableView, NSIndexPath indexPath)
			{
				UITableViewCell cell = tableView.DequeueReusableCell ("cell");
				cell.SelectionStyle = UITableViewCellSelectionStyle.None;
				if ((indexPath.Section == 0 && indexPath.Row == Example.SelectedTrendLine) ||
				    (indexPath.Section == 1 && indexPath.Row == Example.SelectedIndicator)) {
					cell.Accessory = UITableViewCellAccessory.Checkmark;
				} else {
					cell.Accessory = UITableViewCellAccessory.None;
				}
				OptionInfo info = indexPath.Section == 0 ? Example.Trendlines [indexPath.Row] : Example.Indicators [indexPath.Row];
				cell.TextLabel.Text = info.OptionText;
				return cell;
			}
		}

		class TableDelegate: UITableViewDelegate
		{
			public IndicatorsChart Example;

			public override nfloat GetHeightForHeader (UITableView tableView, nint section)
			{
				return 40;
			}

			public override void RowSelected (UITableView tableView, NSIndexPath indexPath)
			{
				OptionInfo info = null;

				if (indexPath.Section == 0) {
					tableView.DeselectRow (NSIndexPath.FromRowSection (Example.SelectedTrendLine, 0), false);
					Example.SelectedTrendLine = indexPath.Row;
					info = Example.Trendlines [indexPath.Row];
				} else {
					tableView.DeselectRow (NSIndexPath.FromRowSection (Example.SelectedIndicator, 1), false);
					Example.SelectedIndicator = indexPath.Row;
					info = Example.Indicators [indexPath.Row];
				}

				info.Handler (info, EventArgs.Empty);
				tableView.ReloadData ();
			}

			public override NSIndexPath WillDeselectRow (UITableView tableView, NSIndexPath indexPath)
			{
				return null;
			}
		}
	}
}

