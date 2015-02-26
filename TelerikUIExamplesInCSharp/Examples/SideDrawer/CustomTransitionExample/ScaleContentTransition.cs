using System;

using Foundation;
using UIKit;
using CoreAnimation;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
	public class ScaleContentTransition : TKSideDrawerTransition
	{
		public ScaleContentTransition(TKSideDrawer sideDrawer) : base(sideDrawer)
		{
		}

		public override void Show ()
		{
			if (!this.SideDrawer.IsVisible) {
				this.SideDrawer.Frame = new CGRect (0, 0, (float)this.SideDrawer.Width, this.SideDrawer.Superview.Frame.Size.Height);
			}

			this.TransitionBegan (true);
			UIView.Animate (0.36, delegate {
				this.SideDrawer.Hostview.Transform = CGAffineTransform.MakeScale(0.85f, 0.85f);
				this.SideDrawer.Hostview.Frame = new CGRect((float)this.SideDrawer.Width, 44, 
					this.SideDrawer.Hostview.Frame.Size.Width, this.SideDrawer.Hostview.Frame.Size.Height);
			}, delegate {
				this.TransitionEnded(true);
			});
		}

		public override void Dismiss ()
		{
			this.TransitionBegan (false);
			UIView.Animate (0.36, delegate {
				this.SideDrawer.Hostview.Transform = CGAffineTransform.MakeIdentity();
				this.SideDrawer.Hostview.Frame = new CGRect(0, 0, this.SideDrawer.Hostview.Frame.Size.Width, this.SideDrawer.Hostview.Frame.Size.Height);
			}, delegate {
				this.TransitionEnded(false);
			});
		}

		public override void HandleGesture (UIGestureRecognizer gestureRecognizer)
		{
			if (!this.SideDrawer.IsVisible) {
				this.SideDrawer.Superview.BringSubviewToFront (this.SideDrawer.Hostview);
				this.SideDrawer.Frame = new CGRect (0, 0, (float)this.SideDrawer.Width, this.SideDrawer.Superview.Frame.Size.Height);
				this.SideDrawer.Hidden = false;
			}

			if (gestureRecognizer.State == UIGestureRecognizerState.Changed) {
				this.HandlePan ((UIPanGestureRecognizer)gestureRecognizer);
				((UIPanGestureRecognizer)gestureRecognizer).SetTranslation (CGPoint.Empty, this.SideDrawer.Superview);
			}

			if (gestureRecognizer.State == UIGestureRecognizerState.Ended) {
				if (this.SideDrawer.Hostview.Frame.X > this.SideDrawer.Width / 2) {
					this.Show ();
				} else {
					this.Dismiss ();
				}
			}
		}

		public void HandlePan (UIPanGestureRecognizer gesture)
		{
			CGRect hostFrame = this.SideDrawer.Hostview.Frame;
			CGRect  bounds = this.SideDrawer.Superview.Bounds;
			CGPoint translation = gesture.TranslationInView (this.SideDrawer.Superview);
			float originX = (float)(hostFrame.X + translation.X);

			float scaleFactor = this.CalculateScaleFactor ();
			this.SideDrawer.Hostview.Transform = CGAffineTransform.MakeScale (1 - scaleFactor, 1 - scaleFactor);

			if (translation.X < 0 && originX <= bounds.X) {
				this.SideDrawer.Hostview.Center = new CGPoint ((float) bounds.GetMidX (), (float) bounds.GetMidY ());
				return;
			}

			if (translation.X > 0 && originX >= this.SideDrawer.Width) {
				this.SideDrawer.Hostview.Frame = new CGRect ((float)this.SideDrawer.Width, 44, this.SideDrawer.Hostview.Frame.Size.Width, this.SideDrawer.Hostview.Frame.Size.Height);
				return;
			}

			this.SideDrawer.Hostview.Center = new CGPoint (this.SideDrawer.Hostview.Center.X + translation.X, this.SideDrawer.Hostview.Center.Y);
		}

		public float CalculateScaleFactor ()
		{
			float offset = (float)(this.SideDrawer.Superview.Bounds.Size.Width - (this.SideDrawer.Superview.Bounds.Size.Width - this.SideDrawer.Hostview.Frame.X));
			float spp = (1.0f - 0.85f) / (float)this.SideDrawer.Width;
			return offset * spp;
		}

		public override void TransitionBegan (bool showing)
		{
			if (showing) {
				this.SideDrawer.Hidden = false;
				this.SideDrawer.Superview.BringSubviewToFront (this.SideDrawer.Hostview);
				this.SideDrawer.Hostview.UserInteractionEnabled = false;
			}
		}

		public override void TransitionEnded (bool showing)
		{
			if (!showing) {
				this.SideDrawer.Hidden = true;
				this.SideDrawer.Superview.BringSubviewToFront (this.SideDrawer.Hostview);
				this.SideDrawer.Hostview.UserInteractionEnabled = true;
			}
		}
	}
}

