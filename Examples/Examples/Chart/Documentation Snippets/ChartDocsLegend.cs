using System;
using TelerikUI;
using CoreGraphics;
using UIKit;

namespace Examples
{
	public class ChartDocsLegend : UIViewController
	{
		TKChart chart = new TKChart();
		public ChartDocsLegend ()
		{
		}
			
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			chart.Legend.Hidden = false;

			chart.Legend.Style.Position = TKChartLegendPosition.Bottom;

			// >> chart-legend-offset-pos-cs
			chart.Legend.Style.Position = TKChartLegendPosition.Floating;
			chart.Legend.Style.OffsetOrigin = TKChartLegendOffsetOrigin.TopLeft;
			chart.Legend.Style.Offset = new UIOffset(10, 10);
			// << chart-legend-offset-pos-cs
		
			// >> chart-legend-title-cs
			chart.Legend.TitleLabel.Text = "Companies";
			chart.Legend.ShowTitle = true;
			// << chart-legend-title-cs

			// >> chart-legend-outside-cs
			var legendView = new TKChartLegendView (chart);
			legendView.Frame = new CGRect (20, 20, 320, 100);
			this.View.AddSubview(legendView);
			legendView.ReloadItems ();
			// << chart-legend-outside-cs

		}
	}
}

