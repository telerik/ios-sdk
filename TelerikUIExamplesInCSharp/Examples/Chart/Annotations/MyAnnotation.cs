using System;
using System.Collections.Generic;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using TelerikUI;


namespace Examples
{
	public class MyAnnotation: TKChartPointAnnotation
	{
		PointF center;

		public TKShape Shape { get; set; }

		public TKFill Fill { get; set; }

		public TKStroke Stroke { get; set; }

		public MyAnnotation (TKPredefinedShape shape, NSObject x, NSObject y, TKChartSeries series)
			: base(x, y, series)
		{
			this.Shape = shape;
		}

		public override void LayoutInRect (RectangleF bounds)
		{
			center = this.LocationInRect (bounds);
			center.X -= Shape.Size.Width / 2.0f;
			center.Y -= Shape.Size.Height / 2.0f;
		}

		public override void DrawInContext (MonoTouch.CoreGraphics.CGContext context)
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

