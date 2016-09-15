using System;
using TelerikUI;
using Foundation;
using UIKit;
using CoreGraphics;
using System.Collections.Generic;

namespace Examples
{
	public class ChartDocsCustomDrawing
	{
		public ChartDocsCustomDrawing ()
		{
		}

		TKChart chart = new TKChart();

		void snippet1 ()
		{
			// >> chart-drawing-solid-fill-cs
			var fill = new TKSolidFill (UIColor.Red);
			// << chart-drawing-solid-fill-cs
			Console.WriteLine (fill);
		}

		void snippet2()
		{
			// >> chart-drawing-solid-fill-radius-cs
			var fill = new TKSolidFill (UIColor.Red, 5.0f);
			// << chart-drawing-solid-fill-radius-cs
			Console.WriteLine (fill);
		}

		void snippet3()
		{
			// >> chart-drawing-round-corners-cs
			var fill = new TKSolidFill (new UIColor (1.0f, 0.0f, 0.0f, 0.5f), 8.0f);
			fill.Corners = UIRectCorner.TopLeft | UIRectCorner.BottomRight;
			// << chart-drawing-round-corners-cs
			Console.WriteLine (fill);

		}

		void snippet4()
		{
			// >> chart-drawing-gradient-cs
			var fill = new TKLinearGradientFill (new UIColor[] {
				new UIColor (0.0f, 1.0f, 0.0f, 0.6f),
				new UIColor (1.0f, 0.0f, 0.0f, 0.6f),
				new UIColor (0.0f, 0.0f, 1.0f, 0.6f)
			}, 
				new CGPoint(0, 0), 
				new CGPoint(1, 1));
			// << chart-drawing-gradient-cs
			Console.WriteLine (fill);
		}

		void snippet5()
		{
			// >> chart-drawing-gradient-direction-cs
			var fill = new TKLinearGradientFill (new UIColor[] {
				new UIColor (0.0f, 1.0f, 0.0f, 0.6f),
				new UIColor (1.0f, 0.0f, 0.0f, 0.6f),
				new UIColor (0.0f, 0.0f, 1.0f, 0.6f)
			},
				new NSObject[] { new NSNumber(0.6), new NSNumber(0.8), new NSNumber(1.0) },
				new CGPoint(0, 0), 
				new CGPoint(1, 1));
			// << chart-drawing-gradient-direction-cs
			Console.WriteLine (fill);
		}

		void snippet6()
		{
			// >> chart-drawing-gradient-radial-cs
			var fill = new TKRadialGradientFill (new UIColor[] { 
				new UIColor (0.0f, 1.0f, 0.0f, 0.7f),
				new UIColor (1.0f, 0.0f, 0.0f, 0.0f) 
			},
				new CGPoint (0.5f, 0.5f),
				0.7f,
				new CGPoint (0, 1),
				0.3f,
				TKGradientRadiusType.RectMax);
			// << chart-drawing-gradient-radial-cs
			Console.WriteLine (fill);
		}

		void snippet7()
		{
			// >> chart-drawing-image-fill-cs
			var fill = new TKImageFill (new UIImage ("pattern1.png"), 4.0f);
			fill.ResizingMode = TKImageFillResizingMode.Tile;
			// << chart-drawing-image-fill-cs
		}

		void snippet8()
		{
			// >> chart-drawing-image-fill-stretch-cs
			var fill = new TKImageFill (new UIImage ("building1.png"), 4.0f);
			// << chart-drawing-image-fill-stretch-cs
			Console.WriteLine (fill);
		}

		void snippet9()
		{
			// >> chart-drawing-image-resize-cs
			UIImage image = new UIImage ("pattern2.png");
			var fill = new TKImageFill (image.CreateResizableImage (new UIEdgeInsets (10, 10, 10, 10)));
			fill.ResizingMode = TKImageFillResizingMode.None;
			// << chart-drawing-image-resize-cs
		}

		void snippet10()
		{
			// >> chart-drawing-stroke-cs
			var stroke = new TKStroke (UIColor.Blue);
			// << chart-drawing-stroke-cs
			Console.WriteLine (stroke);
		}

		void snippet11()
		{
			// >> chart-drawing-stroke-rounded-corners-cs
			var stroke = new TKStroke (UIColor.Blue, 1.0f);
			stroke.CornerRadius = 5.0f;
			// << chart-drawing-stroke-rounded-corners-cs
		}

		void snippet12()
		{
			// >> chart-drawing-stroke-dashed-cs
			var stroke = new TKStroke (UIColor.Blue, 1.0f);
			stroke.CornerRadius = 5.0f;
			stroke.DashPattern = new NSNumber[] { new NSNumber(2), new NSNumber(2), new NSNumber(5), new NSNumber(2) };
			// << chart-drawing-stroke-dashed-cs
		}

		void snippet13()
		{
			// >> chart-drawing-stroke-gradient-cs
			var fill = new TKLinearGradientFill (new UIColor[] {
				new UIColor (0.0f, 1.0f, 0.0f, 0.6f),
				new UIColor (1.0f, 0.0f, 0.0f, 0.6f),
				new UIColor (0.0f, 0.0f, 1.0f, 0.6f)
			}, new CGPoint(0, 0), new CGPoint(1, 1));
			var stroke = new TKStroke (fill, 1.0f);
			stroke.CornerRadius = 5.0f;
			// << chart-drawing-stroke-gradient-cs
		}

		void snippet14()
		{
			// >> chart-drawing-stroke-combined-cs
			var fill = new TKLinearGradientFill(new UIColor[] {
				new UIColor (0.0f, 1.0f, 0.0f, 0.6f),
				new UIColor (1.0f, 0.0f, 0.0f, 0.6f),
				new UIColor (0.0f, 0.0f, 1.0f, 0.6f)
			}, new CGPoint(0, 0), new CGPoint(1, 1));
			var stroke = new TKStroke (fill, 1.0f);
			stroke.CornerRadius = 5.0f;
			stroke.DashPattern = new NSNumber[] { new NSNumber(2), new NSNumber(2), new NSNumber(5), new NSNumber(2) };
			stroke.Corners = UIRectCorner.TopRight | UIRectCorner.BottomLeft;
			// << chart-drawing-stroke-combined-cs
		}

		void snippet15()
		{
			// >> chart-drawing-pallete-cs
			TKChartSeries series = null;
			series.Style.Palette = new TKChartPalette();
			// << chart-drawing-pallete-cs

			// >> chart-drawing-pallete-mode-index-cs
			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
			// << chart-drawing-pallete-mode-index-cs

			// >> chart-drawing-pallete-mode-series-cs
			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseSeriesIndex;
			// << chart-drawing-pallete-mode-series-cs

			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
		}

		void snippet16()
		{
			// >> chart-drawing-cycling-cs
			List<TKChartDataPoint> gdpInPoundsPoints = null;

			var series = new TKChartColumnSeries (gdpInPoundsPoints.ToArray());
			series.Style.Palette = new TKChartPalette ();

			var redFill = new TKSolidFill (UIColor.Red);
			series.Style.Palette.AddPaletteItem (new TKChartPaletteItem (redFill));

			var blueFill = new TKSolidFill (UIColor.Blue);
			series.Style.Palette.AddPaletteItem (new TKChartPaletteItem (blueFill));

			var greenFill = new TKSolidFill (UIColor.Green);
			series.Style.Palette.AddPaletteItem (new TKChartPaletteItem (greenFill));

			series.Style.PaletteMode = TKChartSeriesStylePaletteMode.UseItemIndex;
			chart.AddSeries (series);
			// << chart-drawing-cycling-cs
		}

		void snippet17()
		{
			TKChartSeries series = null;

			// >> chart-drawing-pallete-items-cs
			var paletteItem1 = new TKChartPaletteItem (new TKSolidFill (UIColor.Red));
			var paletteItem2 = new TKChartPaletteItem(new TKStroke(UIColor.Blue));
			var plaetteItem3 = new TKChartPaletteItem(new TKStroke(UIColor.Blue), new TKSolidFill(UIColor.Red));

			series.Style.Palette.AddPaletteItem (paletteItem1);
			// << chart-drawing-pallete-items-cs
			Console.WriteLine (paletteItem2);
			Console.WriteLine (plaetteItem3);
		}

		void snippet18()
		{
			TKChartSeries series = null;
			// >> chart-drawing-pallete-items-arrays-cs
			series.Style.Palette = new TKChartPalette ();
			var redFill = new TKSolidFill (UIColor.Red, 2.0f);
			var stroke1 = new TKStroke (UIColor.Yellow, 1.0f);
			stroke1.CornerRadius = 2.0f;
			stroke1.Insets = new UIEdgeInsets (1, 1, 1, 1);
			var stroke2 = new TKStroke (UIColor.Black, 1.0f);
			stroke2.CornerRadius = 2.0f;
			series.Style.Palette.AddPaletteItem(new TKChartPaletteItem(new TKDrawing[] { redFill, stroke1, stroke2 }));
			// << chart-drawing-pallete-items-arrays-cs

			// >> chart-drawing-pallete-point-cs
			series.Style.PointShape = new TKPredefinedShape (TKShapeType.Rhombus, new CGSize (15, 15));
			// << chart-drawing-pallete-point-cs

		}
	}
}

