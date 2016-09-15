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
	[Register("UIKitDynamicsAnimation")]
	public class UIKitDynamicsAnimation: XamarinExampleViewController
	{
		TKChart chart;
		TKChartVisualPoint selectedPoint;
		CGPoint originalLocation;
		CGPoint originalPosition;
		List<CGPoint> originalValues;
		bool firstTime = true;
		UIDynamicAnimator animator;

		public override void ViewDidLoad ()
		{
			this.AddOption ("Apply Gravity", applyGravity);

			base.ViewDidLoad ();

			chart = new TKChart (this.View.Bounds);
			chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.AllowAnimations = true;
			this.View.AddSubview (chart);

			this.reloadChart (this, EventArgs.Empty);
		}
			
		public void applyGravity()
		{
			if (firstTime) {
				firstTime = false;

				TKChartVisualPoint[] points1 = chart.VisualPointsForSeries (chart.Series [0]);
				originalValues = new List<CGPoint> ();
				foreach (TKChartVisualPoint p in points1) {
					originalValues.Add (p.CGPoint);
				}
				TKChartVisualPoint point1 = points1 [4];
				originalLocation = point1.Center;
			}
			// >> chart-anim-gravity-cs
			animator = new UIDynamicAnimator (chart.PlotView);
			TKChartVisualPoint[] points = chart.VisualPointsForSeries (chart.Series [0]);
			TKChartVisualPoint point = points [4];

			for (int i=0; i<originalValues.Count; i++) {
				TKChartVisualPoint pt = points [i];
				if (pt.Animator != null) {
					pt.Animator.RemoveAllBehaviors();
					pt.Animator = null;
				}
				pt.Center = ((CGPoint)originalValues[i]);
			}

			point.Center = new CGPoint (originalLocation.X, 0);

			UICollisionBehavior collision = new UICollisionBehavior (points);
			collision.TranslatesReferenceBoundsIntoBoundary = true;

			UIGravityBehavior gravity = new UIGravityBehavior (points);
			gravity.GravityDirection = new CGVector (0.0f, 2.0f);

			UIDynamicItemBehavior dynamic = new UIDynamicItemBehavior (points);
			dynamic.Elasticity = 0.5f;

			animator.AddBehavior(dynamic);
			animator.AddBehavior(gravity);
			animator.AddBehavior(collision);
			// << chart-anim-gravity-cs
		}

		public void reloadChart(object sender, EventArgs e)
		{
			Random r = new Random ();
			List<TKChartDataPoint> points = new List<TKChartDataPoint> ();
			for (int i = 0; i < 10; i++) {
				float x = i * 10;
				float y = r.Next () % 100;
				TKChartDataPoint point = new TKChartDataPoint (new NSNumber(x), new NSNumber(y));
				points.Add (point);
			}

			TKChartLineSeries lineSeries = new TKChartLineSeries (points.ToArray());
			float shapeSize = UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Phone ? 14 : 17;
			lineSeries.Selection = TKChartSeriesSelection.DataPoint;
			lineSeries.Style.PointShape = new TKPredefinedShape (TKShapeType.Rhombus, new SizeF (shapeSize, shapeSize));
			chart.AddSeries (lineSeries);
			chart.YAxis.Style.LabelStyle.TextHidden = true;

			chart.ReloadData ();
		}

		public override void TouchesBegan (NSSet touches, UIEvent evt)
		{
			base.TouchesBegan (touches, evt);

			UITouch touch = (UITouch)touches.AnyObject;
			CGPoint touchPoint = touch.LocationInView(chart.PlotView);
			TKChartSelectionInfo hitTestInfo = chart.HitTestForPoint(touchPoint);
			if (hitTestInfo != null) {
				selectedPoint = chart.VisualPointForSeries (hitTestInfo.Series, hitTestInfo.DataPointIndex);
				originalLocation = touchPoint;
				if (selectedPoint != null) {
					selectedPoint.Animator = null;
					originalPosition = selectedPoint.Center;
				}
			}
		}

		public override void TouchesMoved (NSSet touches, UIEvent evt)
		{
			base.TouchesMoved (touches, evt);

			if (selectedPoint == null) {
				return;
			}

			UITouch touch = (UITouch)touches.AnyObject;
			CGPoint touchPoint = touch.LocationInView(chart.PlotView);
			CGPoint delta = new CGPoint(originalLocation.X - touchPoint.X, originalLocation.Y - touchPoint.Y);

			selectedPoint.Center = new CGPoint(originalPosition.X, originalPosition.Y - delta.Y);
		}

		public override void TouchesEnded (NSSet touches, UIEvent evt)
		{
			base.TouchesEnded (touches, evt);

			if (selectedPoint == null) {
				return;
			}

			UISnapBehavior snap = new UISnapBehavior(selectedPoint, originalPosition);
			snap.Damping = 0.2f;

			UIPushBehavior push = new UIPushBehavior(new IUIDynamicItem[] { selectedPoint }, UIPushBehaviorMode.Instantaneous);
			push.PushDirection = new CGVector(0.0f, -1.0f);
			push.Magnitude = 0.001f;

			UIDynamicAnimator animator = new UIDynamicAnimator();
			animator.AddBehavior(snap);
			animator.AddBehavior(push);

			selectedPoint.Animator = animator;
		}
	}
}

