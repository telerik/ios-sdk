using System;
using UIKit;
using TelerikUI;
using System.Collections.Generic;
using Foundation;
using CoreAnimation;
using CoreGraphics;

namespace Examples
{
	public class ChartDocsStructure : UIViewController
	{
		public ChartDocsStructure ()
		{
		}

		TKChart chart = new TKChart();

		void snippet1 ()
		{
			// >> chart-structure-axes-cs
			var xAxis = new TKChartNumericAxis ();
			xAxis.Position = TKChartAxisPosition.Bottom;
			chart.AddAxis (xAxis);

			var yAxis1 = new TKChartNumericAxis (new NSNumber (0), new NSNumber (100));
			yAxis1.MajorTickInterval = 50;
			yAxis1.Position = TKChartAxisPosition.Left;
			yAxis1.Style.LineHidden = false;
			chart.AddAxis (yAxis1);

			var yAxis2 = new TKChartNumericAxis (new NSNumber (0), new NSNumber (200));
			yAxis2.MajorTickInterval = 50;
			yAxis2.Position = TKChartAxisPosition.Right;
			yAxis2.Style.LineHidden = false;
			chart.AddAxis (yAxis2);

			var incomesData = new List<TKChartDataPoint> ();
			var values1 = new [] { 12, 10, 98, 64, 11, 27, 85, 72, 43, 39 };
			for (int i=0; i<10; i++) {
				incomesData.Add (new TKChartDataPoint (new NSNumber(i), new NSNumber(values1 [i])));
			}

			var series = new TKChartLineSeries (incomesData.ToArray());
			series.XAxis = xAxis;
			series.YAxis = yAxis1;
			chart.AddSeries (series);
			// << chart-structure-axes-cs
		}

		void snippet2()
		{
			// >> chart-structure-series-cs
			var values1 = new [] { 12, 10, 98, 64, 11, 27, 85, 72, 43, 39 };
			var values2 = new [] { 87, 22, 29, 87, 65, 99, 63, 12, 82, 87 };
			var expensesData = new List<TKChartDataPoint>();
			var incomesData = new List<TKChartDataPoint>();
			for (int i=0; i<10; i++) {
				expensesData.Add(new TKChartDataPoint(new NSNumber(i), new NSNumber(values2[i])));
				incomesData.Add(new TKChartDataPoint(new NSNumber(i), new NSNumber(values1[i])));
			}

			var stackInfo = new TKChartStackInfo(new NSNumber(1), TKChartStackMode.Stack);

			var series1 = new TKChartColumnSeries(expensesData.ToArray());
			series1.Title = "Expenses";
			series1.StackInfo = stackInfo;
			chart.AddSeries(series1);

			var series2 = new TKChartColumnSeries(incomesData.ToArray());
			series2.Title = "Incomes";
			series2.StackInfo = stackInfo;
			chart.AddSeries(series2);
			// << chart-structure-series-cs
		}

		class ChartDelegate: TKChartDelegate
		{
			Random r = new Random ();

			// >> chart-structure-animation-cs
			public override CAAnimation AnimationForSeries (TKChart chart, TKChartSeries series, TKChartSeriesRenderState state, CGRect rect)
			{
				var duration = 0.0;
				var animations = new List<CAAnimation> ();
				for (int i=0; i<(int)state.Points.Count; i++) {
					var pointKeyPath = state.AnimationKeyPathForPointAtIndex ((uint)i);
					var keyPath = pointKeyPath + ".x";
					var point = state.Points.ObjectAtIndex((uint)i) as TKChartVisualPoint;
					var animation = new CABasicAnimation ();
					animation.KeyPath = keyPath;
					animation.Duration = (double) (r.Next (100)) / 100.0;
					animation.From = new NSNumber(0);
					animation.To = new NSNumber(point.X);
					animations.Add (animation);
					duration = Math.Max(animation.Duration, duration);
				}

				var group = new CAAnimationGroup ();
				group.Duration = duration;
				group.Animations = animations.ToArray();
				return group;
			}
			// << chart-structure-animation-cs
		}
	}
}

