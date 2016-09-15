using System;
using TelerikUI;
using Foundation;
using UIKit;
using CoreGraphics;
using CoreAnimation;

namespace Examples
{
	[Register("GaugeCustomization")]
	public class GaugeCustomization: XamarinExampleViewController
	{
		TKLinearGauge linearGauge = new TKLinearGauge();
		TKRadialGauge radialGauge = new TKRadialGauge();
		UIColor[] colors = new UIColor[6];
		Random r = new Random();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			// >> gauge-customize-cs
			this.colors = new UIColor[] { 
				new UIColor (0.00f, 0.70f, 0.90f ,1.00f),
				new UIColor (0.38f, 0.73f, 0.00f, 1.00f),
				new UIColor (0.96f, 0.56f, 0.00f, 1.00f),
				new UIColor (0.00f, 1.00f, 1.00f, 1.00f),
				new UIColor (0.77f, 1.00f, 0.00f, 1.00f),
				new UIColor (1.00f, 0.85f, 0.00f, 1.00f)
			};
			// << gauge-customize-cs
			string[] legendStrings = new string[] { "MOVE", "EXCERCISE", "STAND" };

			for (int i = 0; i < 3; i++) {
				TKView view = new TKView (new CGRect (20, 40 + i * 25, 22, 22));
				view.Fill = new TKLinearGradientFill(new UIColor[] {this.colors[i], this.colors[i+3]}, new CGPoint(0.0f, 0.0f), new CGPoint(1.0f, 1.0f));
				view.Shape = new TKPredefinedShape (TKShapeType.Circle, new CGSize (0, 0));
				this.View.AddSubview (view);

				UILabel label = new UILabel( new CGRect(50, 40 + i * 25, this.View.Frame.GetMaxX() - 60, 20));
				label.Text = legendStrings[i];
				label.Font.WithSize (15);
				label.TextColor = new UIColor(0.2f, 0.2f, 0.2f, 1f);
				this.View.AddSubview(label);

			}

			this.CreateLinearGauge ();
			this.CreateRadialGauge ();
		}

		void CreateRadialGauge()
		{
			this.radialGauge = new TKRadialGauge ();
			this.View.AddSubview (this.radialGauge);

			TKGaugeRadialScale scale = new TKGaugeRadialScale ();
			this.radialGauge.AddScale (scale);
			scale.StartAngle = 0;
			scale.EndAngle = (nfloat)Math.PI*2.0f;
			scale.Stroke = new TKStroke (UIColor.Clear);
			scale.Ticks.Hidden = true;
			scale.Labels.Hidden = true;
			// >> gauge-customize-cs
			for (int i=0; i < 3; i++) {
				TKGaugeSegment segment = new TKGaugeSegment (new NSNumber (0), new NSNumber (100));
				segment.Fill = new TKSolidFill(this.colors[i].ColorWithAlpha(0.4f));
				segment.Width = 0.2f;
				segment.Location = 0.5f + i * 0.25f;
				segment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment(segment);

				TKGaugeSegment gradientSegment = new TKGaugeSegment ();
				UIColor[] colors = new UIColor[] { this.colors[i], this.colors [i + 3] };
				gradientSegment.Fill = new TKLinearGradientFill (colors, new CGPoint(0.0f, 0.0f), new CGPoint(1.0f, 1.0f));
				gradientSegment.Width = 0.2f;
				gradientSegment.Location = 0.5f + i * 0.25f;
				gradientSegment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment (gradientSegment);
				gradientSegment.SetRange(new TKRange(new NSNumber(0), new NSNumber(20+ this.r.Next(50)) ), 0.5f, CAMediaTimingFunction.EaseInEaseOut);
			}
			// << gauge-customize-cs
		}

		void CreateLinearGauge()
		{
			this.linearGauge = new TKLinearGauge();
			this.View.AddSubview(this.linearGauge);

			TKGaugeLinearScale scale = new TKGaugeLinearScale();
			scale.Stroke = new TKStroke (UIColor.Clear);
			scale.Ticks.Hidden = true;
			scale.Labels.Hidden = true;
			this.linearGauge.AddScale (scale);

			for (int i=0; i < 3; i++) {
				TKGaugeSegment segment = new TKGaugeSegment (new NSNumber (0), new NSNumber (100));
				segment.Fill = new TKSolidFill(this.colors[i].ColorWithAlpha(0.4f));
				segment.Width = 0.2f;
				segment.Width2 = 0.2f;
				segment.Location = i*0.3f;
				segment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment(segment);

				TKGaugeSegment gradientSegment = new TKGaugeSegment ();
				UIColor[] colors = new UIColor[] { this.colors[i], this.colors [i + 3] };
				gradientSegment.Fill = new TKLinearGradientFill (colors, new CGPoint(0.0f, 0.0f), new CGPoint(1.0f, 1.0f));
				gradientSegment.Width = 0.2f;
				gradientSegment.Width2 = 0.2f;
				gradientSegment.Location = i*0.3f;
				gradientSegment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment (gradientSegment);

				gradientSegment.SetRange(new TKRange(new NSNumber(0), new NSNumber(20+ this.r.Next(50)) ), 0.5f, CAMediaTimingFunction.EaseInEaseOut);
			}
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();

			CGRect bounds = this.View.Bounds;
			CGSize size = this.View.Bounds.Size;
			nfloat offset = 20;
			nfloat linearHeight = 130;

			if (UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeLeft ||  UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeRight) {
				nfloat width = (bounds.Size.Width - offset * 3.0f) / 2.0f;
				nfloat height = bounds.Size.Height - offset*2.0f;
				this.linearGauge.Frame = new CGRect (offset, size.Height/2.0f, width, linearHeight);
				this.radialGauge.Frame = new CGRect (2.0f * offset + width, offset * 2.0f, width, height);
			}
			else {
				nfloat width = bounds.Size.Width - offset*2.0f;
				nfloat height = (bounds.Size.Height - offset * 3.0f) / 2.0f;
				this.linearGauge.Frame = new CGRect (offset, size.Height/4.0f, width, linearHeight);
				this.radialGauge.Frame = new CGRect (offset, size.Height/4.0f + linearHeight, width, height);
			}
		}
	}
}

