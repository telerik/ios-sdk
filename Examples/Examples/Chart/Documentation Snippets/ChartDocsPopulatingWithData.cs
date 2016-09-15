using System;
using TelerikUI;
using Foundation;
using UIKit;
using CoreGraphics;
using System.Collections.Generic;

namespace Examples
{
	// >> chart-populating-delegate-cs
	public class ChartDocsPopulatingWithData : UIViewController
	{
		public ChartDocsPopulatingWithData ()
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			var chart = new TKChart (CGRect.Inflate (this.View.Bounds, -10, -10));
			this.View.AddSubview (chart);
			chart.DataSource = new ChartDataSource ();
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
		}

		class ChartDataSource: TKChartDataSource
		{
			Random r = new Random();

			public override nuint NumberOfSeries (TKChart chart)
			{
				return 1;
			}

			public override nuint PointsInSeries (TKChart chart, nuint seriesIndex)
			{
				return 10;
			}

			public override TKChartSeries GetSeries (TKChart chart, nuint index)
			{
				var series = chart.DequeueReusableSeriesWithIdentifier ("series1") as TKChartSeries;
				if (series == null) {
					series = new TKChartLineSeries (null, "series1");
					series.Title = "Series title";
				}
				return series;
			}

			public override ITKChartData GetPoint (TKChart chart, nuint dataIndex, nuint seriesIndex)
			{
				var point = new TKChartDataPoint (new NSNumber (dataIndex), new NSNumber(r.Next (100)));
				return point;
			}
		}
		// << chart-populating-delegate-cs

		void snippet2()
		{
			// >> chart-populating-datapoints-cs
			var chart = new TKChart (CGRect.Inflate (this.View.Bounds, -10, -10));
			this.View.AddSubview (chart);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;

			var categories = new [] { "Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" };
			var values = new [] { 70, 75, 58, 59, 88 };
			var dataPoints = new List<TKChartDataPoint> ();
			for (int i = 0; i < categories.Length; ++i) {
				dataPoints.Add (new TKChartDataPoint (new NSString (categories [i]), new NSNumber (values [i])));
			}

			chart.AddSeries (new TKChartColumnSeries (dataPoints.ToArray ()));
			// << chart-populating-datapoints-cs
		}

		void snippet3()
		{
			// >> chart-binding-props-cs
			var chart = new TKChart (CGRect.Inflate (this.View.Bounds, -10, -10));
			this.View.AddSubview (chart);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;

			Random r = new Random ();
			var dataPoints = new List<CustomObject> ();
			for (int i=0; i<5; i++) {
				CustomObject obj = new CustomObject () {
					ObjectID = i,
					Value1 = r.Next (100),
					Value2 = r.Next (100),
					Value3 = r.Next (100)
				};
				dataPoints.Add (obj);
			}

			chart.BeginUpdates ();
			chart.AddSeries(new TKChartLineSeries(dataPoints.ToArray(), "ObjectID", "Value1"));
			chart.AddSeries(new TKChartAreaSeries(dataPoints.ToArray(), "ObjectID", "Value2"));
			chart.AddSeries(new TKChartScatterSeries(dataPoints.ToArray(), "ObjectID", "Value3"));
			chart.EndUpdates();
			// << chart-binding-props-cs
		}

		class CustomObject: NSObject
		{
			[Export("ObjectID")]
			public int ObjectID { get; set; }

			[Export("Value1")]
			public float Value1 { get; set; }

			[Export("Value2")]
			public float Value2 { get; set; }

			[Export("Value3")]
			public float Value3 { get; set; }
		}
	}
}

