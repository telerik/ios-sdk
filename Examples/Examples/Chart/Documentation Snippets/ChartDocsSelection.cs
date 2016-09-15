using System;
using UIKit;
using TelerikUI;

namespace Examples
{
	public class ChartDocsSelection : UIViewController
	{
			TKChart chart = new TKChart();
			TKChartPieSeries series = null;

			public override void ViewDidLoad ()
			{
				base.ViewDidLoad ();

				series.Selection = TKChartSeriesSelection.DataPoint;
				series.ExpandRadius = 1.2f;
			}

			void Snippet1()
			{
				// >> chart-get-selected-series-cs
				foreach (TKChartSeries series in chart.SelectedSeries) {
					Console.WriteLine ("selected series at index {0}", series.Index);
				}

				foreach (TKChartSelectionInfo info in chart.SelectedPoints) {
					Console.WriteLine ("selected point at index {0} from series {1}", info.DataPointIndex, info.Series.Index);
				}
				// << chart-get-selected-series-cs
			}
			
		// >> chart-progrm-selection-cs
			public override void ViewDidAppear (bool animated)
			{
				base.ViewDidAppear (animated);
				chart.Select (new TKChartSelectionInfo (chart.Series [0], 0));
			}
		// << chart-progrm-selection-cs

		// >> chart-selection-delegate-cs
			class ChartDelegate: TKChartDelegate
			{
				public override void SeriesSelected (TKChart chart, TKChartSeries series)
				{
					// Here you can perform the desired action when the selection is changed.
				}

				public override void PointSelected (TKChart chart, TKChartData point, TKChartSeries series, nint index)
				{
					// Here you can perform the desired action when the selection is changed.
				}

				public override void SeriesDeselected (TKChart chart, TKChartSeries series)
				{
					// Here you can perform the desired action when the selection is changed.
				}

				public override void PointDeselected (TKChart chart, TKChartData point, TKChartSeries series, nint index)
				{
					// Here you can perform the desired action when the selection is changed.
				}
			}
		// << chart-selection-delegate-cs
		}
	}

