using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	[Register("AlertCustomize")]
	public class AlertCustomize : XamarinExampleViewController
	{
		AlertDelegate alertDelegate = new AlertDelegate();

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			UIButton_Circle.Button (this.View, "Show Alert", this, Show);
		}

		public void Show(Object sender, EventArgs e)
		{
			TKAlert alert = new TKAlert ();
			alert.Delegate = alertDelegate;
			alert.Style.CornerRadius = 3;
			// >> alert-parallax-cs
			alert.AllowParallaxEffect = true;
			// << alert-parallax-cs
			alert.Title = "Warning";
			alert.Message = "Are you ready for TKAlert?";
			alert.Style.ButtonSpacing = 10;
			alert.Style.ButtonsInset = new UIEdgeInsets (5, 5, 5, 5);
			alert.Style.ContentSeparatorWidth = 0;
			alert.Style.MessageColor = new UIColor(0.349f, 0.349f, 0.349f, 1.00f);
			alert.Style.TitleSeparatorWidth = -0.5f;
			alert.Style.ContentSeparatorWidth = 0;
			alert.AlertView.Layer.ShadowOpacity = 0.6f;
			alert.AlertView.Layer.ShadowRadius = 3;
			alert.AlertView.Layer.ShadowOffset = new CGSize(0, 0);
			alert.AlertView.Layer.MasksToBounds = false;
			alert.Style.BackgroundColor = UIColor.White;
			alert.ButtonsView.BackgroundColor = UIColor.White;
			alert.Style.ShowAnimation = TKAlertAnimation.SlideFromTop;

			TKAlertAction action = alert.AddActionWithTitle ("Yes", (TKAlert al, TKAlertAction act) => {
				return true;
			});

			action.BackgroundColor = new UIColor(0.882f, 0.882f, 0.882f, 1.00f);
			action.TitleColor = new UIColor(0.302f, 0.302f, 0.302f, 1.00f);
			action.CornerRadius = 3;

			action = alert.AddActionWithTitle ("No", (TKAlert al, TKAlertAction act) => {
				return true;
			});

			action.BackgroundColor = new UIColor(0.961f, 0.369f, 0.306f, 1.00f);
			action.TitleColor = new UIColor(1f, 1f, 1f, 1f);
			action.CornerRadius = 3;

			alert.Show(true);
		}
	}

	class AlertDelegate : TKAlertDelegate
	{
		public override void DidShow (TKAlert alert)
		{
			TKView view = new TKView ();
			view.Frame = new CGRect (20, -30, 60, 60);
			view.Shape = new TKPredefinedShape (TKShapeType.Circle, new CGSize (0, 0));
			view.Fill = new TKSolidFill(new UIColor(0.961f, 0.369f, 0.306f, 1f));
			view.Stroke = new TKStroke (new UIColor (1f, 1f, 1f, 1f), 3.0f);
			view.Transform = CGAffineTransform.MakeScale (0.1f, 0.1f);
			alert.AlertView.AddSubview (view);

			UIView.AnimateNotify (0.7f, 0.0f, 0.3f, 0.2f, UIViewAnimationOptions.CurveEaseInOut, () => {
				view.Transform = CGAffineTransform.MakeScale(1f, 1f);
			}, (bool finished) => {
			});
     	}
	}
}

