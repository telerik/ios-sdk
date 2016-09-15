using System;
using System.Collections.Generic;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("DataSourceUIBindings")]
	public class DataSourceUIBindings: XamarinExampleViewController
	{
		TKDataSource dataSource = new TKDataSource();

		public override void ViewDidLoad ()
		{
			AddOption ("TKChart", useChart);
			AddOption ("TKCalendar", useCalendar);
			AddOption ("UITableView", useTableView);
			AddOption ("UICollectionView", useCollectionView);
			AddOption ("TKListView", useListView);

			base.ViewDidLoad ();

			string[] imageNames = new string[] {"CENTCM.jpg", "FAMIAF.jpg", "CHOPSF.jpg", "DUMONF.jpg", "ERNSHM.jpg", "FOLIGF.jpg"};
			string[] names = new string[] { "John", "Abby", "Phill", "Saly", "Robert", "Donna" };
			NSMutableArray array = new NSMutableArray ();
			Random r = new Random ();
			for (int i = 0; i < imageNames.Length; i++) {
				UIImage image = UIImage.FromBundle (imageNames [i]);
				this.AddItem (array, names [i], r.Next (100), r.Next (100) > 50 ? "two" : "one", r.Next (10), image);
			}

			this.dataSource.DisplayKey = "Name";
			this.dataSource.ValueKey = "Value";
			this.dataSource.ItemSource = array;

			this.useChart ();
		}

		void useListView()
		{
			if (this.View.Subviews.Length > 0) {
				this.View.Subviews [0].RemoveFromSuperview ();
			}

			TKListView listView = new TKListView (this.View.Bounds);
			listView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			listView.WeakDataSource = this.dataSource;
			this.View.AddSubview (listView);
		}

		void useChart()
		{
			if (this.View.Subviews.Length > 0) {
				this.View.Subviews [0].RemoveFromSuperview ();
			}

			this.dataSource.Settings.Chart.CreateSeries ((TKDataSourceGroup group) => {
				TKChartColumnSeries series = new TKChartColumnSeries();
				series.Selection = TKChartSeriesSelection.DataPoint;
				series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
				return series;
			});

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.DataSource = this.dataSource;
			this.View.AddSubview (chart);
		}

		void useCalendar()
		{
			if (this.View.Subviews.Length > 0) {
				this.View.Subviews [0].RemoveFromSuperview ();
			}

			this.dataSource.Settings.Calendar.StartDateKey = "Date";
			this.dataSource.Settings.Calendar.EndDateKey = "Date";
			this.dataSource.Settings.Calendar.DefaultEventColor = UIColor.Red;

			TKCalendar calendar = new TKCalendar (this.View.Bounds);
			calendar.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (calendar);

			TKCalendarMonthPresenter presenter = (TKCalendarMonthPresenter)calendar.Presenter;
			presenter.InlineEventsViewMode = TKCalendarInlineEventsViewMode.Inline;

			this.dataSource.SetDataSourceFor (calendar);
		}

		void useTableView()
		{
			if (this.View.Subviews.Length > 0) {
				this.View.Subviews [0].RemoveFromSuperview ();
			}

			// optional
			this.dataSource.Settings.TableView.CreateCell ((UITableView tableView, NSIndexPath indexPath, NSObject item) => {
				UITableViewCell cell = tableView.DequeueReusableCell("cell");
				if (cell == null) {
					cell = new UITableViewCell(UITableViewCellStyle.Value1, "cell");
				}
				return cell;
			});

			// optional
			this.dataSource.Settings.TableView.InitCell ((UITableView tableView, NSIndexPath indexPath, UITableViewCell cell, NSObject item) => {
				DSItem dsitem = (DSItem)item;
				cell.TextLabel.Text = dsitem.Name;
				cell.DetailTextLabel.Text = string.Format("{0}", dsitem.Value);
			});

			UITableView table = new UITableView (this.View.Bounds);
			table.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			table.DataSource = this.dataSource;
			this.View.AddSubview (table);
		}

		void useCollectionView()
		{
			if (this.View.Subviews.Length > 0) {
				this.View.Subviews [0].RemoveFromSuperview ();
			}

			this.dataSource.Settings.CollectionView.CreateCell ((UICollectionView collectionView, NSIndexPath indexPath, NSObject item) => {
				return (UICollectionViewCell) collectionView.DequeueReusableCell("cell", indexPath);
			});

			this.dataSource.Settings.CollectionView.InitCell ((UICollectionView collectionView, NSIndexPath indexPath, UICollectionViewCell cell, NSObject item) => {
				DSCollectionViewCell dscell = (DSCollectionViewCell)cell;
				DSItem dsitem = (DSItem)item;
				dscell.Label.Text = this.dataSource.TextFromItem(item, null);
				dscell.ImageView.Image = dsitem.Image;
			});

			UICollectionViewFlowLayout layout = new UICollectionViewFlowLayout ();
			layout.ItemSize = new CGSize (140, 140);

			UICollectionView collection = new UICollectionView (this.View.Bounds, layout);
			collection.RegisterClassForCell (typeof(DSCollectionViewCell), "cell");
			collection.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			collection.DataSource = this.dataSource;
			collection.BackgroundColor = UIColor.White;
			this.View.AddSubview (collection);
		}

		void AddItem(NSMutableArray array, string name, float value, string group, int day, UIImage image)
		{
			NSCalendar calendar = NSCalendar.CurrentCalendar;
			NSDateComponents components = new NSDateComponents ();
			components.Day = day;
			NSDate date = calendar.DateByAddingComponents (components, NSDate.Now, NSCalendarOptions.None);
			DSItem item = new DSItem () {
				Name = name,
				Value = value,
				Group = group,
				Date = date,
				Image = image
			};
			array.Add (item);
		}
	}
}

