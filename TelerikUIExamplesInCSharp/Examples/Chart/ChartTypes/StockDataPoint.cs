using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	public class StockDataPoint: TKChartFinancialDataPoint
	{
		public static List<StockDataPoint> LoadStockPoints(int maxItems)
		{
			List<StockDataPoint> stockPoints = new List<StockDataPoint> ();

			string filePath = NSBundle.MainBundle.PathForResource ("AppleStockPrices", "json");
			NSData json = NSData.FromFile (filePath);
			NSError error = new NSError ();
			NSArray data = (NSArray)NSJsonSerialization.Deserialize (json, NSJsonReadingOptions.AllowFragments, out error);
			NSDateFormatter formatter = new NSDateFormatter ();
			formatter.DateFormat = "dd-MM-yyyy";

			for (int i = 0; i < (int)data.Count; i++) {
				if (i == maxItems) {
					break;
				}
				NSDictionary jsonPoint = data.GetItem<NSDictionary> ((nuint)i);
				StockDataPoint dataPoint = new StockDataPoint ();
				dataPoint.DataXValue = formatter.Parse ( (NSString)jsonPoint ["date"]);
				dataPoint.Open = (NSNumber)jsonPoint ["open"];
				dataPoint.High = (NSNumber)jsonPoint ["high"];
				dataPoint.Low = (NSNumber)jsonPoint ["low"];
				dataPoint.Close = (NSNumber)jsonPoint ["close"];
				dataPoint.Volume = (NSNumber)jsonPoint ["volume"];
				stockPoints.Add (dataPoint);
			}

			return stockPoints;
		}
	}
}

