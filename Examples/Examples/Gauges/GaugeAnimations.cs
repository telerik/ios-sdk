using System;
using TelerikUI;
using Foundation;
using UIKit;
using CoreGraphics;
using ObjCRuntime;
using CoreAnimation;

namespace Examples
{
	[Register("GaugeAnimations")]
	public class GaugeAnimations : XamarinExampleViewController
	{
		TKLinearGauge linearGauge = new TKLinearGauge();
		TKRadialGauge radialGauge = new TKRadialGauge();
		UISegmentedControl segmentedControl = new UISegmentedControl();
		string[] segments;
		UILabel label = new UILabel();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.CreateLinearGauge ();
			this.CreateRadialGauge ();

			this.segments = new string[] {"60", "80", "120", "160"};
			this.segmentedControl = new UISegmentedControl (this.segments);
			this.segmentedControl.SelectedSegment = 0;
			this.View.AddSubview(this.segmentedControl);
			this.segmentedControl.AddTarget (this,new  Selector("SegmentTouched:"), UIControlEvent.ValueChanged);
	
			this.label.Text = "km/h";
			this.label.Font = UIFont.SystemFontOfSize(12);
			this.View.AddSubview(this.label);
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);

			TKGaugeNeedle needle = this.radialGauge.ScaleAtIndex (0).IndicatorAtIndex (0) as TKGaugeNeedle;
			needle.SetValue (60, 0.5f, CAMediaTimingFunction.EaseInEaseOut);
			needle = this.linearGauge.ScaleAtIndex (0).IndicatorAtIndex (0) as TKGaugeNeedle;
			needle.SetValue (1.8f, 0.7f, CAMediaTimingFunction.EaseInEaseOut);
		}

		void CreateLinearGauge() {
			this.linearGauge = new TKLinearGauge (); //100 height
			this.linearGauge.LabelSubtitle.Text = "rpm x 1000";
			this.View.AddSubview(this.linearGauge);

			TKGaugeLinearScale scale = new TKGaugeLinearScale ();
			scale.Range = new TKRange (new NSNumber (0), new NSNumber (8));
			scale.Offset = 0.55f;
			scale.Ticks.MinorTicksCount = 1;
			scale.Ticks.MajorTicksCount = 14;
			scale.Ticks.MajorTicksLength = 4;
			scale.Ticks.MajorTicksStroke = new TKStroke(new UIColor(0.522f, 0.522f, 0.522f, 1.00f), 2);
			this.linearGauge.AddScale(scale);

			TKGaugeSegment segment = new TKGaugeSegment (new NSNumber (0), new NSNumber (5));
			segment.Fill = new TKSolidFill(new UIColor(0.522f, 0.522f, 0.522f, 1.00f));
			segment.Location = 0.6f;
			segment.Width = 0.01f;
			segment.Width2 = 0.01f;
			scale.AddSegment(segment);

			segment = new TKGaugeSegment (new NSNumber (5.1), new NSNumber (8));
			segment.Fill = new TKSolidFill(new UIColor(0.886f, 0.329f, 0.353f, 1.00f));
			segment.Location = 0.6f;
			segment.Width = 0.01f;
			segment.Width2 = 0.01f;
			scale.AddSegment(segment);

			// >> gauge-needle-cs
			TKGaugeNeedle needle = new TKGaugeNeedle();
			needle.Width = 3;
			needle.TopWidth = 3;
			needle.Length = 0.6f;
			needle.ShadowOffset = new CGSize(1, 1);
			needle.ShadowOpacity = 0.8f;
			needle.ShadowRadius = 1.5f;
			scale.AddIndicator(needle);
			// << gauge-needle-cs

		}

		void CreateRadialGauge() {
			
			this.radialGauge = new TKRadialGauge ();
			this.radialGauge.LabelSubtitle.Text = "km/h";
			this.radialGauge.LabelTitleOffset = new CGPoint(0, 20);
			this.View.AddSubview(this.radialGauge);

			TKGaugeRadialScale scale = new TKGaugeRadialScale ();
			scale.Range = new TKRange (new NSNumber(0), new NSNumber(180));
			scale.Labels.Count = 9;
			scale.Ticks.MajorTicksCount = 18;
			scale.Ticks.MinorTicksCount = 1;
			scale.Ticks.MajorTicksLength = 4;
			scale.Ticks.Offset = 0.1f;
			scale.Ticks.MajorTicksStroke =  new TKStroke( new UIColor(0.522f, 0.522f, 0.522f, 1.00f), 2);
			this.radialGauge.AddScale(scale);

			TKRange[] ranges = new TKRange[] { new TKRange(new NSNumber(0), new NSNumber(60)),
				                               new TKRange(new NSNumber(61), new NSNumber(120)),
												new TKRange(new NSNumber(121), new NSNumber(180))};
			
			UIColor[] colors = new UIColor[] {new UIColor(0.522f, 0.522f, 0.522f, 1.00f),
				new UIColor(0.200f, 0.200f, 0.200f, 1.00f),
				new UIColor(0.886f, 0.329f, 0.353f, 1.00f)};
			nint i = 0;
			foreach (TKRange range in ranges) {
				TKGaugeSegment segment = new TKGaugeSegment(range);
				segment.Width = 0.02f;
				segment.Fill = new TKSolidFill(colors[i]);
				scale.AddSegment(segment);
				i++;
			}

			TKGaugeNeedle needle = new TKGaugeNeedle();
			needle.Length = 0.8f;
			needle.Width = 3;
			needle.TopWidth = 3;
			needle.ShadowOffset = new CGSize(1, 1);
			needle.ShadowOpacity = 0.8f;
			needle.ShadowRadius = 1.5f;
			scale.AddIndicator(needle);

		}

		[Export ("SegmentTouched:")]
		public void SegmentTouched(UISegmentedControl source) {
			nfloat value = nfloat.Parse(this.segments[source.SelectedSegment]);

			TKGaugeNeedle needle = this.radialGauge.ScaleAtIndex(0).IndicatorAtIndex(0) as TKGaugeNeedle;
			needle.SetValue(value, 
				0.5f,
				CAMediaTimingFunction.EaseInEaseOut);

			needle = this.linearGauge.ScaleAtIndex(0).IndicatorAtIndex(0) as TKGaugeNeedle;
			needle.SetValue ((value / 180) * 7.0f, 0.5f, CAMediaTimingFunction.EaseInEaseOut);
			
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
				this.segmentedControl.Frame = new CGRect((size.Width - 200)/2,
					size.Height - this.segmentedControl.Frame.Size.Height - offset,
					200, this.segmentedControl.Frame.Size.Height);
				this.linearGauge.Frame = new CGRect(offset + offset/2 + width, (this.segmentedControl.Frame.Y - offset*2 - bounds.Y)/2, width, linearHeight);
				this.radialGauge.Frame = new CGRect(offset, bounds.Y + 20, width, this.segmentedControl.Frame.Y - bounds.Y - offset*2);
				this.label.Frame = new CGRect(this.segmentedControl.Frame.GetMaxX() + 5, this.segmentedControl.Frame.GetMinY() - 7, 100, 44);
			}
			else {
				this.segmentedControl.Frame = new CGRect((size.Width - 200)/2,
					size.Height - this.segmentedControl.Frame.Size.Height - offset,
					200, this.segmentedControl.Frame.Size.Height);
				this.linearGauge.Frame = new CGRect(offset, this.segmentedControl.Frame.Y - linearHeight - offset*2, size.Width - offset*2, linearHeight);
				this.radialGauge.Frame = new CGRect(offset, bounds.Y + 20, size.Width - offset*2, this.linearGauge.Frame.Y - bounds.Y - offset*2);
				this.label.Frame = new CGRect(this.segmentedControl.Frame.GetMaxX() + 5, this.segmentedControl.Frame.GetMinY()	- 7, 100, 44);
			}
		}
	}
}

