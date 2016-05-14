using System;
using System.Collections.Generic;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;
using CoreAnimation;

namespace Examples
{
	[Register("MyAnnotation")]
	public class MyAnnotation: TKChartPointAnnotation
	{
		CGPoint center;

		public TKShape Shape { get; set; }

		public TKFill Fill { get; set; }

		public TKStroke Stroke { get; set; }

		public MyAnnotation (TKPredefinedShape shape, NSObject x, NSObject y, TKChartSeries series)
			: base(x, y, series)
		{
			this.Shape = shape;
		}

		public override void LayoutInRect (CGRect bounds, TKChart chart, CALayer layer)
		{
			center = this.LocationInRect (bounds, chart);
			center.X -= Shape.Size.Width / 2.0f;
			center.Y -= Shape.Size.Height / 2.0f;
		}

		public override void DrawInContext (CGContext context)
		{
			List<TKDrawing> drawables = new List<TKDrawing> ();
			if (this.Fill != null) {
				drawables.Add (this.Fill);
			} 
			if (this.Stroke != null){
				drawables.Add (this.Stroke);
			}
			Shape.DrawInContext (context, center, drawables.ToArray());
		}
	}
}

