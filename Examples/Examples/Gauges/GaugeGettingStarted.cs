using System;
using TelerikUI;
using Foundation;
using UIKit;
using CoreGraphics;

namespace Examples
{
	[Register("GaugeGettingStarted")]
	public class GaugeGettingStarted : XamarinExampleViewController
	{
		TKLinearGauge linearGauge = new TKLinearGauge();
		TKRadialGauge radialGauge = null;
		GaugeDelegate gaugeDelegate = new GaugeDelegate();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			this.CreateLinearGauge ();
			this.CreateRadialGauge ();
		}

		void CreateRadialGauge()
		{
			// >> gauge-radial-cs
			radialGauge = new TKRadialGauge ();
			this.radialGauge.Delegate = new GaugeDelegate ();
			this.View.AddSubview (this.radialGauge);
			// << gauge-radial-cs

			// >> gauge-radial-scale-cs
			TKGaugeRadialScale scale = new TKGaugeRadialScale (new NSNumber (0), new NSNumber (6));
			this.radialGauge.AddScale (scale);
			// << gauge-radial-scale-cs

			scale.AddIndicator(new TKGaugeNeedle(2.3f, 0.6f));

			UIColor[] colors = new UIColor[] { 
				new UIColor (0.871f, 0.871f, 0.871f, 1.00f),
				new UIColor (0.533f, 0.796f, 0.290f, 1.00f),
				new UIColor (1.000f, 0.773f, 0.247f, 1.00f),
				new UIColor (1.000f, 0.467f, 0.161f, 1.00f),
				new UIColor (0.769f, 0.000f, 0.043f, 1.00f)
			};
				
			nfloat max = ((NSNumber)scale.Range.Maximum).FloatValue;
			nfloat rangeWidth = max / colors.Length;
			nfloat start = 0;
			foreach (UIColor color in colors)
			{
				TKGaugeSegment segment = new TKGaugeSegment (new NSNumber(start), new NSNumber(start + rangeWidth));
				segment.Fill = new TKSolidFill (color);
				scale.AddSegment(segment);
				start += rangeWidth;
			}
		}

		void CreateLinearGauge()
		{
			// >> linear-gauge-start-cs
			this.linearGauge = new TKLinearGauge();
			this.View.AddSubview(this.linearGauge);
			// << linear-gauge-start-cs

			this.linearGauge.WeakDelegate = this.gaugeDelegate;
			this.linearGauge.Orientation = TKLinearGaugeOrientation.Vertical;

			// >> linear-gauge-scale-cs
			TKGaugeLinearScale scale = new TKGaugeLinearScale (new NSNumber(-10), new NSNumber(40));	
			this.linearGauge.AddScale (scale);
			// << linear-gauge-scale-cs

			// >> gauge-segment-cs
			TKGaugeSegment segment = new TKGaugeSegment (new NSNumber(-10), new NSNumber(18));
			segment.Location = 0.56f;
			segment.Width = 0.05f;
			segment.Width2 = 0.05f;
			segment.Cap = TKGaugeSegmentCap.Round;
			// << gauge-segment-cs

			scale.AddSegment (segment);

			UIColor[] colors = new UIColor[] { 
				new UIColor (0.149f, 0.580f, 0.776f, 1.00f),
				new UIColor (0.537f, 0.796f, 0.290f, 1.00f),
				new UIColor (1.000f, 0.773f, 0.247f, 1.00f),
				new UIColor (1.000f, 0.463f, 0.157f, 1.00f),
				new UIColor (0.769f, 0.000f, 0.047f, 1.00f)
			};
			this.AddSegments(scale, colors, 0.5f, 0.05f);
		}

		class GaugeDelegate: TKGaugeDelegate
		{
			public override string Text (TKGauge gauge, NSObject label)
			{
				if (gauge.IsKindOfClass(new ObjCRuntime.Class(typeof(TKRadialGauge)))){
					return string.Format("{0} bar", ((NSNumber)label).NIntValue);
				} 
				else {
					return string.Format("{0} degrees", ((NSNumber)label).NIntValue);
				} 
			}
		}

		void AddSegments(TKGaugeScale scale, UIColor[] colors, nfloat location, nfloat width)
		{
			nfloat max = ((NSNumber)scale.Range.Maximum).FloatValue; 
		    nfloat min = ((NSNumber)scale.Range.Minimum).FloatValue;
			nfloat rangeWidth = (max - min) / colors.Length;
			nfloat start = min;
			foreach (UIColor color in colors)
			{
				TKGaugeSegment segment = new TKGaugeSegment (new NSNumber(start), new NSNumber(start + rangeWidth));
				segment.Fill = new TKSolidFill (color);
				segment.Location = location;
				segment.Width = width;
				segment.Width2 = width;
				scale.AddSegment(segment);
				start += rangeWidth;
			}
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();

			CGRect bounds = this.View.Bounds;
			CGSize size = this.View.Bounds.Size;
			nfloat offset = 20;
			nfloat linearWidth = 150;

			if (UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeLeft ||  UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeRight) {
				nfloat width = (size.Width - offset*3.0f)/2.0f;
				radialGauge.Frame =  new CGRect(offset*2, bounds.Y + offset, width, bounds.Size.Height - offset*2);
				nfloat x = this.radialGauge.Frame.GetMaxX ();
				linearGauge.Frame = new CGRect(x + offset + (bounds.Size.Width - x - linearWidth)/2.0f,
						bounds.Y + offset, linearWidth, bounds.Size.Height - offset*2);
			}
			else {
				nfloat height = (this.View.Bounds.Size.Height - offset*3)/2.0f;
				radialGauge.Frame = new CGRect(offset, bounds.Y + offset, size.Width - offset*2, height);
				linearGauge.Frame = new CGRect((bounds.Size.Width - linearWidth - offset*2)/2.0f + offset,
				size.Height - height - offset, linearWidth, height);
			}
		}
	}		
}


