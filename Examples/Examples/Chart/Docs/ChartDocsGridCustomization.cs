using System;
using TelerikUI;
using CoreGraphics;
using Foundation;
using UIKit;

namespace Examples
{
	public class ChartDocsGridCustomization
	{
		TKChart chart = new TKChart();

		void snippet1 ()
		{
			// >> chart-grid-colorful-cs
			var gridStyle = chart.GridStyle;
			gridStyle.VerticalLineStroke = new TKStroke (UIColor.Black);
			gridStyle.VerticalLineAlternateStroke = new TKStroke (UIColor.Black);
			gridStyle.VerticalLinesHidden = false;
			gridStyle.VerticalFill = null;
			gridStyle.VerticalAlternateFill = null; 

			gridStyle.HorizontalLineStroke = new TKStroke (UIColor.Red);
			gridStyle.HorizontalLineAlternateStroke =new  TKStroke (UIColor.Blue);
			gridStyle.HorizontalFill = null;
			gridStyle.HorizontalAlternateFill = null;
			gridStyle.HorizontalLinesHidden = false;
			// << chart-grid-colorful-cs
		}

		void snippet2()
		{
			// >> chart-grid-remove-vertical-cs
			var gridStyle = chart.GridStyle;

			gridStyle.VerticalLinesHidden = true;
			gridStyle.VerticalFill = null;
			gridStyle.VerticalAlternateFill = null;  

			gridStyle.HorizontalLineStroke = new TKStroke (UIColor.Red);
			gridStyle.HorizontalLineAlternateStroke = new TKStroke (UIColor.Blue);
			gridStyle.HorizontalFill = null;
			gridStyle.HorizontalAlternateFill = null;
			gridStyle.HorizontalLinesHidden = false;
			// << chart-grid-remove-vertical-cs
		}

		void snippet3()
		{
			// >> chart-grid-alternate-horizontal-cs
			var gridStyle = chart.GridStyle;

			gridStyle.HorizontalLineStroke = new TKStroke (UIColor.FromWhiteAlpha(215.0f / 255.0f, 1.0f));
			gridStyle.HorizontalLineAlternateStroke = new TKStroke (UIColor.FromWhiteAlpha (215.0f / 255.0f, 1.0f));
			gridStyle.HorizontalLinesHidden = false;
			gridStyle.HorizontalFill = new TKSolidFill (UIColor.FromWhiteAlpha (228.0f / 255.0f, 1.0f));
			gridStyle.HorizontalAlternateFill = new TKSolidFill (UIColor.White);

			gridStyle.VerticalFill = null;
			gridStyle.VerticalAlternateFill = null;
			gridStyle.VerticalLinesHidden = true;
			// << chart-grid-alternate-horizontal-cs
		}

		void snippet4()
		{
			// >> chart-grid-alternate-vertical-cs
			var gridStyle = chart.GridStyle;

			gridStyle.VerticalLineStroke = new TKStroke (UIColor.FromWhiteAlpha (215.0f / 255.0f, 1.0f));
			gridStyle.VerticalLineAlternateStroke = new TKStroke (UIColor.FromWhiteAlpha (215.0f / 255.0f, 1.0f));
			gridStyle.VerticalLinesHidden = false;
			gridStyle.VerticalFill = new TKSolidFill (UIColor.FromWhiteAlpha (228.0f / 255.0f, 1.0f));
			gridStyle.VerticalAlternateFill = new TKSolidFill (UIColor.White);

			gridStyle.HorizontalFill = null;
			gridStyle.HorizontalAlternateFill = null;
			gridStyle.HorizontalLinesHidden = true;
			// << chart-grid-alternate-vertical-cs
		}

		void snippet5()
		{
			// >> chart-grid-combining-cs
			var gridStyle = chart.GridStyle;

			gridStyle.HorizontalLineStroke = new TKStroke (UIColor.FromWhiteAlpha (215.0f / 255.0f, 1.0f));
			gridStyle.HorizontalLineAlternateStroke = new TKStroke (UIColor.FromWhiteAlpha (215.0f / 255.0f, 1.0f));
			gridStyle.HorizontalFill = new TKSolidFill(UIColor.FromWhiteAlpha (228.0f / 255.0f, 1.0f));
			gridStyle.HorizontalAlternateFill = new TKSolidFill (UIColor.White);
			gridStyle.HorizontalLinesHidden = false;

			gridStyle.VerticalLineStroke = new TKStroke (UIColor.FromWhiteAlpha (215.0f / 255.0f, 1.0f));
			gridStyle.VerticalLineAlternateStroke = new TKStroke (UIColor.FromWhiteAlpha (215.0f / 255.0f, 1.0f));
			gridStyle.VerticalLinesHidden = false;
			gridStyle.VerticalFill = new TKSolidFill (new UIColor (1.0f, 1.0f, 0.0f, 0.1f));
			gridStyle.VerticalAlternateFill = new TKSolidFill (new UIColor (0.0f, 1.0f, 0.0f, 0.1f));
			// << chart-grid-combining-cs

			/*
			//TODO
			// >> chart-grid-first-cs
			gridStyle.DrawOrder = TKChartGridDrawMode.VerticalFirst;
			// << chart-grid-first-cs
			*/

			// >> chart-grid-bg-fill-cs
			gridStyle.BackgroundFill = new TKSolidFill (UIColor.White);
			// << chart-grid-bg-fill-cs

			// >> chart-grid-img-fill-cs
			gridStyle.BackgroundFill = new TKSolidFill(UIColor.FromPatternImage(new UIImage("telerk_logo.png")));
			// << chart-grid-img-fill-cs


		}

		void snippet6()
		{
			// >> chart-grid-z-cs
			var gridStyle = chart.GridStyle;

			gridStyle.HorizontalLineStroke = new TKStroke (UIColor.FromWhiteAlpha (215.0f / 255.0f, 1.0f));
			gridStyle.HorizontalLineAlternateStroke = new TKStroke (UIColor.FromWhiteAlpha (215.0f / 255.0f, 1.0f));
			gridStyle.HorizontalLinesHidden = false;
			gridStyle.HorizontalFill = new TKSolidFill (UIColor.FromWhiteAlpha (228.0f / 255.0f, 1.0f));
			gridStyle.HorizontalAlternateFill = new TKSolidFill (UIColor.Clear);

			gridStyle.VerticalFill = null;
			gridStyle.VerticalAlternateFill = null;
			gridStyle.VerticalLinesHidden = true;

			gridStyle.ZPosition = TKChartGridZPosition.AboveSeries;
			// << chart-grid-z-cs
		}
	}
}

