using System;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace Examples
{
	public class IndicatorsTableView: UIViewController
	{
		IndicatorsChart example;
		UITableView table;

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
			table.DataSource = new TableDataSource (example);
			table.Delegate = new TableDelegate (example);
			table.AllowsMultipleSelection = true;
			table.BackgroundColor = UIColor.White;
			this.View.AddSubview (table);

			table.SelectRow (NSIndexPath.FromRowSection (example.SelectedTrendLine, 0), false, UITableViewScrollPosition.None);
			table.SelectRow (NSIndexPath.FromRowSection (example.SelectedIndicator, 1), false, UITableViewScrollPosition.None);
		}

		class TableDataSource: UITableViewDataSource
		{
			IndicatorsChart example;

			public TableDataSource(IndicatorsChart example)
			{
				this.example = example;
			}

			public override int NumberOfSections (UITableView tableView)
			{
				return 2;
			}

			public override int RowsInSection (UITableView tableView, int section)
			{
				if (section == 0) {
					return example.Trendlines.Count;
				}
				return example.Indicators.Count;
			}

			public override string TitleForHeader (UITableView tableView, int section)
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
				if ((indexPath.Section == 0 && indexPath.Row == example.SelectedTrendLine) ||
				    (indexPath.Section == 1 && indexPath.Row == example.SelectedIndicator)) {
					cell.Accessory = UITableViewCellAccessory.Checkmark;
				} else {
					cell.Accessory = UITableViewCellAccessory.None;
				}
				OptionInfo info = indexPath.Section == 0 ? example.Trendlines [indexPath.Row] : example.Indicators [indexPath.Row];
				cell.TextLabel.Text = info.OptionText;
				return cell;
			}
		}

		class TableDelegate: UITableViewDelegate
		{
			IndicatorsChart example;

			public TableDelegate(IndicatorsChart example)
			{
				this.example = example;
			}

			public override float GetHeightForHeader (UITableView tableView, int section)
			{
				return 40;
			}

			public override void RowSelected (UITableView tableView, NSIndexPath indexPath)
			{
				OptionInfo info = null;

				if (indexPath.Section == 0) {
					tableView.DeselectRow (NSIndexPath.FromRowSection (example.SelectedTrendLine, 0), false);
					example.SelectedTrendLine = indexPath.Row;
					info = example.Trendlines [indexPath.Row];
				} else {
					tableView.DeselectRow (NSIndexPath.FromRowSection (example.SelectedIndicator, 1), false);
					example.SelectedIndicator = indexPath.Row;
					info = example.Indicators [indexPath.Row];
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

