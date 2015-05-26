using System;
using TelerikUI;
using UIKit;
using CoreGraphics;

namespace Examples
{
	public class AnimationListCell: TKListViewCell
	{
		public AnimationListCell (IntPtr ptr) : base(ptr)
		{    
			this.ImageView.ContentMode = UIViewContentMode.ScaleAspectFill;

			var view = this.BackgroundView as TKView;
			view.Stroke = new TKStroke(new UIColor(0.9f, 0.9f, 0.9f, 0.9f), 0.5f);

			this.ContentView.Layer.MasksToBounds = true;
		}

		public override void LayoutSubviews ()
		{
			base.LayoutSubviews ();
			this.ContentView.Frame = CGRect.Inflate (this.ContentView.Frame, -1, -1);
		}
	}
}

