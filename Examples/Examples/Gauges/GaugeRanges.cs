using System;
using TelerikUI;
using Foundation;
using UIKit;
using CoreGraphics;

namespace Examples
{
	[Register("GaugeRanges")]
	public class GaugeRanges : XamarinExampleViewController
	{
		TKLinearGauge linearGauge = new TKLinearGauge();
		TKRadialGauge radialGauge = new TKRadialGauge();
		UIColor[] redColors;
		UIColor[] greenColors;
		UIColor[] blueColors;
		NSNumber[] redValues;
		NSNumber[] greenValues;
		NSNumber[] blueValues;
		Random r = new Random();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.redColors =  new UIColor[] { new UIColor(0.96f, 0.80f, 0.80f, 1.0f),
				new UIColor(0.80f, 0.00f, 0.00f, 1.0f),
				new UIColor(0.88f, 0.40f, 0.40f, 1.0f)};

			this.greenColors = new UIColor[] { new UIColor(0.85f, 0.92f, 0.83f, 1.0f),
				new UIColor(0.71f, 0.84f, 0.66f, 1.0f),
				new UIColor(0.58f, 0.77f, 0.49f, 1.0f) };

			this.blueColors  = new UIColor[] { new UIColor(0.62f, 0.77f, 0.91f, 1.0f) ,
				new UIColor(0.44f, 0.66f, 0.86f, 1.0f),
				new UIColor(0.11f, 0.27f, 0.53f, 1.0f)};

			this.redValues = new NSNumber[] {new NSNumber(0), new NSNumber(20), new NSNumber(40), new NSNumber(100) };
			this.greenValues = new NSNumber[] {new NSNumber(0),new NSNumber(40), new NSNumber(80), new NSNumber(100) };
			this.blueValues = new NSNumber[] { new NSNumber(0), new NSNumber(10), new NSNumber(90), new NSNumber(100) };

			string[] legendStrings = new string[]{"FATS", "CARBS", "PROTEINS"};
			UIColor[] legendColors = new UIColor[] {new UIColor(0.96f, 0.80f, 0.80f, 1.0f),
				new UIColor(0.85f, 0.92f, 0.83f, 1.0f),
				new UIColor(0.62f, 0.77f, 0.91f, 1.0f)};

			for (int i=0; i < 3; i++) {
				TKView view = new TKView(new CGRect(20, 40 + i*25, 22, 22));
				view.Fill = new TKSolidFill(legendColors[i]);
				view.Shape = new TKPredefinedShape(TKShapeType.Circle, new CGSize(0, 0));
				this.View.AddSubview(view);

				UILabel label = new UILabel(new CGRect(50, 40 + i * 25, this.View.Frame.GetMaxX() - 60, 20));
				label.Text = legendStrings[i];
				label.Font = UIFont.SystemFontOfSize(15);
				label.TextColor = new UIColor(0.2f, 0.2f, 0.2f, 1);
				this.View.AddSubview(label);
			}

			this.CreateLinearGauge ();
			this.CreateRadialGauge ();
		}

		void CreateLinearGauge()
		{
			this.linearGauge = new TKLinearGauge ();
			this.View.AddSubview(this.linearGauge);

			TKGaugeLinearScale scale = new TKGaugeLinearScale ();
			this.linearGauge.AddScale (scale);

			for (int i = 0; i < 3; i++) {
				TKGaugeSegment segment = new TKGaugeSegment (this.redValues[i], this.redValues[i+1]);
				segment.Fill = new TKSolidFill(this.redColors[i]);
				segment.Location = 0.55f;
				segment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment(segment);
			}

			for (int i = 0; i < 3; i++) {
				TKGaugeSegment segment = new TKGaugeSegment (this.greenValues[i], this.greenValues[i+1]);
				segment.Fill = new TKSolidFill(this.greenColors[i]);
				segment.Location = 0.67f;
				segment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment(segment);
			}

			for (int i = 0; i < 3; i++) {
				TKGaugeSegment segment = new TKGaugeSegment (this.blueValues[i], this.blueValues[i+1]);

				segment.Fill = new TKSolidFill(this.blueColors[i]);
				segment.Location = 0.79f;
				segment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment(segment);
			}

			nfloat[] lengths = new nfloat[]{0.55f, 0.67f, 0.79f };

			for (int i = 0; i < 3 ; i++) {
				
				TKGaugeNeedle needle = new TKGaugeNeedle ();
				needle.Value = this.r.Next (100);
				needle.Fill = new TKSolidFill(UIColor.Gray);
				needle.Length =1 - lengths[i];
				scale.AddIndicator(needle);
			}
		}

		void CreateRadialGauge()
		{
			this.radialGauge = new TKRadialGauge ();
			this.View.AddSubview(this.radialGauge);

			TKGaugeRadialScale scale = new TKGaugeRadialScale ();
			scale.Radius = 0.76f;
			scale.Ticks.Position = TKGaugeTicksPosition.Outer;
			scale.Labels.Position = TKGaugeLabelsPosition.Outer;
			scale.Labels.Offset = 0.15f;
			scale.Ticks.Offset = 0.05f;

			this.radialGauge.AddScale (scale);

			for (int i = 0; i < 3; i++) {
				TKGaugeSegment segment = new TKGaugeSegment (this.redValues[i], this.redValues[i+1]);
				segment.Fill = new TKSolidFill(this.redColors[i]);
				segment.Location = 0.76f;
				segment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment(segment);
			}

			for (int i = 0; i < 3; i++) {
				TKGaugeSegment segment = new TKGaugeSegment (this.greenValues[i], this.greenValues[i+1]);
				segment.Fill = new TKSolidFill(this.greenColors[i]);
				segment.Location = 0.64f;
				segment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment(segment);
			}

			for (int i = 0; i < 3; i++) {
				TKGaugeSegment segment = new TKGaugeSegment (this.blueValues[i], this.blueValues[i+1]);
				segment.Fill = new TKSolidFill(this.blueColors[i]);
				segment.Location = 0.52f;
				segment.Cap = TKGaugeSegmentCap.Round;
				scale.AddSegment(segment);
			}

			nfloat[] lengths = new nfloat[]{ 0.76f, 0.64f, 0.52f };

			for (int i = 0; i < 3 ; i++) {
				TKGaugeNeedle needle = new TKGaugeNeedle ();
				needle.Value =  this.r.Next (100);
				needle.Fill = new TKSolidFill(UIColor.Gray);
				needle.Length =  lengths[i];
				scale.AddIndicator(needle);
			}
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();

			CGRect bounds = this.View.Bounds;
			CGSize size = this.View.Bounds.Size;
			nfloat offset = 20;
			nfloat linearHeight = 150;

			if (UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeLeft ||  UIDevice.CurrentDevice.Orientation == UIDeviceOrientation.LandscapeRight) {
				nfloat width = (bounds.Width - offset* 3)/2;
				nfloat height = bounds.Height - offset*2;
				this.linearGauge.Frame = new CGRect(offset, offset+ (size.Height - linearHeight)/2 , width, linearHeight);
				this.radialGauge.Frame = new CGRect(2*offset + width, offset + (size.Height - height)/2, width, height);
			} else {
				nfloat width = bounds.Width - offset*2;
				nfloat height = (bounds.Height - offset* 3)/2;
				this.linearGauge.Frame = new CGRect(offset, offset * 4, width, linearHeight);
				this.radialGauge.Frame = new CGRect(offset, size.Height/2, width, height + offset*2);
			}

		}
	}
}

