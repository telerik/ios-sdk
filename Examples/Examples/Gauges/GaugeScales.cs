using System;
using TelerikUI;
using Foundation;
using UIKit;
using CoreGraphics;

namespace Examples
{
	[Register("GaugeScales")]
	public class GaugeScales : XamarinExampleViewController
	{
		TKLinearGauge linearGauge = new TKLinearGauge();
		TKRadialGauge radialGauge = new TKRadialGauge();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.CreateLinearGauge ();
			this.CreateRadialGauge ();
		}
			
		void CreateRadialGauge() 
		{
			this.radialGauge = new TKRadialGauge ();
			this.radialGauge.LabelTitle.Text = @"celsius";
			this.radialGauge.LabelSubtitle.Text = @"farenheit";
			this.radialGauge.LabelTitleOffset = new CGPoint(0, 60);
			this.View.AddSubview(this.radialGauge);

			// >> gauge-radial-scale-cs
			TKGaugeRadialScale scale1 = new TKGaugeRadialScale ();
			scale1.Range = new TKRange (new NSNumber(34), new NSNumber(40));
			scale1.Ticks.Position = TKGaugeTicksPosition.Inner;
			this.radialGauge.AddScale(scale1);
			// << gauge-radial-scale-cs

			// >>gauge-segments-cs
			// >> gauge-segment-add-cs
			TKGaugeSegment blueSegment = new TKGaugeSegment ();
			blueSegment.Range = new TKRange (new NSNumber(34), new NSNumber(36));
			blueSegment.Location = 0.70f;
			blueSegment.Width = 0.08f;
			scale1.AddSegment(blueSegment);
			// << gauge-segment-add-cs
			TKGaugeSegment redSegment = new TKGaugeSegment();
			redSegment.Range = new TKRange (new NSNumber(36.05), new NSNumber(40));
			redSegment.Location = 0.70f;
			redSegment.Width = 0.08f;
			redSegment.Fill = new TKSolidFill(UIColor.Red);
			scale1.AddSegment(redSegment);
			// << gauge-segments-cs
			this.SetNeedle(scale1);

			TKGaugeRadialScale scale2 = new TKGaugeRadialScale ();
			scale2.Range = new TKRange (new NSNumber(93.2), new NSNumber(104));
			scale2.Ticks.Position = TKGaugeTicksPosition.Outer;
			scale2.Ticks.MajorTicksCount = 6;
			scale2.Ticks.MinorTicksCount = 20;
			scale2.Labels.Offset = 0.15f;
			scale2.Labels.Position = TKGaugeLabelsPosition.Outer;
			scale2.Labels.LabelFormat = "%.01f";
			scale2.Labels.Count = 6;
			this.radialGauge.AddScale(scale2);

			for(int i = 0; i< this.radialGauge.Scales.Length; i++) {
				TKGaugeRadialScale scale = this.radialGauge.Scales[i] as TKGaugeRadialScale;
				scale.Stroke = new TKStroke(UIColor.Gray, 2);
				scale.Ticks.MajorTicksStroke = new TKStroke(UIColor.Gray, 1);
				scale.Labels.Color = UIColor.Gray;
				scale.Ticks.Offset = 0;
				scale.Radius = i*0.12f + 0.60f;
			}

		}

		void CreateLinearGauge() 
		{
			this.linearGauge = new TKLinearGauge ();
			this.linearGauge.LabelTitle.Text = @"celsius";
			this.linearGauge.LabelSubtitle.Text = @"farenheit";
			this.linearGauge.LabelOrientation = TKLinearGaugeOrientation.Vertical;
			this.linearGauge.LabelTitleOffset = new CGPoint(0, 35);
			this.linearGauge.LabelSubtitleOffset = new CGPoint(0, 100);
			this.View.AddSubview(this.linearGauge);

			// >> gauge-linear-scale-cs
			TKGaugeLinearScale scale1 = new TKGaugeLinearScale ();
			scale1.Range = new TKRange (new NSNumber(34), new NSNumber(40));
			scale1.Ticks.Position = TKGaugeTicksPosition.Inner;
			this.linearGauge.AddScale(scale1);
			// << gauge-linear-scale-cs

			// >> gauge-segment-add-cs
			TKGaugeSegment blueSegment = new TKGaugeSegment ();
			blueSegment.Range = new TKRange (new NSNumber(34), new NSNumber(36));
			blueSegment.Location = 0.62f;
			blueSegment.Width = 0.08f;
			blueSegment.Width2 = 0.08f;
			scale1.AddSegment(blueSegment);
			// << gauge-segment-add-cs

			TKGaugeSegment redSegment = new TKGaugeSegment();
			redSegment.Range = new TKRange (new NSNumber(36.05), new NSNumber(40));
			redSegment.Location = 0.62f;
			redSegment.Width = 0.08f;
			redSegment.Width2 = 0.08f;
			redSegment.Fill = new TKSolidFill(UIColor.Red);
			scale1.AddSegment(redSegment);

			this.SetNeedle(scale1);

			// >> gauge-second-add-cs
			TKGaugeLinearScale scale2 = new TKGaugeLinearScale ();
			scale2.Range = new TKRange (new NSNumber(93.2), new NSNumber(104));
			scale2.Ticks.Position = TKGaugeTicksPosition.Outer;
			scale2.Ticks.MajorTicksCount = 6;
			scale2.Ticks.MinorTicksCount = 20;
			scale2.Labels.Position = TKGaugeLabelsPosition.Outer;
			scale2.Labels.LabelFormat = "%.01f";
			scale2.Labels.Count = 6;
			this.linearGauge.AddScale(scale2);

			for(int i = 0; i< this.linearGauge.Scales.Length; i++) {
				
				TKGaugeLinearScale scale = this.linearGauge.Scales[i] as TKGaugeLinearScale;
				scale.Stroke = new TKStroke(UIColor.Gray, 2);
				scale.Ticks.MajorTicksStroke = new TKStroke(UIColor.Gray, 1);
				scale.Labels.Color = UIColor.Gray;
				scale.Ticks.Offset = 0;
				scale.Offset = i*0.12f + 0.60f;
			}
			// << gauge-second-add-cs
		}

		void SetNeedle(TKGaugeScale scale)
		{
			TKGaugeNeedle needle = new TKGaugeNeedle ();
			needle.Value = 36;
			needle.Length = 0.5f;
			needle.Width = 2;
			needle.TopWidth = 2;
			needle.ShadowOpacity = 0.5f;
			scale.AddIndicator(needle);
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();

			CGRect bounds = this.View.Bounds;
			CGSize size = this.View.Bounds.Size;
			nfloat offset = 20;
			nfloat linearHeight = 150;

			if ((UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeLeft ||  UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeRight)) {
				nfloat width = (bounds.Width - offset* 3)/2;
				nfloat height = bounds.Height - offset*2;
				this.linearGauge.Frame = new CGRect(offset, (size.Height - linearHeight)/2 , width, linearHeight);
				this.radialGauge.Frame = new CGRect(offset + width, offset + (size.Height - height)/2, width + offset, height);
			} else {
				nfloat width = bounds.Width - offset*2;
				nfloat height = (bounds.Height- offset* 3)/2;
				this.linearGauge.Frame = new CGRect(offset,offset * 2, width, linearHeight);
				this.radialGauge.Frame = new CGRect(offset, offset * 3 + linearHeight, width, height + offset);
			}
		}
	}
}

