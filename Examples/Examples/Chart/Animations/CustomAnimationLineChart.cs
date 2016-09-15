using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;
using CoreAnimation;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	[Register("CustomAnimationLineChart")]
	public class CustomAnimationLineChart: XamarinExampleViewController
	{
		TKChart chart;
		ChartDelegate chartDelegate = new ChartDelegate();

		public override void ViewDidLoad ()
		{
			this.AddOption ("Sequential animation", applySequential);
			this.AddOption ("Grow animation", applyGrow);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.AllowAnimations = true;
			chart.Delegate = chartDelegate;
			this.View.AddSubview (chart);

			Random r = new Random ();
			List<TKChartDataPoint> list = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				list.Add (new TKChartDataPoint(new NSNumber(i), new NSNumber(r.Next() % 100)));
			}
			
			TKChartLineSeries lineSeries = new TKChartLineSeries (list.ToArray ());
			chart.AddSeries (lineSeries);

			float shapeSize = UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Phone ? 14 : 17;
			lineSeries.Style.PointShape = new TKPredefinedShape (TKShapeType.Circle, new SizeF (shapeSize, shapeSize));
			lineSeries.Style.ShapeMode = TKChartSeriesStyleShapeMode.AlwaysShow;
			lineSeries.Selection = TKChartSeriesSelection.DataPoint;
			chart.AddSeries (lineSeries);
		}
			
		public void applySequential()
		{
			chartDelegate.Grow = false;
			chart.Animate ();
		}

		public void applyGrow()
		{
			chartDelegate.Grow = true;
			chart.Animate ();
		}

		class ChartDelegate: TKChartDelegate
		{
			public bool Grow { get; set; }
			// >> chart-anim-line-cs
			public override CAAnimation AnimationForSeries (TKChart chart, TKChartSeries series, TKChartSeriesRenderState state, CGRect rect)
			{
				double duration = 0;
				List<CAAnimation> animations = new List<CAAnimation> ();
			
				for (int i = 0; i<(int)state.Points.Count; i++) 
				{			
					TKChartVisualPoint point = (TKChartVisualPoint)state.Points.ObjectAtIndex ((uint)i);

					if (Grow) 
					{
						string keyPath = string.Format ("seriesRenderStates.{0}.points.{1}.x", series.Index, i);

						CABasicAnimation animation = (CABasicAnimation)CABasicAnimation.FromKeyPath(keyPath);
						animation.Duration = 0.1 *(i + 0.2);
						animation.From = new NSNumber(0);
						animation.To = new NSNumber(point.X);
						animation.TimingFunction = CAMediaTimingFunction.FromName (CAMediaTimingFunction.EaseOut);
						animations.Add(animation);
			
						duration = animation.Duration;
					}
					else 
					{
						string keyPath = string.Format ("seriesRenderStates.{0}.points.{1}.y", series.Index, i);
						nfloat oldY = rect.Height;
	
						if (i > 0) 
						{
							CAKeyFrameAnimation animation = (CAKeyFrameAnimation)CAKeyFrameAnimation.GetFromKeyPath(keyPath);
							animation.Duration = 0.1* (i + 1);
							animation.Values = new NSNumber[] { new NSNumber(oldY), new NSNumber(oldY), new NSNumber(point.Y) };
							animation.KeyTimes = new NSNumber[] { new NSNumber(0), new NSNumber(i/(i+1.0)), new NSNumber(1) };
							animation.TimingFunction = CAMediaTimingFunction.FromName(CAMediaTimingFunction.EaseOut);
							animations.Add (animation);
	
							duration = animation.Duration;
						}
						else 
						{
							CABasicAnimation animation = (CABasicAnimation)CABasicAnimation.FromKeyPath(keyPath);
							animation.From = new NSNumber(oldY);
							animation.To = new NSNumber(point.Y);
							animation.Duration = 0.1f;
							animations.Add(animation);
						}
					}
				}
			
				CAAnimationGroup group = new CAAnimationGroup ();
				group.Duration = duration;
				group.Animations = animations.ToArray();
			
				return group;
			}
			// << chart-anim-line-cs
		}
	}
}

