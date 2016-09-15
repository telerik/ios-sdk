using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

using TelerikUI;

namespace Examples
{
	[Register("DateTimeAxis")]
	public class DateTimeAxis: XamarinExampleViewController
	{
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			TKChart chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.View.AddSubview (chart);

			NSCalendar calendar = new NSCalendar (NSCalendarType.Gregorian);
			NSDateComponents dateTimeComponents = new NSDateComponents ();
			dateTimeComponents.Year = 2013;
			dateTimeComponents.Day = 1;

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 1; i <= 6; i++) {
				dateTimeComponents.Month = i;
				list.Add(new TKChartDataPoint(calendar.DateFromComponents(dateTimeComponents), new NSNumber(r.Next() % 100)));
			}

			TKChartSplineAreaSeries series = new TKChartSplineAreaSeries (list.ToArray());
			series.Selection = TKChartSeriesSelection.Series;

			dateTimeComponents.Month = 1;
			NSDate minDate = new NSDate ();
			NSDate maxDate = new NSDate ();
			minDate = calendar.DateFromComponents (dateTimeComponents);
			dateTimeComponents.Month = 6;
			maxDate = calendar.DateFromComponents (dateTimeComponents);

			// >> chart-axis-datetime-cs
			TKChartDateTimeAxis xAxis = new TKChartDateTimeAxis (minDate, maxDate);
			xAxis.MajorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Months;
			xAxis.MajorTickInterval = 1;
			// << chart-axis-datetime-cs

			// >> chart-category-plot-onticks-cs
			xAxis.PlotMode = TKChartAxisPlotMode.OnTicks;
			// << chart-category-plot-onticks-cs

			chart.XAxis = xAxis;

			chart.AddSeries (series);
		}
	}
}

