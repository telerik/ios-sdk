using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("BindWithCustomObject")]
	public class BindWithCustomObject: XamarinExampleViewController
	{	
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			Random r = new Random ();
			List<CustomObject> data = new List<CustomObject> ();
			for (int i = 0; i < 5; i++) {
				CustomObject obj = new CustomObject () {
					ObjectID = i,
					Value1 = r.Next (100),
					Value2 = r.Next (100),
					Value3 = r.Next (100)
				};
				data.Add (obj);
			}
				
			chart.AddSeries (new TKChartAreaSeries (data.ToArray(), "ObjectID", "Value1"));
			chart.AddSeries (new TKChartAreaSeries (data.ToArray(), "ObjectID", "Value2"));
			chart.AddSeries (new TKChartAreaSeries (data.ToArray(), "ObjectID", "Value3"));

			TKChartStackInfo stackInfo = new TKChartStackInfo (new NSNumber (1), TKChartStackMode.Stack);
			for (int i = 0; i < chart.Series.Length; i++) {
				TKChartSeries series = chart.Series [i];
				series.Selection = TKChartSeriesSelection.Series;
				series.StackInfo = stackInfo;
			}

			chart.ReloadData ();
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

