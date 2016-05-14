using System;
using TelerikUI;
using Foundation;
using UIKit;
using CoreGraphics;

namespace Examples
{
	[Register("GaugeInteraction")]
	public class GaugeInteraction : XamarinExampleViewController
	{
		TKLinearGauge linearGauge = new TKLinearGauge();
		TKRadialGauge radialGauge = new TKRadialGauge();
		GaugeDelegate gaugeDelegate;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			gaugeDelegate = new GaugeDelegate (this);

			this.CreateLinearGauge ();
			this.CreateRadialGauge ();
		}

		void CreateRadialGauge()
		{
			this.radialGauge = new TKRadialGauge ();
			this.radialGauge.Delegate = this.gaugeDelegate;
			this.radialGauge.LabelTitle.Font = UIFont.SystemFontOfSize (30);
			this.radialGauge.LabelTitle.Text = "28˚C";
			this.radialGauge.LabelSubtitle.Text = "temperature";
			this.radialGauge.LabelSubtitle.Font = UIFont.SystemFontOfSize (12);
			this.View.AddSubview(this.radialGauge);

			TKGaugeRadialScale scale = new TKGaugeRadialScale ();
			scale.Range = new TKRange (new NSNumber (10), new NSNumber (40));
			scale.Ticks.Hidden = true;
			scale.Radius = 0.8f;
			scale.Stroke = new TKStroke(UIColor.FromWhiteAlpha(0.7f, 1.0f), 3);
			scale.Labels.Position = TKGaugeLabelsPosition.Outer;
			scale.Labels.Offset = 0.1f;
			this.radialGauge.AddScale (scale);

			TKGaugeSegment segment = new TKGaugeSegment (new NSNumber (10), new NSNumber (28));
			segment.AllowTouch = true;
			segment.Location = 0.84f;
			segment.ShadowOffset = new CGSize(5, 5);
			segment.ShadowOpacity = 0.8f;
			segment.ShadowRadius = 5;
			segment.Width = 0.08f;
			scale.AddSegment(segment);
		}

		void CreateLinearGauge()
		{
			this.linearGauge = new TKLinearGauge ();
			this.linearGauge.LabelTitle.Font = UIFont.SystemFontOfSize (16);
			this.linearGauge.LabelTitle.Text = "85 %";
			this.linearGauge.LabelSubtitle.Font = UIFont.SystemFontOfSize (12);
			this.linearGauge.LabelSubtitle.Text = "humidity";
			this.linearGauge.LabelTitleOffset = new CGPoint(0, -25);
			this.linearGauge.LabelSubtitleOffset = new CGPoint(0, -25);
			this.linearGauge.Delegate = this.gaugeDelegate;
			this.View.AddSubview(this.linearGauge);

			TKGaugeLinearScale scale = new TKGaugeLinearScale ();
			scale.Range = new TKRange(new NSNumber (0), new NSNumber (100));
			scale.Ticks.Hidden = true;
			scale.Stroke = new TKStroke(UIColor.FromWhiteAlpha(0.7f, 1.0f), 3);
			scale.Labels.Position = TKGaugeLabelsPosition.Outer;
			scale.Labels.Offset = 0.2f;
			scale.Offset = 0.2f;
			linearGauge.AddScale(scale);

			TKGaugeSegment segment = new TKGaugeSegment (new NSNumber (0), new NSNumber (85));
			segment.AllowTouch = true;
			segment.Location = 0.13f;
			segment.ShadowOffset = new CGSize(5, 5);
			segment.ShadowOpacity = 0.8f;
			segment.ShadowRadius = 5;
			segment.Width = 0.1f;
			segment.Width2 = 0.1f;
			scale.AddSegment(segment);
		}

		public class GaugeDelegate: TKGaugeDelegate
		{
			GaugeInteraction owner;

			public GaugeDelegate(GaugeInteraction owner)
			{
				this.owner = owner;
			}

			public override void ValueChanged (TKGauge gauge, nfloat value, TKGaugeScale scale)
			{
				if (gauge == owner.radialGauge) {
					owner.radialGauge.LabelTitle.Text = string.Format("{0}˚C", (int)value);
				}
				else {
					owner.linearGauge.LabelTitle.Text = string.Format("{0} %", (int)value);
				}
			}
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();

			CGRect bounds = this.View.Bounds;
			CGSize size = this.View.Bounds.Size;
			nfloat offset = 20;
			nfloat linearHeight = 100;

			if (UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeLeft ||  UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeRight) {
				nfloat width = (size.Width - offset*2)/2;
			
				this.linearGauge.Frame = new CGRect (offset + offset/2 + width, (size.Height - offset*3 - bounds.Y)/2, width, linearHeight);
				this.radialGauge.Frame = new CGRect (offset, bounds.Y + 20, width, size.Height - bounds.Y - offset*3);
			}
			else {
				this.linearGauge.Frame = new CGRect (offset, size.Height - linearHeight - offset*2, size.Width - offset*2, linearHeight);
				this.radialGauge.Frame = new CGRect (offset, bounds.Y + 20, size.Width - offset*2, linearGauge.Frame.Y - bounds.Y - offset*2);
			}
		}
	}


}

