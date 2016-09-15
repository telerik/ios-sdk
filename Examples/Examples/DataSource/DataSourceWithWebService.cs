using System;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("DataSourceWithWebService")]
	public class DataSourceWithWebService: XamarinExampleViewController
	{
		TKDataSource dataSource = new TKDataSource();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			// >> remote-data-cs
			var chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.Add (chart);
		
			string url = "http://www.telerik.com/docs/default-source/ui-for-ios/weather.json?sfvrsn=2";
			dataSource.LoadDataFromURL (url, TKDataSourceDataFormat.JSON, "dayList", (NSError err) => {
				if (err != null) {
					Console.WriteLine("Can't connect with the server!");
					return;
				}

				dataSource.Settings.Chart.CreateSeries((TKDataSourceGroup group) => {
					TKChartSeries series = null;
					if (group.ValueKey == "clouds") {
						series = new TKChartColumnSeries();
						series.YAxis = new TKChartNumericAxis(NSObject.FromObject(0), NSObject.FromObject(100));
						series.YAxis.Title = "clouds";
						series.YAxis.Style.TitleStyle.RotationAngle = (float)Math.PI/2.0f;
					}
					else {
						series = new TKChartLineSeries();
						series.YAxis = new TKChartNumericAxis(NSObject.FromObject(-10), NSObject.FromObject(30));
						if (group.ValueKey == "temp.min") {
							series.YAxis.Position = TKChartAxisPosition.Right;
							series.YAxis.Title = "temperature";
							series.YAxis.Style.TitleStyle.RotationAngle = (float)Math.PI/2.0f;
							chart.AddAxis(series.YAxis);
						}
					}
					return series;
				});

				dataSource.Map((NSObject item) => {
					double interval = ((NSNumber)item.ValueForKey(new NSString("dateTime"))).DoubleValue;
					NSDate date = NSDate.FromTimeIntervalSince1970(interval);
					item.SetValueForKey(date, new NSString("dateTime"));
					return item;
				});

				NSObject[] items = this.dataSource.Items;
				NSMutableArray newItems = new NSMutableArray();
				newItems.Add(new TKDataSourceGroup(items, "clouds", "dateTime"));
				newItems.Add(new TKDataSourceGroup(items, "temp.min", "dateTime"));
				newItems.Add(new TKDataSourceGroup(items, "temp.max", "dateTime"));
				dataSource.ItemSource = newItems;

				chart.DataSource = dataSource;

				var formatter = new NSDateFormatter();
				formatter.DateFormat = "dd";
				TKChartDateTimeAxis xAxis = (TKChartDateTimeAxis)chart.XAxis;
				xAxis.MajorTickInterval = 1;
				xAxis.PlotMode = TKChartAxisPlotMode.BetweenTicks;
				xAxis.LabelFormatter = formatter;
				xAxis.Title = "date";
				xAxis.MinorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Days;
			});
			// << remote-data-cs
		}
	}
}

