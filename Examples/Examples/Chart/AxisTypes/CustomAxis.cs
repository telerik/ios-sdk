using System;
using TelerikUI;
using CoreGraphics;
using UIKit;
using Foundation;
using System.Collections.Generic;

namespace Examples
{
	[Register("CustomAxis")]
	public class CustomAxis :XamarinExampleViewController
	{
		TKChart chart = new TKChart();
		Random r = new Random();
		string[] names = new string[] { "Upper class", "Upper middle class", "Middle class", "Lower middle class" };
		nfloat[] offsets = new nfloat[] { 350, 250, 150, 100 };
		UIColor[] strokes = new UIColor[]{ new UIColor(0.5f, 0.5f, 0.5f, 0.5f),
			new UIColor(0.3f, 0.3f, 0.3f, 0.6f),
			new UIColor(0.1f, 0.1f, 0.1f, 0.6f),
			new UIColor(0.1f, 0.1f, 0.1f, 0.6f)
		};
		UIColor[][] fills = new UIColor[][]{ new UIColor[]{ new UIColor(0.78f, 0.81f, 0.86f, 0.5f), new UIColor(0.5f, 0.5f, 0.5f, 0.5f) },
			new UIColor[] { new UIColor(0.78f, 0.76f, 0.70f, 1.0f), new UIColor(0.5f, 0.5f, 0.5f, 0.5f) },
			new UIColor[] { new UIColor(0.80f, 0.73f, 0.67f, 1.0f), new UIColor(0.5f, 0.5f, 0.5f, 0.5f) },
			new UIColor[] { new UIColor(0.70f, 0.58f, 0.58f, 1.0f), new UIColor(0.5f, 0.5f, 0.5f, 0.5f) }
		};

		// >> chart-custom-axis-render-cs
		class MyAxis : TKChartNumericAxis
		{
			public MyAxis (NSNumber minimum, NSNumber maximum)
				: base(minimum, maximum)
			{
			}

			public override TKChartAxisRender Render (TKChart chart)
			{				return new AxisRender (this, chart);
			}
		}
		// << chart-custom-axis-render-cs

		// >> chart-custom-axis-draw-cs
		public class AxisRender: TKChartAxisRender
		{
			public AxisRender (TKChartAxis axis, TKChart chart)
				: base(axis, chart)
			{
			}

			public override void DrawInContext (CoreGraphics.CGContext ctx)
			{
				CGRect rect = this.BoundsRect();
				CGColorSpace colorSpace = CGColorSpace.CreateDeviceRGB ();
				nfloat [] colors = new nfloat[] {
					0.42f, 0.66f, 0.31f, 1.0f,
					0.95f, 0.76f, 0.20f, 1.0f,
					0.80f, 0.25f, 0.15f, 1.0f
				};

				CGGradient gradient = new CGGradient (colorSpace, colors, null);

				nuint tickSpaces = this.Axis.MajorTickCount - 1;
				nuint pointsCount = 5;
				if (this.Chart.Frame.Size.Height < this.Chart.Frame.Size.Width) {
					pointsCount = 3;
				}

				nfloat diameter = 8;
				nfloat spaceHeight = rect.Size.Height / tickSpaces;
				nfloat spacing = (spaceHeight - (pointsCount * diameter)) / (pointsCount + 1);
				nuint allPointsCount = pointsCount * tickSpaces;
				CGPath multipleCirclePath = new CGPath ();
				double y = rect.GetMinY() +  diameter / 2.0f  + spacing;

				for (uint i = 1; i <= allPointsCount; i++) {
					CGPoint center = new CGPoint (rect.GetMidX (), y);
					CGPath path = new CGPath ();
					path.AddArc (center.X, center.Y, (nfloat)diameter/2.0f, 0, (nfloat)Math.PI * 2, true);
					multipleCirclePath.AddPath (path);
					y += spacing + diameter;
					if (i % pointsCount == 0) {
						y += spacing;
					}
				}

				ctx.SaveState ();
				ctx.AddPath (multipleCirclePath);
				ctx.Clip ();
				CGPoint startPoint = new CGPoint (rect.GetMidX (), rect.GetMinY ());
				CGPoint endPoint = new CGPoint (rect.GetMidX (), rect.GetMaxY());
				ctx.DrawLinearGradient (gradient, startPoint, endPoint, 0);
				ctx.RestoreState ();

				base.DrawInContext (ctx);
			}

		}
		// << chart-custom-axis-draw-cs
			
		public override void ViewDidLoad ()
		{
			AddOption ("Custom Labels", CustomLabelsSelected);
			AddOption ("Custom Axis Drawing", CustomDrawingSelected);

			base.ViewDidLoad ();
			
			this.chart.Frame = this.View.Bounds;
			this.chart.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			chart.Legend.Hidden = false;
			this.View.AddSubview (this.chart);

			this.CustomLabelsSelected();
		}

		private void CustomDrawingSelected() 
		{
			chart.RemoveAllData ();

			MyAxis axis = new MyAxis (new NSNumber (100), new NSNumber (450));
			chart.YAxis = axis;

			List<TKChartDataPoint> items = new List<TKChartDataPoint> ();

			for (int i = 0; i< names.Length; i++) {

				for (int j = 0; j<5; j++) {
					NSDate date = this.DateWithYear(j + 2002, 1, 1);
					TKChartDataPoint point = new TKChartDataPoint(date, new NSNumber(this.r.Next(50) + offsets[i]));
					items.Add (point);
				}

				TKChartSplineAreaSeries series = new TKChartSplineAreaSeries(items.ToArray());
				series.Title = names[i];
				// >> chart-style-fill-cs
				series.Style.Palette = new TKChartPalette ();
				TKChartPaletteItem palleteItem = new TKChartPaletteItem ();
				palleteItem.Stroke = new TKStroke(strokes[i], 1.5f);
				palleteItem.Fill = new TKLinearGradientFill (fills[i], new CGPoint(0, 0), new CGPoint(1, 1));
				series.Style.Palette.AddPaletteItem(palleteItem);
				// << chart-style-fill-cs
				chart.AddSeries(series);
				items.Clear ();
			}

		}

		private void CustomLabelsSelected()
		{
			chart.RemoveAllData ();

			List<TKChartDataPoint> items = new List<TKChartDataPoint> ();

			for (int i = 0; i< names.Length; i++) {

				for (int j = 0; j<5; j++) {
					NSDate date = this.DateWithYear(j + 2002, 1, 1);
					TKChartDataPoint point = new TKChartDataPoint(date, new NSNumber(this.r.Next(50) + offsets[i]));
					items.Add (point);
				}

				TKChartSplineAreaSeries series = new TKChartSplineAreaSeries(items.ToArray());
				series.Title = names[i];
				chart.AddSeries(series);
				items.Clear ();
			}

			// >> chart-custom-axis-labels-cs
			this.chart.YAxis.CustomLabels = new NSDictionary(new NSNumber(100), UIColor.Blue, 
				new NSNumber(200), UIColor.Yellow, 
				new NSNumber(400), UIColor.Red);
			// << chart-custom-axis-labels-cs
		}

		public NSDate DateWithYear(int year, int month, int day)
		{
			NSCalendar calendar = new NSCalendar (NSCalendarType.Gregorian);
			NSDateComponents components = new NSDateComponents ();
			components.Year = year;
			components.Month = month;
			components.Day = day;
			return calendar.DateFromComponents (components);
		}
	}
}

