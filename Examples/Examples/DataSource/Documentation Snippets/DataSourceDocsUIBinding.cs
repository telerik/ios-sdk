using System;
using UIKit;
using CoreGraphics;
using Foundation;
using TelerikUI;

namespace Examples
{
	public class DataSourceDocsUIBinding : UIViewController
	{
		TKDataSource dataSource;

		public DataSourceDocsUIBinding ()
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
		}

		public void setupTableView()
		{
			// >> datasource-tableview-ui-cs
			NSObject[] array = new NSObject[] {
				NSObject.FromObject (10),
				NSObject.FromObject (5),
				NSObject.FromObject (12),
				NSObject.FromObject (13),
				NSObject.FromObject (7),
				NSObject.FromObject (44)
			};

			this.dataSource = new TKDataSource (array);

			CGRect rect = this.View.Bounds;
			rect.Inflate (0, -30);
			UITableView table = new UITableView (rect);
			table.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			table.DataSource = this.dataSource;
			this.View.AddSubview (table);
			// << datasource-tableview-ui-cs

			// >> datasource-cell-init-cs
			this.dataSource.Settings.TableView.InitCell ((UITableView tableView, NSIndexPath indexPath, UITableViewCell cell, NSObject item) => {
				cell.TextLabel.Text = "Item:";
				cell.DetailTextLabel.Text = this.dataSource.TextFromItem(item, null);
			});
			// << datasource-cell-init-cs

			// >> datasource-cell-create-cs
			this.dataSource.Settings.TableView.CreateCell ((UITableView tableView, NSIndexPath indexPath, NSObject item) => {
				UITableViewCell cell = tableView.DequeueReusableCell("cell");
				if (cell == null) {
					cell = new UITableViewCell(UITableViewCellStyle.Value1, "cell");
				}
				return cell;
			});
			// << datasource-cell-create-cs

			// >> datasource-cell-group-cs
			this.dataSource.Group ((NSObject item) => {
				return NSObject.FromObject(((NSNumber)item).Int32Value % 2 == 0);
			});
			// << datasource-cell-group-cs
		}

		public void setupCollectionView()
		{
			// >> datasource-collectionview-ui-cs
			var layout = new UICollectionViewFlowLayout();
			layout.ItemSize = new CGSize (140, 140);

			CGRect rect = this.View.Bounds;
			rect.Inflate (0, -30);
			var collectionView = new UICollectionView (rect, layout);
			collectionView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			collectionView.DataSource = this.dataSource;
			collectionView.BackgroundColor = UIColor.White;
			this.View.AddSubview(collectionView);
			// << datasource-collectionview-ui-cs

			// >> datasource-collectionview-cell-init-cs
			this.dataSource.Settings.CollectionView.InitCell ((UICollectionView collection, NSIndexPath indexPath, UICollectionViewCell cell, NSObject item) => {
				var tkCell = cell as TKCollectionViewCell;
				tkCell.Label.Text = this.dataSource.TextFromItem(item, null);
				tkCell.BackgroundColor = UIColor.Yellow;
			});
			// << datasource-collectionview-cell-init-cs
		}

		public void setupListView()
		{
			// >> datasource-listview-ui-cs
			CGRect rect = this.View.Bounds;
			rect.Inflate (0, -30);
			var listView = new TKListView (rect);
			listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.dataSource.SetDataSourceFor (listView);
			this.View.AddSubview (listView);
			// << datasource-listview-ui-cs

			// >> datasource-listview-cell-create-cs
			this.dataSource.Settings.ListView.CreateCell ((TKListView list1, NSIndexPath indexPath, NSObject item) => {
				return list1.DequeueReusableCell("myCustomCell", indexPath) as TKListViewCell;
			});

			this.dataSource.Settings.ListView.InitCell ((TKListView list2, NSIndexPath indexPath, TKListViewCell cell, NSObject item) => {
				cell.TextLabel.Text = this.dataSource.TextFromItem(item, null);
				(cell.BackgroundView as TKView).Fill = new TKSolidFill(new UIColor(0.1f, 0.1f, 0.1f, 0.1f));
			});
			// << datasource-listview-cell-create-cs
		}

		public void setupChart()
		{
			// >> datasource-chart-ui-cs
			NSMutableArray items = new NSMutableArray ();
			items.Add (new DSItem () { Name = "John", Value = 50, Group = "A" });
			items.Add (new DSItem () { Name = "Abby", Value = 33, Group = "A" });
			items.Add (new DSItem () { Name = "Paula", Value = 33, Group = "A" });

			items.Add (new DSItem () { Name = "John", Value = 42, Group = "B" });
			items.Add (new DSItem () { Name = "Abby", Value = 28, Group = "B" });
			items.Add (new DSItem () { Name = "Paula", Value = 25, Group = "B" });

			this.dataSource.DisplayKey = "Name";
			this.dataSource.ValueKey = "Value";
			this.dataSource.ItemSource = items;

			var chart = new TKChart(this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.DataSource = this.dataSource;
			this.View.AddSubview(chart);
			// << datasource-chart-ui-cs

			// >> datasource-chart-series-cs
			this.dataSource.GroupWithKey ("Group");

			this.dataSource.Settings.Chart.CreateSeries ((TKDataSourceGroup group) => {
				var series = new TKChartColumnSeries();
				return series;
			});
			// << datasource-chart-series-cs
		}

		public void setupCalendar()
		{
			NSMutableArray items = new NSMutableArray ();

			// >> datasource-calendar-ui-cs
			this.dataSource.DisplayKey = "Name";
			this.dataSource.Settings.Calendar.StartDateKey = "StartDate";
			this.dataSource.Settings.Calendar.EndDateKey = "EndDate";
			this.dataSource.Settings.Calendar.DefaultEventColor = UIColor.Red;
			this.dataSource.ItemSource = items;

			var calendar = new TKCalendar (this.View.Bounds);
			calendar.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.dataSource.SetDataSourceFor (calendar);
			this.View.AddSubview (calendar);
			// << datasource-calendar-ui-cs
		}


	}
}

