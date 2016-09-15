using System;
using System.Collections.Generic;

using Foundation;
using UIKit;
using CoreAnimation;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("CustomAnimationPieChart")]
	public class CustomAnimationPieChart: XamarinExampleViewController
	{
		TKChart chart;
		ChartDelegate chartDelegate =  new ChartDelegate ();

		public override void ViewDidLoad ()
		{
			this.AddOption ("Animate", animate);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.Delegate = chartDelegate;
			chart.AllowAnimations = true;
			this.View.AddSubview (chart);

			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			list.Add (new TKChartDataPoint(new NSNumber(10), null, "Apple"));
			list.Add (new TKChartDataPoint(new NSNumber(20), null, "Google"));
			list.Add (new TKChartDataPoint(new NSNumber(30), null, "Microsoft"));
			list.Add (new TKChartDataPoint(new NSNumber(5), null, "IBM"));
			list.Add (new TKChartDataPoint(new NSNumber(8), null, "Oracle"));

			TKChartPieSeries series = new TKChartPieSeries (list.ToArray());
			series.Selection = TKChartSeriesSelection.DataPoint;
			chart.AddSeries (series);
		}
			
		public void animate()
		{
			chart.Animate ();
		}

		class ChartDelegate: TKChartDelegate
		{
			// >> chart-anim-pie-cs
			public override CAAnimation AnimationForSeries (TKChart chart, TKChartSeries series, TKChartSeriesRenderState state, CGRect rect)
			{
				double duration = 0;
				List<CAAnimation> animations = new List<CAAnimation>();
				for (int i = 0; i<(int)state.Points.Count; i++) {
					string pointKeyPath = state.AnimationKeyPathForPointAtIndex ((uint)i);
	
					string keyPath = string.Format("{0}.distanceFromCenter", pointKeyPath);
					CAKeyFrameAnimation a = CAKeyFrameAnimation.GetFromKeyPath(keyPath);
					a.Values = new NSNumber[] { new NSNumber(50), new NSNumber(50), new NSNumber(0) };
					a.KeyTimes = new NSNumber[] { new NSNumber(0), new NSNumber(i/(i+1.0)), new NSNumber(1) };
					a.Duration = 0.3 * (i+1.1);
					animations.Add(a);
	
					keyPath = string.Format("{0}.opacity", pointKeyPath);
					a = CAKeyFrameAnimation.GetFromKeyPath(keyPath);
					a.Values = new NSNumber[] { new NSNumber(0), new NSNumber(0), new NSNumber(1) };
					a.KeyTimes = new NSNumber[] { new NSNumber(0), new NSNumber(i/(i+1.0)), new NSNumber(1) };
					a.Duration = 0.3 * (i+1.1);
					animations.Add(a);
	
					duration = a.Duration;
				}
				CAAnimationGroup g = new CAAnimationGroup();
				g.Duration = duration;
				g.Animations = animations.ToArray();
				return g;
			}
			// << chart-anim-pie-cs
		}
	}
}

